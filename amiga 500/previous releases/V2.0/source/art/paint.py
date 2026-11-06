"""A small painting kit for Amiga-style pictures (320x192, up to 32 colours).

Everything is painted in full colour at twice the size (640x384), with gradients,
textures, bevels, shadows and glows, then scaled down and reduced to an Amiga
palette (12 bit colours) with ordered dithering. Sky pixels go to a colour register
that the copper changes on every line, and animated pixels (stars, fire, water,
lights) go to colour cycling registers.

Coordinates are always in the 320x192 picture.
"""
import numpy as np
from PIL import Image, ImageDraw
from scipy import ndimage

W, H = 320, 192
S = 2                         # supersampling
AA = 2                        # extra supersampling for shape masks


def rgb(h):
    """'#rrggbb' or (r,g,b) 0-255 -> float array"""
    if isinstance(h, str):
        h = h.lstrip('#')
        return np.array([int(h[i:i + 2], 16) for i in (0, 2, 4)], np.float32) / 255
    a = np.array(h, np.float32)
    return a / 255 if a.max() > 1.0 else a


def mix(a, b, t):
    t = np.asarray(t, np.float32)
    if t.ndim == 2:
        t = t[..., None]
    return a + (b - a) * t


class Canvas:
    def __init__(self, bg='#000000'):
        self.h, self.w = H * S, W * S
        self.c = np.zeros((self.h, self.w, 3), np.float32) + rgb(bg)
        self.sky = np.zeros((self.h, self.w), np.float32)
        self.anim = np.zeros((self.h, self.w), np.int16)
        self.anims = []
        ys, xs = np.mgrid[0:self.h, 0:self.w].astype(np.float32)
        self.X = (xs + 0.5) / S
        self.Y = (ys + 0.5) / S
        self.rng = np.random.default_rng(1)

    # ---------------------------------------------------------------- masks
    def _draw(self, fn):
        im = Image.new('L', (self.w * AA, self.h * AA), 0)
        d = ImageDraw.Draw(im)
        fn(d, S * AA)
        im = im.resize((self.w, self.h), Image.BOX)
        return np.asarray(im, np.float32) / 255

    def poly(self, pts):
        return self._draw(lambda d, k: d.polygon([(x * k, y * k) for x, y in pts], fill=255))

    def rect(self, x0, y0, x1, y1):
        return self.poly([(x0, y0), (x1, y0), (x1, y1), (x0, y1)])

    def ellipse(self, cx, cy, rx, ry):
        return self._draw(lambda d, k: d.ellipse([(cx - rx) * k, (cy - ry) * k, (cx + rx) * k, (cy + ry) * k], fill=255))

    def line(self, pts, width):
        def f(d, k):
            p = [(x * k, y * k) for x, y in pts]
            d.line(p, fill=255, width=max(1, int(width * k)), joint='curve')
            r = width * k / 2
            for x, y in (p[0], p[-1]):
                d.ellipse([x - r, y - r, x + r, y + r], fill=255)
        return self._draw(f)

    def pieslice(self, cx, cy, rx, ry, a0, a1):
        return self._draw(lambda d, k: d.pieslice([(cx - rx) * k, (cy - ry) * k, (cx + rx) * k, (cy + ry) * k], a0, a1, fill=255))

    def everywhere(self):
        return np.ones((self.h, self.w), np.float32)

    # ---------------------------------------------------------------- painting
    def fill(self, m, col, alpha=1.0):
        """col: colour, or a full HxWx3 array (a shader)"""
        a = m * alpha
        col = rgb(col) if isinstance(col, (str, tuple, list)) else col
        self.c = self.c * (1 - a[..., None]) + col * a[..., None]
        cover = a > 0.5
        self.anim[cover] = 0
        self.sky[cover] = 0
        return m

    def tint(self, m, factor):
        """multiply (light/dark) inside a mask; factor may be an array"""
        f = np.asarray(factor, np.float32)
        f = 1 + (f - 1) * m
        self.c = np.clip(self.c * (f[..., None] if f.ndim == 2 else f), 0, 1)

    def add(self, m, col, amount=1.0):
        self.c = np.clip(self.c + m[..., None] * rgb(col) * amount, 0, 1)

    # ---------------------------------------------------------------- shaders
    def vgrad(self, stops):
        """[(y, colour), ...] -> a vertical gradient"""
        ys = np.array([s[0] for s in stops], np.float32)
        cs = np.array([rgb(s[1]) for s in stops])
        out = np.empty((self.h, self.w, 3), np.float32)
        for i in range(3):
            out[..., i] = np.interp(self.Y, ys, cs[:, i])
        return out

    def hgrad(self, stops):
        xs = np.array([s[0] for s in stops], np.float32)
        cs = np.array([rgb(s[1]) for s in stops])
        out = np.empty((self.h, self.w, 3), np.float32)
        for i in range(3):
            out[..., i] = np.interp(self.X, xs, cs[:, i])
        return out

    def lgrad(self, p0, p1, c0, c1):
        dx, dy = p1[0] - p0[0], p1[1] - p0[1]
        t = ((self.X - p0[0]) * dx + (self.Y - p0[1]) * dy) / (dx * dx + dy * dy)
        return mix(rgb(c0), rgb(c1), np.clip(t, 0, 1))

    def rgrad(self, cx, cy, r, c0, c1, ry=None):
        ry = ry or r
        t = np.sqrt(((self.X - cx) / r) ** 2 + ((self.Y - cy) / ry) ** 2)
        return mix(rgb(c0), rgb(c1), np.clip(t, 0, 1))

    def noise(self, scale=8.0, octaves=4, seed=0, sx=None, sy=None):
        """smooth value noise 0..1 (scale = feature size in pixels)"""
        rng = np.random.default_rng(seed)
        out = np.zeros((self.h, self.w), np.float32)
        amp, tot = 1.0, 0.0
        X = self.X if sx is None else sx
        Y = self.Y if sy is None else sy
        for o in range(octaves):
            s = scale / (2 ** o)
            n = rng.random((64, 64)).astype(np.float32)
            gx, gy = X / max(s, 0.5), Y / max(s, 0.5)
            x0, y0 = np.floor(gx).astype(int), np.floor(gy).astype(int)
            fx, fy = gx - x0, gy - y0
            fx, fy = fx * fx * (3 - 2 * fx), fy * fy * (3 - 2 * fy)
            a = n[y0 % 64, x0 % 64]
            b = n[y0 % 64, (x0 + 1) % 64]
            c = n[(y0 + 1) % 64, x0 % 64]
            d = n[(y0 + 1) % 64, (x0 + 1) % 64]
            out += amp * (a + (b - a) * fx + (c - a) * fy + (a - b - c + d) * fx * fy)
            tot += amp
            amp *= 0.5
        return out / tot

    def texture(self, c0, c1, scale=6, octaves=4, seed=0, contrast=1.0, sx=None, sy=None):
        n = self.noise(scale, octaves, seed, sx, sy)
        n = np.clip((n - 0.5) * contrast + 0.5, 0, 1)
        return mix(rgb(c0), rgb(c1), n)

    # ---------------------------------------------------------------- effects
    def blur(self, m, r):
        return ndimage.gaussian_filter(m, r * S)

    def bevel(self, m, depth=3.0, strength=0.6, light=(-0.7, -0.7)):
        """round the shape: lit on the light side, darker on the other"""
        hgt = self.blur(m, depth)
        gy, gx = np.gradient(hgt)
        k = light[0] * gx + light[1] * gy
        k = k / (np.abs(k).max() + 1e-6)
        self.tint(m, 1 - k * strength)

    def shade_sphere(self, cx, cy, r, m, light=(-0.6, -0.6), amb=0.25, spec=0.0):
        dx, dy = (self.X - cx) / r, (self.Y - cy) / r
        dz = np.sqrt(np.clip(1 - dx * dx - dy * dy, 0, 1))
        l = np.array([light[0], light[1], 0.6])
        l = l / np.linalg.norm(l)
        d = np.clip(dx * l[0] + dy * l[1] + dz * l[2], 0, 1)
        f = amb + (1 - amb) * d
        self.tint(m, f)
        if spec:
            s = np.clip(d, 0, 1) ** 30 * spec
            self.add(m * s, '#ffffff')

    def shadow(self, m, dx=3, dy=3, blur=2, amount=0.5):
        sm = ndimage.shift(m, (dy * S, dx * S), order=1)
        sm = self.blur(sm, blur)
        self.tint(np.ones_like(m), 1 - sm * amount)

    def glow(self, m, col, radius=6, amount=1.0):
        g = self.blur(m, radius)
        g = g / (g.max() + 1e-6)
        self.add(g, col, amount)

    def fog(self, m, col, amount):
        self.fill(m, col, amount)

    def vignette(self, amount=0.35):
        dx = (self.X - W / 2) / (W / 2)
        dy = (self.Y - H / 2) / (H / 2)
        f = 1 - amount * np.clip(dx * dx * 0.6 + dy * dy * 0.6, 0, 1)
        self.c *= f[..., None]

    # ---------------------------------------------------------------- sky + animation
    def set_sky(self, m):
        """these pixels show the sky: one colour a line, changed by the copper"""
        self.sky = np.maximum(self.sky, m)

    def cut_sky(self, m):
        self.sky = self.sky * (1 - np.clip(m * 4, 0, 1))

    def animate(self, m, colours, speed=8, regs=1, phase=None):
        """colour cycling: these pixels get 'regs' colour registers. The colours turn
        round; with several registers 'phase' (0..1 per pixel) spreads them (flow)."""
        aid = len(self.anims) + 1
        sel = m > 0.5
        self.anim[sel] = aid
        if phase is None:
            phase = np.zeros((self.h, self.w), np.float32)
        self.anims.append(dict(colours=[rgb(c) for c in colours], speed=speed, regs=regs, phase=phase))
        return aid


# ===========================================================================
# turning the painting into Amiga data
# ===========================================================================
BAYER = np.array([[0, 8, 2, 10], [12, 4, 14, 6], [3, 11, 1, 9], [15, 7, 13, 5]], np.float32) / 16 - 0.47


def to12(c):
    return np.round(np.clip(c, 0, 1) * 15) / 15


def rgb12word(c):
    r, g, b = (int(round(float(v) * 15)) for v in np.clip(c, 0, 1))
    return r << 8 | g << 4 | b


def kmeans(px, k, iters=8, seed=0):
    from PIL import Image as I
    n = px.shape[0]
    side = int(np.ceil(np.sqrt(n)))
    pad = np.zeros((side * side, 3), np.float32)
    pad[:n] = px
    pad[n:] = px[:side * side - n] if side * side - n <= n else px[0]
    im = I.fromarray((pad.reshape(side, side, 3) * 255).astype(np.uint8))
    q = im.quantize(colors=k, method=I.Quantize.MEDIANCUT, dither=I.Dither.NONE)
    pal = np.array(q.getpalette()[:k * 3], np.float32).reshape(-1, 3) / 255
    sub = px[np.random.default_rng(seed).choice(n, min(n, 30000), replace=False)]
    for _ in range(iters):
        d = ((sub[:, None, :] - pal[None]) ** 2).sum(2)
        lab = d.argmin(1)
        for j in range(len(pal)):
            sel = sub[lab == j]
            if len(sel):
                pal[j] = sel.mean(0)
    return pal


def finish(cv, sprite_regs=False, dither=0.045, ncolours=None, name='picture'):
    """-> dict(chunky (192x320 register numbers), palette[32] rgb12, sky[192] or None,
               cycles [(reg, speed, [rgb12...])], preview (PIL image))"""
    # scale down
    c = cv.c.reshape(H, S, W, S, 3).mean((1, 3))
    sky = cv.sky.reshape(H, S, W, S).mean((1, 3)) > 0.5
    anim = cv.anim[::S, ::S]
    animphase = [a['phase'][::S, ::S] for a in cv.anims]
    regs = list(range(32))
    regs.remove(20)                                  # 20: the sky (copper)
    if sprite_regs:
        for r in (17, 18, 19, 21, 22, 23):
            regs.remove(r)
    out = np.zeros((H, W), np.int16)
    palette = [0] * 32
    cycles = []
    # animations: registers from the top
    free = [r for r in regs if r != 0]
    for i, a in enumerate(cv.anims):
        sel = anim == i + 1
        if not sel.any():
            continue
        n = a['regs']
        rr = [free.pop() for _ in range(n)]
        cols = [rgb12word(to12(cc)) for cc in a['colours']]
        ph = animphase[i]
        idx = np.clip((ph * n).astype(int), 0, n - 1) if n > 1 else np.zeros_like(ph, dtype=int)
        for k, r in enumerate(rr):
            out[sel & (idx == k)] = r
            rot = (k * len(cols)) // n
            seq = cols[rot:] + cols[:rot]
            cycles.append((r, a['speed'], seq))
            palette[r] = seq[0]
    # sky: one colour per line
    skytab = None
    if sky.any():
        skytab = []
        rows = [(y, c[y][sky[y]].mean(0)) for y in range(H) if sky[y].any()]
        ys = np.array([r[0] for r in rows])
        cs = np.array([r[1] for r in rows])
        for y in range(H):
            col = np.array([np.interp(y, ys, cs[:, i]) for i in range(3)])
            skytab.append(rgb12word(to12(col)))
        out[sky & (anim == 0)] = 20
    # the rest: an optimised palette, ordered dithering
    static = (out == 0) & ~(sky & (anim == 0))
    statics = [0] + [r for r in free]
    k = len(statics) if ncolours is None else min(len(statics), ncolours)
    px = c[static]
    pal = to12(kmeans(px, k))
    order = np.argsort(pal.sum(1))                   # darkest first: register 0 (the border)
    pal = pal[order]
    thr = BAYER[np.arange(H)[:, None] % 4, np.arange(W)[None, :] % 4]
    cd = c + thr[..., None] * dither
    flat = cd[static]
    best = np.zeros(len(flat), int)
    bd = np.full(len(flat), 1e9, np.float32)
    w = np.array([0.30, 0.59, 0.11]) * 3
    for j, p in enumerate(pal):
        d = (((flat - p) ** 2) * w).sum(1)
        m = d < bd
        bd[m] = d[m]
        best[m] = j
    regmap = np.array(statics[:k])
    out[static] = regmap[best]
    for j, r in enumerate(statics[:k]):
        palette[r] = rgb12word(pal[j])
    # preview
    prev = np.zeros((H, W, 3), np.float32)
    pal_rgb = np.array([[(p >> 8 & 15) / 15, (p >> 4 & 15) / 15, (p & 15) / 15] for p in palette])
    prev[:] = pal_rgb[out]
    if skytab:
        st = np.array([[(p >> 8 & 15) / 15, (p >> 4 & 15) / 15, (p & 15) / 15] for p in skytab])
        m = out == 20
        prev[m] = st[np.nonzero(m)[0]]
    img = Image.fromarray((prev * 255).astype(np.uint8))
    return dict(chunky=out, palette=palette, sky=skytab, cycles=cycles, preview=img, name=name)


def planar(chunky):
    """register numbers -> 5 bitplanes, interleaved lines (40 bytes each)"""
    out = bytearray()
    for y in range(H):
        row = chunky[y]
        for p in range(5):
            bits = ((row >> p) & 1).astype(np.uint8)
            out += np.packbits(bits).tobytes()
    return bytes(out)
