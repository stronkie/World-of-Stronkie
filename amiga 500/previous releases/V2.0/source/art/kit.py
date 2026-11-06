"""Scene building blocks: skies, landscapes, rooms in perspective, materials,
furniture, sci-fi parts, plants, rocks, crystals, creatures."""
import numpy as np
from paint import Canvas, rgb, mix, W, H

# ---------------------------------------------------------------- skies


def night_sky(cv, top='#05061a', bottom='#2a2a5a', horizon=120, stars=160, seed=1, twinkle=True):
    m = cv.rect(0, 0, W, horizon + 2)
    cv.fill(m, cv.vgrad([(0, top), (horizon, bottom)]))
    cv.set_sky(m)
    star_field(cv, 0, 0, W, horizon - 6, stars, seed, twinkle)
    return m


def star_field(cv, x0, y0, x1, y1, n, seed=1, twinkle=True, colours=('#ffffff', '#c8d8ff', '#ffe8c8')):
    rng = np.random.default_rng(seed)
    tw = np.zeros((cv.h, cv.w), np.float32)
    for i in range(n):
        x, y = rng.uniform(x0, x1), rng.uniform(y0, y1)
        r = rng.choice([0.5, 0.5, 0.5, 0.7, 1.0])
        col = colours[rng.integers(len(colours))]
        m = cv.ellipse(x, y, r, r)
        b = rng.uniform(0.5, 1.0)
        cv.fill(m, rgb(col) * b)
        cv.cut_sky(m)
        if r >= 1.0:
            cv.glow(m, col, 1.5, 0.5)
        if twinkle and rng.random() < 0.25:
            tw = np.maximum(tw, m)
    if twinkle and tw.any():
        cv.animate(tw, ['#ffffff', '#aab0d0', '#556080', '#aab0d0', '#ffffff', '#ffffff'], speed=6, regs=3,
                   phase=cv.noise(3, 1, seed + 5))


def moon(cv, x, y, r, col='#f4f0d8', glow=True):
    m = cv.ellipse(x, y, r, r)
    if glow:
        cv.glow(m, '#8890c0', r * 0.9, 0.45)
    cv.fill(m, cv.texture('#d8d4c0', col, 3, 3, 7, 1.6))
    for cx, cy, cr in [(-0.3, -0.2, 0.22), (0.25, 0.15, 0.18), (-0.05, 0.4, 0.12), (0.35, -0.35, 0.1)]:
        cm = cv.ellipse(x + cx * r, y + cy * r, cr * r, cr * r) * m
        cv.tint(cm, 0.86)
    cv.shade_sphere(x, y, r, m, light=(-0.5, -0.4), amb=0.55)
    cv.cut_sky(m)
    return m


def planet(cv, x, y, r, c0, c1, bands=True, rings=None, light=(-0.6, -0.4), atmo=None, seed=3):
    m = cv.ellipse(x, y, r, r)
    if atmo:
        cv.glow(m, atmo, r * 0.25, 0.7)
    if bands:
        n = cv.noise(r * 0.35, 3, seed, sx=cv.X * 0.25, sy=cv.Y * 3)
        cv.fill(m, mix(rgb(c0), rgb(c1), n))
    else:
        cv.fill(m, cv.texture(c0, c1, r * 0.3, 4, seed, 1.5))
    cv.shade_sphere(x, y, r, m, light=light, amb=0.12)
    if rings:
        rm = cv.ellipse(x, y, r * 1.9, r * 0.45) * (1 - cv.ellipse(x, y, r * 1.45, r * 0.32))
        front = rm * (cv.Y > y)
        back = rm * (cv.Y <= y) * (1 - m)
        for part in (back, front):
            cv.fill(part, cv.hgrad([(x - r * 2, rings), (x, '#ffffff'), (x + r * 2, rings)]), 0.85)
    cv.cut_sky(m)
    return m


def nebula(cv, m, c0, c1, scale=40, seed=4, amount=0.6):
    n = cv.noise(scale, 5, seed)
    n = np.clip((n - 0.45) * 2.5, 0, 1)
    col = mix(rgb(c0), rgb(c1), cv.noise(scale * 0.7, 3, seed + 1))
    cv.fill(m * n, col, amount)


def space(cv, x0=0, y0=0, x1=W, y1=H, seed=2, neb=('#401060', '#103070'), stars=140, sky=False):
    m = cv.rect(x0, y0, x1, y1)
    cv.fill(m, cv.vgrad([(y0, '#02020a'), (y1, '#0a0a20')]))
    if neb:
        nebula(cv, m, neb[0], neb[1], 35, seed)
    star_field(cv, x0, y0, x1, y1, stars, seed)
    return m


def clouds(cv, m, y0, y1, col='#404070', light='#8080b0', seed=5, cover=0.5, scale=22):
    n = cv.noise(scale, 5, seed, sx=cv.X * 0.6, sy=cv.Y * 1.4)
    t = np.clip((n - (1 - cover)) * 4, 0, 1) * ((cv.Y >= y0) & (cv.Y <= y1))
    sh = cv.noise(scale * 0.5, 3, seed + 3)
    cv.fill(m * t, mix(rgb(col), rgb(light), sh), 0.9)
    cv.cut_sky(m * (t > 0.4))


# ---------------------------------------------------------------- landscape


def ridge(cv, base, amp, seed, x0=0, x1=W, rough=0.5, step=4):
    rng = np.random.default_rng(seed)
    n = int((x1 - x0) / step) + 2
    h = np.zeros(n)
    a = amp
    for o in range(5):
        k = max(2, int(n / (2 ** (4 - o) * 2)))
        pts = rng.uniform(-1, 1, k + 1)
        h += np.interp(np.linspace(0, k, n), np.arange(k + 1), pts) * a
        a *= rough
    pts = [(x0 + i * step, base - abs(h[i]) if amp > 0 else base) for i in range(n)]
    return pts


def hills(cv, base, amp, col_top, col_bot, seed, y_bottom=H, rough=0.5, texture=None, step=4):
    pts = ridge(cv, base, amp, seed, rough=rough, step=step)
    m = cv.poly(pts + [(W + 4, y_bottom), (-4, y_bottom)])
    top = min(p[1] for p in pts)
    cv.fill(m, cv.vgrad([(top, col_top), (y_bottom, col_bot)]))
    if texture is not None:
        cv.fill(m, texture, 0.5)
    cv.cut_sky(m)
    return m


def mountains(cv, base, amp, col, snow='#e8f0ff', seed=3, shade='#405080', snowline=0.45):
    pts = ridge(cv, base, amp, seed, rough=0.55, step=3)
    m = cv.poly(pts + [(W + 4, H), (-4, H)])
    cv.fill(m, cv.vgrad([(base - amp, col), (base + 20, shade)]))
    # light from the left: slopes
    hx = np.array([p[1] for p in pts])
    xs = np.array([p[0] for p in pts])
    top_at = np.interp(cv.X, xs, hx)
    slope = np.gradient(np.interp(np.arange(cv.w) / 2, xs, hx))
    sl = np.interp(cv.X, np.arange(cv.w) / 2, slope)
    cv.tint(m, 1 + np.clip(sl, -1.5, 1.5) * 0.25)
    sn = m * ((cv.Y - top_at) < amp * snowline * (0.6 + 0.8 * cv.noise(6, 3, seed + 9)))
    cv.fill(sn, cv.texture(snow, '#b0c0e0', 3, 3, seed + 2), 0.95)
    cv.tint(sn, 1 + np.clip(sl, -1.5, 1.5) * 0.3)
    cv.cut_sky(m)
    return m


def grass(cv, m, c0='#1c4a14', c1='#4c8a2c', seed=6, scale=3):
    n = cv.noise(scale, 3, seed, sx=cv.X * 2.5, sy=cv.Y * 0.6)
    cv.fill(m, mix(rgb(c0), rgb(c1), n))


def rock(cv, pts, c0='#605850', c1='#9a9088', seed=7, light=(-0.7, -0.7)):
    m = cv.poly(pts)
    cv.fill(m, cv.texture(c0, c1, 4, 4, seed, 1.6))
    cv.bevel(m, 4, 0.7, light)
    return m


# ---------------------------------------------------------------- perspective rooms


class Room:
    """One-point perspective box. back = (x0, y0, x1, y1) is the back wall,
    the vanishing point is its centre (or vp)."""

    def __init__(self, cv, back, vp=None):
        self.cv = cv
        self.x0, self.y0, self.x1, self.y1 = back
        self.vx, self.vy = vp or ((self.x0 + self.x1) / 2, (self.y0 + self.y1) / 2)

    def surface(self, which):
        """mask and texture coordinates (u along, v depth/height) of a surface"""
        cv = self.cv
        X, Y = cv.X, cv.Y
        far = 60
        if which == 'floor':
            m = cv.poly([(self.x0, self.y1), (self.x1, self.y1), (self.vx + (self.x1 - self.vx) * far, self.vy + (self.y1 - self.vy) * far),
                         (self.vx + (self.x0 - self.vx) * far, self.vy + (self.y1 - self.vy) * far)])
            d = np.maximum(Y - self.vy, 0.01)
            z = (self.y1 - self.vy) / d                  # 1 at the back wall, smaller nearer
            u = (X - self.vx) * z
            return m, u, z
        if which == 'ceiling':
            m = cv.poly([(self.x0, self.y0), (self.x1, self.y0), (self.vx + (self.x1 - self.vx) * far, self.vy + (self.y0 - self.vy) * far),
                         (self.vx + (self.x0 - self.vx) * far, self.vy + (self.y0 - self.vy) * far)])
            d = np.maximum(self.vy - Y, 0.01)
            z = (self.vy - self.y0) / d
            u = (X - self.vx) * z
            return m, u, z
        if which == 'left':
            m = cv.poly([(self.x0, self.y0), (self.x0, self.y1), (self.vx + (self.x0 - self.vx) * far, self.vy + (self.y1 - self.vy) * far),
                         (self.vx + (self.x0 - self.vx) * far, self.vy + (self.y0 - self.vy) * far)])
            d = np.maximum(self.vx - X, 0.01)
            z = (self.vx - self.x0) / d
            v = (Y - self.vy) * z
            return m, v, z
        if which == 'right':
            m = cv.poly([(self.x1, self.y0), (self.x1, self.y1), (self.vx + (self.x1 - self.vx) * far, self.vy + (self.y1 - self.vy) * far),
                         (self.vx + (self.x1 - self.vx) * far, self.vy + (self.y0 - self.vy) * far)])
            d = np.maximum(X - self.vx, 0.01)
            z = (self.x1 - self.vx) / d
            v = (Y - self.vy) * z
            return m, v, z
        m = cv.rect(self.x0, self.y0, self.x1, self.y1)
        return m, cv.X, cv.Y

    def depth_shade(self, m, z, near=0.85, far=0.55):
        """further away = darker (z = 1 at the back wall)"""
        t = np.clip((z - 0.2) / 0.8, 0, 1)
        self.cv.tint(m, near + (far - near) * t)

    def wall_point(self, side, depth, h):
        """a point on a side wall: depth 0 (front) .. 1 (back), h 0 (floor) .. 1 (ceiling)"""
        z = 1 / (1 + (1 - depth) * 3)               # perspective spacing
        x = self.x0 if side == 'left' else self.x1
        bx = self.vx + (x - self.vx) / z
        yb = self.vy + (self.y1 - self.vy) / z
        yt = self.vy + (self.y0 - self.vy) / z
        return bx, yb + (yt - yb) * h

    def floor_point(self, u, depth):
        """u -1 (left) .. 1 (right), depth 0 (front) .. 1 (back wall)"""
        z = 1 / (1 + (1 - depth) * 3)
        x = self.vx + u * (self.x1 - self.x0) / 2 / z
        y = self.vy + (self.y1 - self.vy) / z
        return x, y


# ---------------------------------------------------------------- materials (u, v arrays)


def planks(cv, u, v, c0='#5a3418', c1='#8a5a30', width=8.0, seed=11, along='u'):
    a, b = (u, v) if along == 'u' else (v, u)
    row = np.floor(b / width)
    off = (row * 37.0) % 23
    grain = cv.noise(4, 3, seed, sx=a * 0.4 + off * 5, sy=b * 6)
    col = mix(rgb(c0), rgb(c1), grain)
    seam = (np.abs((b / width) - np.round(b / width)) * width) < 0.45
    joint = (np.abs(((a + off * 9) / 60) - np.round((a + off * 9) / 60)) * 60) < 0.5
    col = col * np.where(seam | joint, 0.55, 1.0)[..., None]
    var = (np.sin(row * 12.9898) * 43758.5453) % 1
    return col * (0.85 + 0.25 * var)[..., None]


def checker(u, v, c0, c1, size=10.0):
    k = (np.floor(u / size) + np.floor(v / size)) % 2
    return mix(rgb(c0), rgb(c1), k)


def blocks(cv, u, v, c0='#5a5550', c1='#8a847a', bw=16.0, bh=8.0, mortar='#2a2622', seed=12):
    row = np.floor(v / bh)
    uu = u + (row % 2) * bw / 2
    col = np.floor(uu / bw)
    var = (np.sin(row * 12.98 + col * 78.23) * 43758.55) % 1
    tex = cv.noise(3, 3, seed, sx=u * 1.0, sy=v * 1.0)
    c = mix(rgb(c0), rgb(c1), 0.35 * var + 0.65 * tex)
    fx = np.abs(uu / bw - np.round(uu / bw)) * bw
    fy = np.abs(v / bh - np.round(v / bh)) * bh
    mor = (fx < 0.6) | (fy < 0.6)
    c = np.where(mor[..., None], rgb(mortar), c)
    edge = ((fx < 1.4) | (fy < 1.4)) & ~mor
    return c * np.where(edge, 0.85, 1.0)[..., None]


def panels(cv, u, v, c0='#4a5260', c1='#6a7484', pw=24.0, ph=16.0, seed=13, rivets=True):
    fx = (u / pw) % 1
    fy = (v / ph) % 1
    tex = cv.noise(5, 2, seed, sx=u, sy=v)
    c = mix(rgb(c0), rgb(c1), 0.5 + 0.5 * (tex - 0.5))
    seam = (fx < 0.03) | (fy < 0.04)
    hi = (fx < 0.08) & ~seam | (fy < 0.1) & ~seam
    lo = (fx > 0.95) | (fy > 0.93)
    c = c * np.where(seam, 0.4, np.where(hi, 1.2, np.where(lo, 0.8, 1.0)))[..., None]
    if rivets:
        rx = np.abs(fx - 0.12) * pw
        ry = np.abs(fy - 0.18) * ph
        rv = (rx < 0.8) & (ry < 0.8)
        c = np.where(rv[..., None], c * 1.4, c)
    return np.clip(c, 0, 1)


def wallpaper(cv, u, v, c0='#4a2030', c1='#6a3040', period=10.0):
    s = (np.sin(u / period * 2 * np.pi) > 0.6)
    d = (np.abs(((u / period) % 1) - 0.5) < 0.06) & (((v / 6) % 1) < 0.5)
    return np.where((s | d)[..., None], rgb(c1), rgb(c0))


# ---------------------------------------------------------------- furniture & props


def box3d(cv, x0, y0, x1, y1, depth, col, dx=-1.0, dy=-0.6, tex=None):
    """a box seen from the front with its top and one side"""
    front = cv.rect(x0, y0, x1, y1)
    ox, oy = depth * dx, depth * dy
    top = cv.poly([(x0, y0), (x1, y0), (x1 + ox, y0 + oy), (x0 + ox, y0 + oy)])
    side = cv.poly([(x0, y0), (x0 + ox, y0 + oy), (x0 + ox, y1 + oy), (x0, y1)]) if dx < 0 else \
        cv.poly([(x1, y0), (x1 + ox, y0 + oy), (x1 + ox, y1 + oy), (x1, y1)])
    c = rgb(col)
    cv.fill(side, c * 0.6)
    cv.fill(top, c * 1.25 if c.max() < 0.8 else c)
    cv.fill(front, tex if tex is not None else c)
    return front, top, side


def crate(cv, x0, y0, x1, y1, depth=6, c0='#6a4a28', c1='#9a7040', label=None):
    t = planks(cv, cv.X, cv.Y, c0, c1, width=(y1 - y0) / 4, along='u')
    f, top, side = box3d(cv, x0, y0, x1, y1, depth, c1, tex=t)
    for m in (top, side):
        cv.fill(m, planks(cv, cv.X, cv.Y, c0, c1, 4), 0.6)
    frame = f * (1 - cv.rect(x0 + 2, y0 + 2, x1 - 2, y1 - 2))
    cv.tint(frame, 0.8)
    diag = cv.line([(x0 + 2, y1 - 2), (x1 - 2, y0 + 2)], 2) * f
    cv.fill(diag, rgb(c0) * 0.9)
    cv.bevel(diag, 1, 0.5)
    return f


def barrel(cv, cx, by, rx, h, c0='#5a3418', c1='#9a6838'):
    m = cv.rect(cx - rx, by - h, cx + rx, by) + cv.ellipse(cx, by, rx, rx * 0.3)
    m = np.clip(m + cv.ellipse(cx, by - h, rx, rx * 0.3), 0, 1)
    bulge = 1 - ((cv.Y - (by - h / 2)) / (h / 2)) ** 2
    t = planks(cv, (cv.X - cx) / rx * 20, cv.Y, c0, c1, 5, along='v')
    cv.fill(m, t)
    xx = (cv.X - cx) / rx
    cv.tint(m, 0.45 + 0.75 * np.clip(1 - (xx + 0.35) ** 2, 0, 1) * (0.85 + 0.15 * bulge))
    for f in (0.18, 0.82):
        hoop = cv.ellipse(cx, by - h * f, rx, rx * 0.3) * (1 - cv.ellipse(cx, by - h * f - 1.6, rx, rx * 0.3)) * m
        cv.fill(hoop, '#2a2a30')
        cv.tint(hoop, 0.6 + 0.8 * np.clip(1 - (xx + 0.35) ** 2, 0, 1))
    top = cv.ellipse(cx, by - h, rx * 0.95, rx * 0.27)
    cv.fill(top, cv.texture(c0, c1, 2, 3, 4))
    cv.tint(top, 0.8)
    return m


def door(cv, x0, y0, x1, y1, c0='#4a2a12', c1='#7a4a24', frame='#2a1a0a', knob=True, arch=False):
    fr = cv.rect(x0 - 3, y0 - 3, x1 + 3, y1)
    if arch:
        fr = np.clip(fr + cv.ellipse((x0 + x1) / 2, y0, (x1 - x0) / 2 + 3, (x1 - x0) / 2.5 + 3), 0, 1) * (cv.Y < y1)
    cv.fill(fr, frame)
    cv.bevel(fr, 1.5, 0.6)
    m = cv.rect(x0, y0, x1, y1)
    if arch:
        m = np.clip(m + cv.ellipse((x0 + x1) / 2, y0, (x1 - x0) / 2, (x1 - x0) / 2.5), 0, 1) * (cv.Y < y1)
    cv.fill(m, planks(cv, cv.X, cv.Y, c0, c1, (x1 - x0) / 4, along='v'))
    pw = (x1 - x0)
    for (a, b, c, d) in [(0.15, 0.1, 0.85, 0.42), (0.15, 0.55, 0.85, 0.9)]:
        p = cv.rect(x0 + pw * a, y0 + (y1 - y0) * b, x0 + pw * c, y0 + (y1 - y0) * d)
        cv.bevel(p, 1.2, 0.7, light=(0.7, 0.7))
    if knob:
        k = cv.ellipse(x1 - pw * 0.15, (y0 + y1) / 2 + 2, 1.6, 1.6)
        cv.fill(k, '#d0a040')
        cv.shade_sphere(x1 - pw * 0.15, (y0 + y1) / 2 + 2, 1.6, k, spec=0.8)
    return m


def window_frame(cv, x0, y0, x1, y1, frame='#3a2a1a', bars=(2, 2), width=2.0):
    m = cv.rect(x0, y0, x1, y1)
    fr = cv.rect(x0 - width, y0 - width, x1 + width, y1 + width) * (1 - m)
    for i in range(1, bars[0]):
        x = x0 + (x1 - x0) * i / bars[0]
        fr = np.maximum(fr, cv.rect(x - width / 2, y0, x + width / 2, y1))
    for i in range(1, bars[1]):
        y = y0 + (y1 - y0) * i / bars[1]
        fr = np.maximum(fr, cv.rect(x0, y - width / 2, x1, y + width / 2))
    cv.fill(fr, frame)
    cv.bevel(fr, 0.8, 0.6)
    cv.cut_sky(fr)
    return m


def bookshelf(cv, x0, y0, x1, y1, shelves=4, seed=21, wood=('#3a2010', '#6a4020')):
    m = cv.rect(x0, y0, x1, y1)
    cv.fill(m, planks(cv, cv.X, cv.Y, wood[0], wood[1], 6, along='v'))
    rng = np.random.default_rng(seed)
    cols = ['#7a1a1a', '#1a3a6a', '#2a5a2a', '#6a5a1a', '#4a2a5a', '#8a6a3a', '#3a3a3a', '#6a2a10']
    sh = (y1 - y0) / shelves
    for s in range(shelves):
        top, bot = y0 + s * sh + 2, y0 + (s + 1) * sh - 2
        cv.fill(cv.rect(x0 + 2, top, x1 - 2, bot), '#140a04')
        x = x0 + 3
        while x < x1 - 4:
            w = rng.uniform(2.0, 4.5)
            hh = rng.uniform(0.65, 0.95) * (bot - top)
            b = cv.rect(x, bot - hh, min(x + w, x1 - 3), bot)
            c = rgb(cols[rng.integers(len(cols))]) * rng.uniform(0.7, 1.2)
            cv.fill(b, c)
            xx = (cv.X - x) / w
            cv.tint(b, 0.7 + 0.6 * np.clip(1 - (xx * 2 - 0.7) ** 2, 0, 1))
            if rng.random() < 0.4:
                cv.fill(cv.rect(x, bot - hh * 0.75, x + w, bot - hh * 0.7) * b, '#c8a040', 0.8)
            x += w + rng.uniform(0, 0.6)
        board = cv.rect(x0, bot, x1, bot + 2.5)
        cv.fill(board, wood[1])
        cv.bevel(board, 0.8, 0.6)
    return m


def table(cv, x0, x1, y, h, depth=10, top='#6a4020', leg='#3a2010'):
    tm = cv.poly([(x0, y), (x1, y), (x1 - depth * 0.6, y - depth * 0.6), (x0 + depth * 0.6, y - depth * 0.6)])
    cv.fill(tm, planks(cv, cv.X, cv.Y * 3, top, rgb(top) * 1.4, 5))
    edge = cv.rect(x0, y, x1, y + 3)
    cv.fill(edge, rgb(top) * 0.7)
    for lx in (x0 + 3, x1 - 6):
        l = cv.rect(lx, y + 3, lx + 3, y + h)
        cv.fill(l, leg)
        cv.bevel(l, 0.8, 0.5)
    return tm


def lamp_glow(cv, x, y, r, col, amount=0.8):
    m = cv.ellipse(x, y, r * 0.25, r * 0.25)
    cv.glow(m, col, r, amount)


def cylinder(cv, x0, y0, x1, y1, c0, c1=None, vertical=True, spec=0.3):
    m = cv.rect(x0, y0, x1, y1)
    if vertical:
        t = (cv.X - x0) / max(x1 - x0, 0.1)
    else:
        t = (cv.Y - y0) / max(y1 - y0, 0.1)
    c = rgb(c0)
    cv.fill(m, c)
    shade = 0.4 + 0.9 * np.clip(1 - ((t - 0.35) * 2) ** 2, 0, 1)
    cv.tint(m, shade)
    if spec:
        cv.add(m * np.clip(1 - np.abs(t - 0.3) * 12, 0, 1), '#ffffff', spec)
    return m


# ---------------------------------------------------------------- sci-fi


def console(cv, x0, y0, x1, y1, col='#3a4250', seed=31, lights=True, slope=8):
    top = cv.poly([(x0 + slope, y0), (x1 - slope, y0), (x1, y0 + slope * 0.8), (x0, y0 + slope * 0.8)])
    front = cv.rect(x0, y0 + slope * 0.8, x1, y1)
    cv.fill(front, panels(cv, cv.X, cv.Y, rgb(col) * 0.8, rgb(col), 30, 10, seed, False))
    cv.fill(top, cv.lgrad((0, y0), (0, y0 + slope), rgb(col) * 1.5, rgb(col) * 1.1))
    if lights:
        rng = np.random.default_rng(seed)
        blink = np.zeros((cv.h, cv.w), np.float32)
        cols = ['#ff3030', '#30ff40', '#ffd020', '#40a0ff']
        for i in range(int((x1 - x0) / 5)):
            bx = rng.uniform(x0 + slope + 2, x1 - slope - 2)
            by = rng.uniform(y0 + 1.5, y0 + slope * 0.8 - 1.5)
            b = cv.rect(bx, by, bx + 2.2, by + 1.4)
            cv.fill(b, cols[rng.integers(4)])
            if rng.random() < 0.45:
                blink = np.maximum(blink, b)
        if blink.any():
            cv.animate(blink, ['#ff4040', '#401010', '#40ff60', '#103010', '#ffe040', '#202010'], speed=7, regs=3,
                       phase=cv.noise(2, 1, seed))
    return top, front


def screen(cv, x0, y0, x1, y1, col='#20c0a0', frame='#202830', content='lines', seed=33, anim=True):
    fr = cv.rect(x0 - 2, y0 - 2, x1 + 2, y1 + 2)
    cv.fill(fr, frame)
    cv.bevel(fr, 1, 0.7)
    m = cv.rect(x0, y0, x1, y1)
    c = rgb(col)
    cv.fill(m, c * 0.18)
    rng = np.random.default_rng(seed)
    if content == 'lines':
        for i in range(int((y1 - y0) / 3)):
            yy = y0 + 2 + i * 3
            ww = rng.uniform(0.3, 0.9) * (x1 - x0 - 4)
            cv.fill(cv.rect(x0 + 2, yy, x0 + 2 + ww, yy + 1), c, 0.9)
    elif content == 'wave':
        pts = [(x0 + 1 + i, (y0 + y1) / 2 + np.sin(i / 3.0) * (y1 - y0) * 0.3) for i in range(int(x1 - x0 - 2))]
        cv.fill(cv.line(pts, 0.8), c)
    elif content == 'radar':
        cx, cy, r = (x0 + x1) / 2, (y0 + y1) / 2, min(x1 - x0, y1 - y0) / 2 - 1
        ring = cv.ellipse(cx, cy, r, r) * (1 - cv.ellipse(cx, cy, r - 0.8, r - 0.8))
        cv.fill(ring, c)
        cv.fill(cv.line([(cx - r, cy), (cx + r, cy)], 0.6), c, 0.7)
        cv.fill(cv.line([(cx, cy - r), (cx, cy + r)], 0.6), c, 0.7)
    elif content == 'graph':
        for i in range(int((x1 - x0 - 4) / 3)):
            hh = rng.uniform(0.2, 0.9) * (y1 - y0 - 4)
            cv.fill(cv.rect(x0 + 2 + i * 3, y1 - 2 - hh, x0 + 4 + i * 3, y1 - 2), c)
    scan = ((cv.Y * 2).astype(int) % 2 == 0)
    cv.tint(m * scan, 0.8)
    cv.glow(m, col, 3, 0.25)
    return m


def viewport(cv, x0, y0, x1, y1, frame='#505868', inner=None, round_=False):
    if round_:
        cx, cy, r = (x0 + x1) / 2, (y0 + y1) / 2, (x1 - x0) / 2
        m = cv.ellipse(cx, cy, r, r)
        fr = cv.ellipse(cx, cy, r + 4, r + 4) * (1 - m)
    else:
        m = cv.rect(x0, y0, x1, y1)
        fr = cv.rect(x0 - 4, y0 - 4, x1 + 4, y1 + 4) * (1 - m)
    if inner:
        inner(m)
    cv.fill(fr, frame)
    cv.bevel(fr, 2, 0.8)
    if round_:
        for a in range(0, 360, 45):
            bx = cx + np.cos(np.radians(a)) * (r + 2)
            by = cy + np.sin(np.radians(a)) * (r + 2)
            b = cv.ellipse(bx, by, 0.9, 0.9)
            cv.fill(b, '#a0a8b8')
    # a reflection on the glass
    refl = m * cv.poly([(x0, y0 + (y1 - y0) * 0.6), (x0 + (x1 - x0) * 0.35, y0), (x0 + (x1 - x0) * 0.45, y0), (x0, y0 + (y1 - y0) * 0.8)])
    cv.add(refl, '#ffffff', 0.08)
    return m


def pipe(cv, pts, width, col='#707880'):
    m = cv.line(pts, width)
    cv.fill(m, col)
    cv.bevel(m, width * 0.35, 0.8)
    return m


def grating(cv, m, u, v, col='#3a3e44', size=4.0):
    gx = (np.abs((u / size) % 1 - 0.5) < 0.12) | (np.abs((v / size) % 1 - 0.5) < 0.15)
    c = np.where(gx[..., None], rgb(col) * 1.4, rgb(col) * 0.5)
    cv.fill(m, c)


def warning_stripes(cv, m, col='#e0b000', w=6.0):
    s = (((cv.X + cv.Y) / w) % 2) < 1
    cv.fill(m * s, col)
    cv.fill(m * ~s, '#202020')


def blinker(cv, x, y, r, col, off='#300808', speed=12):
    m = cv.ellipse(x, y, r, r)
    cv.fill(m, col)
    cv.glow(m, col, r * 2.5, 0.6)
    cv.animate(m, [col, col, off, off], speed=speed)
    return m


# ---------------------------------------------------------------- plants, fire, water, crystals


def _branch(cv, acc, x, y, ang, length, width, depth, rng):
    ex = x + np.cos(ang) * length
    ey = y + np.sin(ang) * length
    mx = (x + ex) / 2 + rng.uniform(-length, length) * 0.12
    my = (y + ey) / 2 + rng.uniform(-length, length) * 0.12
    acc.append((cv.line([(x, y), (mx, my), (ex, ey)], width), width))
    ends = [(ex, ey)]
    if depth > 0:
        for k in range(2 if depth > 1 else rng.integers(2, 4)):
            na = ang + rng.uniform(0.25, 0.7) * (1 if k % 2 else -1)
            ends += _branch(cv, acc, ex, ey, na, length * rng.uniform(0.6, 0.78), max(0.5, width * 0.62), depth - 1, rng)
    return ends


def tree(cv, x, ground, h, trunk='#3a2814', leaves=('#16380e', '#4a7a26'), seed=41, w=None, bare=False, lean=0.0,
         depth=4):
    rng = np.random.default_rng(seed)
    w = w or h * 0.07
    acc = []
    ends = _branch(cv, acc, x, ground, -np.pi / 2 + lean, h * 0.42, w * 2, depth, rng)
    wood = np.zeros((cv.h, cv.w), np.float32)
    for m, wd in acc:
        wood = np.maximum(wood, m)
    root = cv.poly([(x - w * 2.2, ground), (x - w * 0.8, ground - h * 0.12), (x + w * 0.8, ground - h * 0.12), (x + w * 2.2, ground)])
    wood = np.maximum(wood, root)
    cv.fill(wood, cv.texture(trunk, rgb(trunk) * 1.7, 1.2, 3, seed, 1.4, sx=cv.X * 2.5, sy=cv.Y * 0.5))
    cv.bevel(wood, 1.2, 0.7)
    if not bare:
        for i, (ex, ey) in enumerate(ends):
            r = h * rng.uniform(0.09, 0.16)
            cx, cy = ex + rng.uniform(-3, 3), ey + rng.uniform(-2, 2)
            m = cv.ellipse(cx, cy, r, r * 0.8)
            cv.fill(m, cv.texture(leaves[0], leaves[1], 1.6, 3, seed + i, 1.8))
            cv.shade_sphere(cx, cy, r * 1.1, m, amb=0.4)
    return wood


def bush(cv, x, y, r, c=('#123010', '#3a6a20'), seed=43, n=7):
    rng = np.random.default_rng(seed)
    tot = np.zeros((cv.h, cv.w), np.float32)
    for i in range(n):
        cx, cy = x + rng.uniform(-r, r), y - rng.uniform(0, r * 0.6)
        rr = r * rng.uniform(0.4, 0.7)
        m = cv.ellipse(cx, cy, rr, rr * 0.8)
        cv.fill(m, cv.texture(c[0], c[1], 1.5, 3, seed + i, 2))
        cv.shade_sphere(cx, cy, rr, m, amb=0.4)
        tot = np.maximum(tot, m)
    cv.cut_sky(tot)
    return tot


def fire(cv, m, speed=3, hot='#fff0a0', mid='#ff9020', cool='#c02000', regs=5):
    """flames: colour cycling bands moving up"""
    ph = ((cv.Y * 0.35 + cv.noise(2.5, 2, 77) * 3) % 1.0)
    cv.fill(m, mid)
    cv.glow(m, '#ff8020', 6, 0.5)
    cols = [hot, '#ffd040', mid, cool, mid, '#ffd040']
    cv.animate(m, cols, speed=speed, regs=regs, phase=ph)


def water(cv, m, c0='#103060', c1='#3070b0', hi='#a0d0ff', speed=4, regs=4, glow=None):
    n = cv.noise(4, 3, 51, sx=cv.X * 0.35, sy=cv.Y * 2.5)
    cv.fill(m, mix(rgb(c0), rgb(c1), n))
    ph = ((cv.X * 0.05 + cv.noise(3, 2, 52, sx=cv.X * 0.4, sy=cv.Y * 3) * 2) % 1.0)
    rip = m * (n > 0.62)
    cv.animate(rip, [hi, c1, c0, c1], speed=speed, regs=regs, phase=ph)
    if glow:
        cv.glow(m, glow, 6, 0.3)


def crystal(cv, x, y, h, w, col='#60e0ff', dark='#104060', lean=0.0, seed=61, glow=True):
    pts = [(x - w / 2, y), (x - w / 2 + lean * 0.5, y - h * 0.75), (x + lean, y - h), (x + w / 2 + lean * 0.5, y - h * 0.75), (x + w / 2, y)]
    m = cv.poly(pts)
    left = cv.poly([pts[0], pts[1], pts[2], (x + lean * 0.3, y)])
    cv.fill(m, cv.lgrad((x, y - h), (x, y), col, dark))
    cv.tint(left * m, 1.35)
    edge = cv.line([(x + lean, y - h), (x + lean * 0.3, y)], 0.6)
    cv.add(edge * m, '#ffffff', 0.5)
    if glow:
        cv.glow(m, col, w * 1.2, 0.35)
    cv.cut_sky(m)
    return m


# ---------------------------------------------------------------- creatures


def stronkie(cv, x, y, h, fur='#3a6ad0', eyes='#ffffff', seed=71, ears=True, glow_ears=False, white=False):
    """a Stronkie: round blue body, big eyes, long ears (y = feet)"""
    fur = '#e0e4f0' if white else fur
    b = cv.ellipse(x, y - h * 0.32, h * 0.26, h * 0.32)
    hd = cv.ellipse(x, y - h * 0.68, h * 0.24, h * 0.21)
    m = np.maximum(b, hd)
    if ears:
        for s in (-1, 1):
            e = cv.poly([(x + s * h * 0.08, y - h * 0.82), (x + s * h * 0.35, y - h * 1.25), (x + s * h * 0.22, y - h * 0.78)])
            cv.fill(e, fur)
            cv.bevel(e, 1, 0.5)
            inner = cv.poly([(x + s * h * 0.12, y - h * 0.83), (x + s * h * 0.31, y - h * 1.15), (x + s * h * 0.2, y - h * 0.82)])
            cv.fill(inner, '#ffd0ff' if not glow_ears else '#ffffa0', 0.7)
            if glow_ears:
                cv.glow(inner, '#ffff80', 6, 0.7)
    cv.fill(m, cv.texture(fur, rgb(fur) * 1.4, 1.2, 3, seed, 1.5))
    cv.shade_sphere(x, y - h * 0.4, h * 0.45, m, amb=0.45)
    belly = cv.ellipse(x, y - h * 0.28, h * 0.15, h * 0.2)
    cv.fill(belly, rgb(fur) * 1.35 if not white else '#ffffff', 0.6)
    for s in (-1, 1):
        e = cv.ellipse(x + s * h * 0.09, y - h * 0.7, h * 0.07, h * 0.08)
        cv.fill(e, eyes)
        p = cv.ellipse(x + s * h * 0.09 + h * 0.015, y - h * 0.69, h * 0.035, h * 0.045)
        cv.fill(p, '#101018')
        cv.fill(cv.ellipse(x + s * h * 0.09 - h * 0.01, y - h * 0.72, h * 0.012, h * 0.012), '#ffffff')
    feet = cv.ellipse(x - h * 0.12, y - h * 0.02, h * 0.1, h * 0.04) + cv.ellipse(x + h * 0.12, y - h * 0.02, h * 0.1, h * 0.04)
    cv.fill(np.clip(feet, 0, 1), rgb(fur) * 0.7)
    cv.cut_sky(m)
    return m


def person(cv, x, y, h, coat='#404858', skin='#e0b090', hair='#4a3020', legs='#202430', seed=81, head_col=None,
           arms_up=False, beard=None, hat=None):
    """a simple painted figure (y = feet)"""
    hd = h * 0.13
    body = cv.poly([(x - h * 0.14, y - h * 0.78), (x + h * 0.14, y - h * 0.78), (x + h * 0.16, y - h * 0.4), (x - h * 0.16, y - h * 0.4)])
    lg = cv.poly([(x - h * 0.13, y - h * 0.42), (x + h * 0.13, y - h * 0.42), (x + h * 0.11, y), (x + h * 0.02, y),
                  (x, y - h * 0.3), (x - h * 0.02, y), (x - h * 0.11, y)])
    cv.fill(lg, legs)
    cv.bevel(lg, 1, 0.6)
    cv.fill(body, cv.texture(coat, rgb(coat) * 1.3, 2, 3, seed))
    cv.bevel(body, 2, 0.7)
    for s in (-1, 1):
        if arms_up:
            a = cv.line([(x + s * h * 0.15, y - h * 0.74), (x + s * h * 0.3, y - h * 0.95)], h * 0.07)
        else:
            a = cv.line([(x + s * h * 0.16, y - h * 0.74), (x + s * h * 0.2, y - h * 0.45)], h * 0.07)
        cv.fill(a, coat)
        cv.bevel(a, 1, 0.6)
    head = cv.ellipse(x, y - h * 0.88, hd * 0.85, hd)
    cv.fill(head, head_col or skin)
    cv.shade_sphere(x, y - h * 0.88, hd, head, amb=0.5)
    hr = cv.ellipse(x, y - h * 0.93, hd * 0.9, hd * 0.7) * (cv.Y < y - h * 0.9)
    cv.fill(hr, hair)
    if beard:
        bd = cv.ellipse(x, y - h * 0.8, hd * 0.7, hd * 0.55) * (cv.Y > y - h * 0.84)
        cv.fill(bd, beard)
    if hat:
        hm = cv.poly([(x - hd * 1.6, y - h * 0.98), (x + hd * 1.6, y - h * 0.98), (x + hd * 0.6, y - h * 1.15), (x - hd * 0.6, y - h * 1.15)])
        cv.fill(hm, hat)
        cv.bevel(hm, 1, 0.6)
    m = np.clip(body + lg + head, 0, 1)
    cv.cut_sky(m)
    return m


def book_texture(cv, u, v, shelf=20.0, seed=5):
    """rows of books on shelves, in (u, v) surface coordinates"""
    cols = np.array([rgb(c) for c in ['#7a1a1a', '#1a3a6a', '#2a5a2a', '#6a5a1a', '#4a2a5a', '#8a6a3a', '#3a3a3a', '#6a2a10']])
    row = np.floor(v / shelf)
    fv = (v / shelf) % 1
    bw = 3.2
    bi = np.floor((u + row * 7.3) / bw)
    hsh = (np.sin(bi * 12.9898 + row * 78.233) * 43758.5453) % 1
    cidx = (hsh * 8).astype(int) % 8
    c = cols[cidx] * (0.7 + 0.5 * ((hsh * 7) % 1))[..., None]
    fu = ((u + row * 7.3) / bw) % 1
    c = c * (0.6 + 0.6 * np.clip(1 - (fu * 2 - 0.7) ** 2, 0, 1))[..., None]
    top = 0.12 + 0.25 * ((hsh * 13) % 1)
    gap = fv < top
    c = np.where(gap[..., None], rgb('#120a04'), c)
    board = fv > 0.9
    c = np.where(board[..., None], rgb('#6a4020') * (1.2 - (fv - 0.9) * 5)[..., None], c)
    return c
