"""The World of Stronkie: jungle, village, crystal mountains, the Sky Temple, the mines (parts 8-13)."""
import numpy as np
from paint import Canvas, rgb, mix, W, H
from kit import *
from scenes1 import starraven
from scenes2 import cockpit_frame


def alien_sky(cv, horizon=110, seed=3, suns=True, top='#3a1a6a', bottom='#e080a0'):
    m = cv.rect(0, 0, W, horizon + 2)
    cv.fill(m, cv.vgrad([(0, top), (horizon * 0.7, '#a04a90'), (horizon, bottom)]))
    cv.set_sky(m)
    if suns:
        for x, y, r, c in ((250, 30, 13, '#fff0a0'), (285, 52, 7, '#ffb0e0')):
            s = cv.ellipse(x, y, r, r)
            cv.glow(s, c, r * 2, 0.6)
            cv.fill(s, c)
            cv.cut_sky(s)
    clouds(cv, m, 10, horizon * 0.6, '#8a4a90', '#f0a0d0', seed=seed + 2, cover=0.38, scale=26)
    return m


def purple_ground(cv, top=110, seed=4):
    g = hills(cv, top, 4, '#6a2a8a', '#2a1040', seed)
    n = cv.noise(2.5, 3, seed + 1, sx=cv.X * 2.5, sy=cv.Y * 0.6)
    cv.fill(g, mix(rgb('#3a1458'), rgb('#9a4ab8'), n), 0.8)
    return g


def alien_tree(cv, x, ground, h, seed, trunk='#4a2060', leaves=('#5a1a7a', '#c060e0')):
    rng = np.random.default_rng(seed)
    t = cv.poly([(x - h * 0.06, ground), (x - h * 0.04, ground - h * 0.8), (x + h * 0.04, ground - h * 0.8), (x + h * 0.06, ground)])
    cv.fill(t, cv.texture(trunk, rgb(trunk) * 1.8, 1.2, 3, seed, 1.5, sx=cv.X * 3, sy=cv.Y * 0.4))
    cv.bevel(t, 1.5, 0.6)
    for i in range(9):
        a = -np.pi / 2 + rng.uniform(-1.3, 1.3)
        l = h * rng.uniform(0.25, 0.4)
        ex, ey = x + np.cos(a) * l, ground - h * 0.78 + np.sin(a) * l * 0.5
        frond = cv.line([(x, ground - h * 0.8), ((x + ex) / 2, ey - h * 0.1), (ex, ey + h * 0.08)], h * 0.06)
        cv.fill(frond, mix(rgb(leaves[0]), rgb(leaves[1]), rng.uniform(0.2, 0.9)))
        cv.bevel(frond, 1, 0.6)
    return t


def wreck():
    cv = Canvas()
    alien_sky(cv, 110, seed=5)
    purple_ground(cv, 100, 3)
    cockpit_frame(cv, '#2a2426', '#4a3c3a')
    crack = cv.line([(60, 20), (90, 44), (84, 70), (120, 90)], 1)
    cv.fill(crack, '#e0e0ff')
    console(cv, 0, 118, W, 192, '#3a3436', seed=31, lights=False, slope=14)
    sp = np.zeros((cv.h, cv.w), np.float32)
    for x, y in ((90, 124), (210, 128)):
        for a in range(0, 180, 30):
            sp = np.maximum(sp, cv.line([(x, y), (x + np.cos(np.radians(-a)) * 9, y - np.sin(np.radians(a)) * 9)], 0.7))
        cv.glow(cv.ellipse(x, y, 3, 3), '#ffd060', 14, 0.6)
    cv.fill(sp, '#fff0a0')
    cv.animate(sp, ['#ffffff', '#ffd040', '#402010', '#402010', '#ffe080', '#402010'], speed=2, regs=2, phase=(cv.X > 150) * 0.5)
    hatch = cv.rect(250, 126, 300, 186)
    cv.fill(hatch, panels(cv, cv.X, cv.Y, '#4a4a50', '#6a6a72', 20, 30, 4))
    cv.bevel(hatch, 2, 0.6)
    lv = cv.line([(236, 150), (236, 170)], 3)
    cv.fill(lv, '#d02020')
    cv.bevel(lv, 1, 0.6)
    smoke = cv.noise(10, 4, 9) * (cv.Y < 110)
    cv.fill(np.clip((smoke - 0.5) * 3, 0, 1) * cv.poly([(30, 6), (290, 6), (272, 100), (48, 100)]), '#3a3040', 0.5)
    cv.vignette(0.4)
    return cv


def crash():
    cv = Canvas()
    alien_sky(cv, 104, seed=9)
    mountains(cv, 100, 26, '#7a5aa0', '#f0d8ff', 5, '#4a2a6a', 0.3)
    purple_ground(cv, 104, 7)
    hull = cv.poly([(40, 150), (60, 120), (190, 112), (240, 130), (230, 158), (60, 162)])
    cv.fill(hull, cv.vgrad([(112, '#e0e8f8'), (162, '#40485a')]))
    cv.bevel(hull, 3, 0.5)
    cv.fill(cv.line([(80, 124), (200, 120)], 2), '#c02020')
    burn = hull * np.clip((cv.X - 150) / 60, 0, 1) * (cv.noise(5, 3, 4) > 0.5)
    cv.fill(burn, '#302828', 0.5)
    fin = cv.poly([(190, 112), (230, 80), (240, 90), (215, 122)])
    cv.fill(fin, '#8088a0')
    cv.bevel(fin, 1, 0.6)
    fl = cv.poly([(220, 140), (232, 104), (240, 120), (248, 96), (256, 122), (266, 108), (272, 150)])
    fire(cv, fl, speed=2, regs=5)
    smoke = cv.noise(9, 4, 21)
    sm = np.clip((smoke - 0.45) * 2.5, 0, 1) * (cv.X > 200) * (cv.Y < 105) * np.clip((cv.X - 200) / 20, 0, 1)
    cv.fill(sm, '#4a3a4a', 0.75)
    cv.cut_sky(sm > 0.3)
    for i in range(60):
        rng = np.random.default_rng(i)
        x, y = rng.uniform(0, W), rng.uniform(165, 192)
        b = cv.line([(x, y), (x + rng.uniform(-2, 2), y - rng.uniform(5, 10))], 0.8)
        cv.fill(b, mix(rgb('#4a1868'), rgb('#c070e0'), rng.random()))
    cv.vignette(0.35)
    return cv


def jungle():
    cv = Canvas()
    m = cv.rect(0, 0, W, H)
    cv.fill(m, cv.vgrad([(0, '#30104a'), (120, '#6a2a7a'), (H, '#20082a')]))
    light = cv.poly([(150, 0), (200, 0), (230, 192), (110, 192)])
    cv.add(light, '#ffc0ff', 0.12)
    for i, (x, h, s) in enumerate([(20, 200, 1), (80, 190, 2), (250, 200, 3), (300, 190, 4), (130, 170, 5), (200, 175, 6)]):
        trunk = cv.poly([(x - 10, 192), (x - 7, 0), (x + 7, 0), (x + 10, 192)])
        cv.fill(trunk, cv.texture('#2a0c3a', '#6a2a7a', 1.5, 3, s, 1.6, sx=cv.X * 3, sy=cv.Y * 0.3))
        cv.bevel(trunk, 4, 0.7)
        if i >= 4:
            cv.tint(trunk, 0.6)
    canopy = cv.noise(12, 4, 3) * (cv.Y < 60)
    cm = np.clip((canopy - 0.35) * 3, 0, 1) * np.clip((60 - cv.Y) / 20, 0, 1)
    cv.fill(cm, cv.texture('#3a0a5a', '#a040c0', 3, 3, 8, 1.5))
    vines = np.zeros((cv.h, cv.w), np.float32)
    for x in (60, 110, 180, 230, 280):
        vines = np.maximum(vines, cv.line([(x, 0), (x + 4, 40), (x - 3, 80 + x % 30)], 1.2))
    cv.fill(vines, '#6a2a8a')
    gr = cv.poly([(0, 150), (W, 150), (W, H), (0, H)])
    cv.fill(gr, cv.texture('#2a0c3a', '#6a2a7a', 3, 4, 5))
    for x, y, r in ((40, 160, 28), (120, 170, 22), (290, 165, 30), (200, 178, 20)):
        bush(cv, x, y, r, ('#4a1260', '#b050d0'), x)
    br = cv.line([(250, 60), (190, 70), (160, 78)], 3)
    cv.fill(br, '#4a1a5a')
    cv.bevel(br, 1, 0.6)
    fr = np.zeros((cv.h, cv.w), np.float32)
    for x in (172, 184):
        f = cv.ellipse(x, 86, 5, 7)
        cv.fill(f, '#3060ff')
        cv.shade_sphere(x, 86, 6, f, spec=0.7)
        fr = np.maximum(fr, f)
    cv.glow(fr, '#4080ff', 5, 0.3)
    cv.vignette(0.45)
    return cv


def river():
    cv = Canvas()
    alien_sky(cv, 70, seed=11)
    hills(cv, 70, 8, '#4a1a6a', '#3a1458', 5)
    far = cv.poly([(0, 70), (W, 70), (W, 96), (0, 96)])
    cv.fill(far, cv.texture('#5a2070', '#9a4ab0', 3, 3, 6))
    cave = cv.ellipse(240, 92, 22, 18) * (cv.Y < 96)
    cv.fill(cave, '#0a0410')
    rocky = cv.ellipse(240, 90, 34, 26) * (1 - cave) * (cv.Y < 96)
    cv.fill(rocky, cv.texture('#3a2a4a', '#6a5a80', 3, 3, 4))
    cv.bevel(rocky, 3, 0.6)
    glow_c = cv.ellipse(240, 92, 14, 10) * cave
    cv.glow(glow_c, '#60e0ff', 10, 0.4)
    wm = cv.poly([(0, 96), (W, 96), (W, 150), (0, 158)])
    water(cv, wm, '#103a6a', '#30a0e0', '#c0ffff', speed=3, regs=4, glow='#40c0ff')
    bank = cv.poly([(0, 154), (W, 146), (W, H), (0, H)])
    cv.fill(bank, cv.texture('#3a1458', '#8a3aa8', 2.5, 3, 7))
    alien_tree(cv, 60, 156, 150, 12)
    vine = cv.line([(70, 40), (110, 80), (150, 100)], 1.2)
    cv.fill(vine, '#3a8a40')
    cv.vignette(0.35)
    return cv


def cave_crystals(cv, n, seed, y0=110, y1=192, cols=(('#60e0ff', '#104060'), ('#ff80e0', '#501040'), ('#a0ff80', '#204010'))):
    rng = np.random.default_rng(seed)
    for i in range(n):
        x = rng.uniform(0, W)
        y = rng.uniform(y0, y1)
        h = rng.uniform(10, 30)
        c = cols[rng.integers(len(cols))]
        crystal(cv, x, y, h, h * 0.35, c[0], c[1], lean=rng.uniform(-6, 6), glow=rng.random() < 0.5)


def cave_room(cv, col=('#2a1a3a', '#4a3a60'), seed=3):
    m = cv.rect(0, 0, W, H)
    cv.fill(m, cv.texture(col[0], col[1], 10, 5, seed, 1.6))
    r = cv.ellipse(160, 110, 150, 90)
    cv.fill(r, cv.texture(rgb(col[0]) * 0.5, rgb(col[1]) * 0.6, 8, 5, seed + 1, 1.5))
    cv.bevel(np.clip(m - r * 0.8, 0, 1), 6, 0.7)
    fl = cv.ellipse(160, 200, 200, 60)
    cv.fill(fl, cv.texture(rgb(col[0]) * 0.8, col[1], 4, 4, seed + 2, 1.4))


def ccave():
    cv = Canvas(bg='#0a0612')
    cave_room(cv, ('#1a1030', '#3a2a5a'), 5)
    cave_crystals(cv, 18, 4)
    big = crystal(cv, 160, 150, 80, 36, '#80f0ff', '#104060')
    cv.glow(big, '#80f0ff', 30, 0.5)
    cv.animate(big * (cv.c[..., 2] > 0.6), ['#e0ffff', '#80f0ff', '#40a0d0', '#80f0ff'], speed=6)
    boulder = cv.ellipse(270, 160, 30, 22)
    cv.fill(boulder, cv.texture('#4a4050', '#7a7090', 3, 4, 9))
    cv.shade_sphere(262, 152, 32, boulder, amb=0.35)
    dia = np.zeros((cv.h, cv.w), np.float32)
    for i in range(6):
        d = cv.poly([(236 + i * 5, 178), (238 + i * 5, 174), (240 + i * 5, 178), (238 + i * 5, 181)])
        dia = np.maximum(dia, d)
    cv.fill(dia, '#ffffff')
    cv.animate(dia, ['#ffffff', '#c0f0ff', '#ffffff', '#ffe0ff'], speed=3, regs=2, phase=(cv.X / 10) % 1)
    vine = cv.line([(0, 60), (40, 90), (70, 96)], 1.5)
    cv.fill(vine, '#3a8a40')
    cv.vignette(0.45)
    return cv


def vgate():
    cv = Canvas()
    alien_sky(cv, 100, seed=13)
    purple_ground(cv, 104, 9)
    wall = cv.rect(0, 50, W, 150)
    weave = ((np.sin(cv.X * 0.6) * np.sin(cv.Y * 0.9)) > 0)
    cv.fill(wall, np.where(weave[..., None], rgb('#7a5030'), rgb('#4a2c18')))
    cv.fill(wall, cv.texture('#3a2010', '#9a6a3a', 1.5, 3, 4), 0.4)
    cv.bevel(wall, 2, 0.4)
    top = np.zeros((cv.h, cv.w), np.float32)
    for x in range(0, W, 8):
        top = np.maximum(top, cv.poly([(x, 52), (x + 8, 52), (x + 4, 40)]))
    cv.fill(top, '#6a4024')
    gate = cv.rect(120, 70, 200, 150)
    cv.fill(gate, '#1a0c06')
    for x in range(124, 200, 10):
        b = cv.rect(x, 70, x + 4, 150)
        cv.fill(b, '#6a4428')
        cv.bevel(b, 0.8, 0.6)
    stronkie(cv, 236, 160, 44)
    spear = cv.line([(256, 172), (262, 96)], 1.5)
    cv.fill(spear, '#8a6a40')
    tip = cv.poly([(259, 98), (265, 98), (262, 86)])
    cv.fill(tip, '#c0c8d0')
    cv.vignette(0.35)
    return cv


def hut(cv, x, y, w, h, roof='#6a3a1a', wall='#a07040'):
    body = cv.rect(x - w / 2, y - h, x + w / 2, y)
    cv.fill(body, cv.texture(wall, rgb(wall) * 0.6, 1.5, 3, int(x), 1.6, sx=cv.X * 2, sy=cv.Y * 0.5))
    cv.bevel(body, 2, 0.5)
    rf = cv.poly([(x - w * 0.65, y - h), (x + w * 0.65, y - h), (x, y - h - w * 0.55)])
    cv.fill(rf, cv.texture(roof, rgb(roof) * 1.6, 1.0, 3, int(x) + 1, 1.8, sx=cv.X * 0.6, sy=cv.Y * 2))
    cv.bevel(rf, 2, 0.6)
    d = cv.ellipse(x, y - h * 0.3, w * 0.15, h * 0.3) * (cv.Y < y)
    cv.fill(d, '#1a0c06')
    return body


def vsquare():
    cv = Canvas()
    alien_sky(cv, 90, seed=17)
    purple_ground(cv, 92, 11)
    hut(cv, 160, 96, 50, 26)
    hut(cv, 40, 110, 56, 30)
    hut(cv, 280, 110, 56, 30, '#5a3a6a', '#9a7a50')
    tw = cv.rect(296, 20, 308, 110)
    cv.fill(tw, planks(cv, cv.X, cv.Y, '#4a2c18', '#7a5030', 4, along='v'))
    pave = cv.ellipse(160, 160, 150, 36)
    cv.fill(pave, blocks(cv, cv.X, cv.Y * 2, '#7a6a8a', '#a090b0', 14, 8, '#3a2a4a'))
    fb = cv.ellipse(160, 150, 46, 12)
    cv.fill(fb, '#6a6080')
    rim = fb * (1 - cv.ellipse(160, 149, 40, 9))
    cv.bevel(rim, 1.5, 0.6)
    wt = cv.ellipse(160, 149, 40, 9)
    water(cv, wt, '#2050a0', '#50a0e0', '#e0ffff', speed=3, regs=3)
    col = cv.rect(155, 112, 165, 148)
    cv.fill(col, '#8a80a0')
    cv.bevel(col, 1.5, 0.6)
    spray = np.zeros((cv.h, cv.w), np.float32)
    for s in (-1, 1):
        spray = np.maximum(spray, cv.line([(160, 112), (160 + s * 14, 104), (160 + s * 26, 140)], 1.2))
    cv.fill(spray, '#a0e0ff')
    cv.animate(spray, ['#ffffff', '#a0e0ff', '#5090d0', '#a0e0ff'], speed=3, regs=3, phase=(cv.Y / 12) % 1)
    stronkie(cv, 90, 170, 28)
    stronkie(cv, 240, 176, 24, fur='#5a8ae0')
    cv.vignette(0.35)
    return cv


def market():
    cv = Canvas()
    alien_sky(cv, 84, seed=19)
    purple_ground(cv, 86, 13)
    for i, x in enumerate((60, 160, 260)):
        st = cv.rect(x - 40, 100, x + 40, 150)
        cv.fill(st, planks(cv, cv.X, cv.Y, '#5a3418', '#8a5a2a', 6))
        cv.bevel(st, 2, 0.5)
        aw = cv.poly([(x - 48, 84), (x + 48, 84), (x + 42, 100), (x - 42, 100)])
        stp = ((cv.X / 8).astype(int) % 2 == 0)
        cv.fill(aw * stp, ['#e04080', '#40a0e0', '#e0c040'][i])
        cv.fill(aw * ~stp, '#f0f0f0')
        cv.bevel(aw, 1.5, 0.5)
        for p in (-1, 1):
            cv.fill(cv.rect(x + p * 44, 84, x + p * 44 + 3, 150), '#4a2c18')
        rng = np.random.default_rng(i)
        for k in range(10):
            fx, fy = x - 34 + k * 7, 96 + rng.uniform(-2, 2)
            f = cv.ellipse(fx, fy, 4, 4)
            c = [['#3060ff', '#ff6040', '#ffd040'], ['#f0e0d0', '#e0a0c0', '#c0a080'], ['#60e0ff', '#ff60e0', '#80ff60']][i][k % 3]
            cv.fill(f, c)
            cv.shade_sphere(fx, fy, 4, f, spec=0.6 if i == 2 else 0.2)
    old = stronkie(cv, 160, 186, 46, white=True)
    beard = cv.poly([(150, 160), (170, 160), (164, 186), (156, 186)])
    cv.fill(beard, '#f0f0f8')
    cv.bevel(beard, 1, 0.4)
    cv.vignette(0.35)
    return cv


def elder():
    cv = Canvas(bg='#100808')
    m = cv.rect(0, 0, W, H)
    cv.fill(m, cv.rgrad(160, 110, 200, '#7a4a28', '#1a0c06'))
    weave = ((np.sin(cv.X * 0.5 + cv.Y * 0.2) * np.sin(cv.Y * 0.8)) > 0)
    cv.tint(m, np.where(weave, 1.1, 0.85))
    for i in range(9):
        rib = cv.line([(i * 40, 192), (160, -10)], 2)
        cv.fill(rib, '#3a1c0c', 0.7)
    fl = cv.ellipse(160, 200, 220, 50)
    cv.fill(fl, cv.texture('#4a2a14', '#6a4022', 3, 3, 4))
    cush = cv.ellipse(160, 160, 46, 12)
    cv.fill(cush, cv.texture('#8a1a4a', '#c04070', 2, 3, 5))
    cv.shade_sphere(160, 154, 46, cush, amb=0.5)
    stronkie(cv, 160, 160, 60, white=True)
    beard = cv.poly([(148, 128), (172, 128), (166, 156), (154, 156)])
    cv.fill(beard, '#f0f0f8')
    rng = np.random.default_rng(4)
    for i in range(12):
        x, y = rng.uniform(40, 280), rng.uniform(160, 186)
        if abs(x - 160) < 50:
            continue
        sc = cylinder(cv, x - 10, y - 3, x + 10, y + 3, '#e0d0a0', vertical=False)
    candles = np.zeros((cv.h, cv.w), np.float32)
    for x in (60, 260):
        cv.fill(cv.rect(x - 2, 130, x + 2, 150), '#e0e0c0')
        f = cv.ellipse(x, 127, 2, 3.5)
        candles = np.maximum(candles, f)
    cv.glow(candles, '#ffa040', 40, 0.4)
    cv.fill(candles, '#fff0a0')
    cv.animate(candles, ['#fff0a0', '#ffc050', '#fff8d0'], speed=3, regs=2, phase=(cv.X > 160) * 0.5)
    cv.vignette(0.45)
    return cv


def workshop():
    cv = Canvas(bg='#100808')
    r = Room(cv, (60, 30, 260, 120))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, planks(cv, 1 / z * 50, a, '#3a2010', '#6a4020', 7, along='v'))
        r.depth_shade(m, z, 0.85, 0.45)
    m, u, z = r.surface('floor')
    cv.fill(m, planks(cv, u, 1 / z * 30, '#3a2010', '#5a3418', 6))
    back = cv.rect(60, 30, 260, 120)
    cv.fill(back, planks(cv, cv.X, cv.Y, '#3a2010', '#6a4020', 7, along='v'))
    cv.tint(back, 0.7)
    for x, y, r_ in ((100, 60, 14), (130, 70, 9), (220, 56, 18), (200, 80, 8)):
        g = cv.ellipse(x, y, r_, r_)
        teeth = np.zeros((cv.h, cv.w), np.float32)
        for a in np.linspace(0, 2 * np.pi, 12, endpoint=False):
            teeth = np.maximum(teeth, cv.ellipse(x + np.cos(a) * r_, y + np.sin(a) * r_, r_ * 0.18, r_ * 0.18))
        gm = np.clip(g + teeth, 0, 1) * (1 - cv.ellipse(x, y, r_ * 0.3, r_ * 0.3))
        cv.fill(gm, '#c09040')
        cv.bevel(gm, 1, 0.8)
    wing = cv.poly([(110, 130), (230, 116), (250, 124), (130, 140)])
    cv.fill(wing, cv.texture('#c0b090', '#f0e0c0', 2, 2, 3))
    cv.bevel(wing, 1, 0.5)
    frame = cv.line([(140, 150), (170, 128), (210, 150)], 2)
    cv.fill(frame, '#6a4020')
    table(cv, 40, 140, 160, 30, 8, '#6a4020', '#3a2010')
    stronkie(cv, 250, 182, 50, fur='#4a8af0')
    gog = cv.ellipse(242, 146, 5, 4) + cv.ellipse(258, 146, 5, 4)
    cv.fill(np.clip(gog, 0, 1), '#e0c040')
    cv.fill(cv.ellipse(242, 146, 3, 2.5) + cv.ellipse(258, 146, 3, 2.5), '#60e0ff')
    cv.vignette(0.45)
    return cv


def snow_temple(cv, x, y, s=1.0):
    base = cv.rect(x - 20 * s, y - 12 * s, x + 20 * s, y)
    cv.fill(base, '#e0e8ff')
    dome = cv.ellipse(x, y - 12 * s, 14 * s, 12 * s) * (cv.Y < y - 12 * s)
    cv.fill(dome, '#ffffff')
    cv.glow(np.clip(base + dome, 0, 1), '#ffffc0', 6 * s, 0.6)
    cv.cut_sky(np.clip(base + dome, 0, 1))


def tower():
    cv = Canvas()
    alien_sky(cv, 110, seed=23)
    mountains(cv, 100, 60, '#8a7ab0', '#f8f8ff', 7, '#4a3a6a', 0.5)
    snow_temple(cv, 196, 46, 0.6)
    for x in (214, 222, 230):
        t = cv.poly([(x - 3, 58), (x + 3, 58), (x, 52)])
        cv.fill(t, '#101010')
    ship = cv.poly([(236, 52), (252, 50), (254, 54), (236, 56)])
    cv.fill(ship, '#202028')
    purple_ground(cv, 112, 15)
    rail = cv.poly([(0, 150), (W, 150), (W, H), (0, H)])
    cv.fill(rail, planks(cv, cv.X, cv.Y, '#4a2c18', '#7a5030', 6))
    cv.bevel(cv.rect(0, 146, W, 152), 1, 0.6)
    pole = cv.rect(50, 20, 55, 170)
    cv.fill(pole, '#6a4428')
    cv.bevel(pole, 1, 0.6)
    flag = cv.poly([(55, 22), (110, 28), (104, 46), (55, 52)])
    ph = ((cv.X - 55) / 28) % 1
    cv.fill(flag, '#e04060')
    cv.animate(flag, ['#ff6080', '#e04060', '#b02040', '#e04060'], speed=5, regs=3, phase=ph)
    cv.vignette(0.3)
    return cv


def snow_sky(cv, horizon=110, seed=25):
    m = cv.rect(0, 0, W, horizon + 2)
    cv.fill(m, cv.vgrad([(0, '#2a3a7a'), (horizon, '#c0c8f0')]))
    cv.set_sky(m)
    return m


def snow_ground(cv, m, seed=3):
    cv.fill(m, cv.texture('#c0c8e8', '#f8f8ff', 4, 3, seed, 1.2))


def ledge():
    cv = Canvas()
    snow_sky(cv, 120)
    mountains(cv, 110, 70, '#7a80b0', '#f8f8ff', 3, '#40487a', 0.5)
    rock(cv, [(0, 0), (90, 0), (100, 60), (80, 130), (0, 140)], '#4a4a60', '#7a7a98', 4)
    cave = cv.ellipse(46, 90, 20, 26) * (cv.Y < 110)
    cv.fill(cave, '#0a0a14')
    led = cv.poly([(0, 140), (W, 120), (W, H), (0, H)])
    snow_ground(cv, led, 5)
    cv.bevel(led, 3, 0.3)
    gl = cv.poly([(170, 160), (250, 140), (262, 150), (180, 172)])
    cv.fill(gl, cv.texture('#c0b090', '#f0e0c0', 2, 2, 3))
    cv.bevel(gl, 1, 0.5)
    cv.fill(cv.line([(190, 166), (236, 120), (244, 156)], 2), '#6a4020')
    snow = np.zeros((cv.h, cv.w), np.float32)
    rng = np.random.default_rng(3)
    for i in range(90):
        snow = np.maximum(snow, cv.ellipse(rng.uniform(0, W), rng.uniform(0, H), 0.7, 0.7))
    cv.fill(snow, '#ffffff')
    cv.animate(snow, ['#ffffff', '#c0c8e8', '#ffffff', '#ffffff'], speed=4, regs=3, phase=cv.noise(2, 1, 5))
    cv.vignette(0.3)
    return cv


def icecave():
    cv = Canvas(bg='#0a1020')
    cave_room(cv, ('#3a5a8a', '#a0c0e8'), 7)
    ice = cv.noise(6, 4, 9)
    cv.add(cv.everywhere() * (ice > 0.6), '#c0e0ff', 0.15)
    junk = np.zeros((cv.h, cv.w), np.float32)
    rng = np.random.default_rng(2)
    for i in range(14):
        x, y = rng.uniform(90, 230), rng.uniform(150, 180)
        p = cv.rect(x - 8, y - 5, x + 8, y + 5)
        cv.fill(p, ['#6a6a70', '#8a5a30', '#a0a0a8', '#5a3a2a'][i % 4])
        cv.bevel(p, 1, 0.6)
    beast = cv.ellipse(160, 140, 64, 30)
    cv.fill(beast, cv.texture('#c8d0e0', '#ffffff', 1.2, 3, 4, 1.4))
    cv.shade_sphere(150, 130, 64, beast, amb=0.45)
    head = cv.ellipse(214, 132, 22, 18)
    cv.fill(head, cv.texture('#c8d0e0', '#ffffff', 1.2, 3, 5, 1.4))
    cv.shade_sphere(210, 126, 22, head, amb=0.45)
    for x in (206, 222):
        cv.fill(cv.line([(x - 3, 128), (x + 3, 129)], 1), '#202030')
    horn = cv.poly([(220, 116), (228, 116), (236, 98)])
    cv.fill(horn, '#e0d0a0')
    zz = cv.rect(240, 96, 260, 112) * (((cv.X - 240).astype(int) % 7 < 4) & ((cv.Y - 96).astype(int) % 6 < 2))
    cv.fill(zz, '#ffffff')
    cv.animate(zz, ['#ffffff', '#a0b0d0', '#3a5a8a', '#3a5a8a'], speed=8)
    cv.vignette(0.4)
    return cv


def icebridge():
    cv = Canvas()
    snow_sky(cv, 90)
    mountains(cv, 86, 40, '#7a80b0', '#f8f8ff', 11, '#40487a', 0.45)
    for x in (230, 246, 262):
        t = cv.poly([(x - 7, 86), (x + 7, 86), (x, 74)])
        cv.fill(t, '#141418')
    gorge = cv.poly([(0, 100), (W, 100), (W, H), (0, H)])
    cv.fill(gorge, cv.vgrad([(100, '#40507a'), (H, '#000008')]))
    for side in (0, 1):
        pts = [(0, 96), (110, 104), (90, 192), (0, 192)] if side == 0 else [(W, 96), (210, 104), (230, 192), (W, 192)]
        cl = cv.poly(pts)
        cv.fill(cl, cv.texture('#5a6a90', '#c0d0f0', 4, 4, side + 3))
        cv.bevel(cl, 4, 0.6)
        top = cv.poly(pts[:2] + [(pts[1][0], pts[1][1] + 6), (pts[0][0], pts[0][1] + 6)])
        snow_ground(cv, top, side)
    br = cv.poly([(100, 104), (220, 104), (230, 116), (90, 116)])
    cv.fill(br, cv.vgrad([(104, '#ffffff'), (116, '#80b0e0')]))
    shine = br * (np.abs(((cv.X - cv.Y * 0.5) % 40) - 20) < 2)
    cv.animate(shine, ['#ffffff', '#d0f0ff', '#a0d0ff', '#d0f0ff'], speed=4, regs=3, phase=((cv.X / 40) % 1))
    cv.vignette(0.3)
    return cv


def tent_shape(cv, x, y, w, h, col='#1a1a20'):
    t = cv.poly([(x - w / 2, y), (x + w / 2, y), (x + w * 0.1, y - h), (x - w * 0.1, y - h)])
    cv.fill(t, cv.hgrad([(x - w / 2, rgb(col) * 1.8), (x + w / 2, col)]))
    cv.bevel(t, 2, 0.5)
    d = cv.poly([(x - w * 0.12, y), (x + w * 0.12, y), (x, y - h * 0.6)])
    cv.fill(d, '#050505')
    return t


def camp():
    cv = Canvas()
    snow_sky(cv, 100)
    mountains(cv, 96, 50, '#7a80b0', '#f8f8ff', 13, '#40487a', 0.45)
    g = cv.poly([(0, 110), (W, 104), (W, H), (0, H)])
    snow_ground(cv, g, 7)
    tent_shape(cv, 210, 140, 110, 54)
    tent_shape(cv, 100, 124, 60, 30)
    tent_shape(cv, 290, 122, 50, 26)
    l = cv.ellipse(160, 120, 3, 3)
    cv.fill(l, '#ff2020')
    cv.glow(l, '#ff2020', 10, 0.5)
    cv.animate(l, ['#ff2020', '#300808'], speed=12)
    rock(cv, [(0, 120), (40, 104), (90, 120), (110, 192), (0, 192)], '#3a4058', '#6a7090', 5)
    rock(cv, [(240, 192), (300, 150), (330, 160), (330, 192)], '#3a4058', '#6a7090', 6)
    cv.vignette(0.35)
    return cv


def tent():
    cv = Canvas(bg='#060608')
    m = cv.rect(0, 0, W, H)
    cv.fill(m, cv.rgrad(160, 60, 220, '#3a3a44', '#08080a'))
    for i in range(7):
        cv.fill(cv.line([(i * 53, 192), (160, -20)], 1.5), '#1a1a22', 0.7)
    fl = cv.ellipse(160, 210, 220, 60)
    cv.fill(fl, cv.texture('#2a2a30', '#3a3a44', 3, 3, 4))
    tab = cv.poly([(50, 120), (270, 120), (290, 150), (30, 150)])
    cv.fill(tab, planks(cv, cv.X, cv.Y * 3, '#2a2a30', '#4a4a56', 5))
    cv.fill(cv.rect(30, 150, 290, 156), '#1a1a1e')
    for x in (40, 272):
        cv.fill(cv.rect(x, 156, x + 6, 192), '#1a1a1e')
    mp = cv.poly([(70, 122), (150, 122), (156, 140), (64, 140)])
    cv.fill(mp, cv.texture('#c0b080', '#e0d0a0', 2, 2, 3))
    cv.fill(cv.line([(80, 130), (110, 126), (140, 134)], 0.8) * mp, '#a02020')
    mac = cv.rect(180, 96, 240, 122)
    cv.fill(mac, panels(cv, cv.X, cv.Y, '#3a3e46', '#5a606a', 20, 10, 5))
    cv.bevel(mac, 2, 0.6)
    for i, c in enumerate(['#ff2020', '#20ff40', '#ffd020']):
        blinker(cv, 192 + i * 12, 104, 2, c, '#202020', 8 + i * 3)
    lamp_glow(cv, 160, 30, 80, '#c0d0ff', 0.4)
    cv.fill(cv.ellipse(160, 30, 6, 4), '#e0e8ff')
    cv.vignette(0.45)
    return cv


def steps():
    cv = Canvas()
    snow_sky(cv, 150)
    mountains(cv, 150, 40, '#7a80b0', '#f8f8ff', 17, '#40487a', 0.4)
    snow_temple(cv, 160, 34, 1.2)
    for i in range(24):
        d = i / 24
        y = 192 - (192 - 44) * (1 - (1 - d) ** 1.5)
        y2 = 192 - (192 - 44) * (1 - (1 - (i + 1) / 24) ** 1.5)
        w = 140 * (1 - d) + 18
        st = cv.rect(160 - w, y2, 160 + w, y)
        cv.fill(st, cv.vgrad([(y2, '#e0f0ff'), (y, '#80a0d0')]))
        edge = cv.rect(160 - w, y2, 160 + w, y2 + max(0.6, (y - y2) * 0.3))
        cv.fill(edge, '#ffffff')
    sh = cv.rect(0, 0, W, H) * (cv.Y > 44) * (np.abs(cv.X - 160) < 160)
    sparkle = sh * (cv.noise(1, 1, 4) > 0.82) * (cv.Y > 50)
    cv.animate(sparkle, ['#ffffff', '#c0e0ff', '#80a0d0', '#c0e0ff'], speed=4, regs=3, phase=cv.noise(2, 1, 6))
    cv.vignette(0.3)
    return cv


def tgate():
    cv = Canvas()
    snow_sky(cv, 192)
    star_field(cv, 0, 0, W, 60, 30, 3)
    wall = cv.rect(30, 20, 290, 192)
    cv.fill(wall, blocks(cv, cv.X, cv.Y, '#c0c8e0', '#f0f4ff', 30, 15, '#8088a8'))
    cv.bevel(wall, 3, 0.4)
    arch = cv.rect(90, 50, 230, 192) + cv.ellipse(160, 50, 70, 40)
    arch = np.clip(arch, 0, 1) * (cv.Y > 10)
    cv.fill(arch, cv.vgrad([(10, '#a0c0f0'), (192, '#4a6aa0')]))
    cv.bevel(arch, 3, 0.6, (0.7, 0.7))
    seam = cv.rect(159, 30, 161, 192)
    cv.fill(seam, '#2a3a6a')
    hollow = cv.ellipse(160, 110, 14, 14)
    cv.fill(hollow, '#203060')
    cv.bevel(hollow, 2, 0.8, (0.7, 0.7))
    runes = np.zeros((cv.h, cv.w), np.float32)
    for a in np.linspace(0, 2 * np.pi, 10, endpoint=False):
        x, y = 160 + np.cos(a) * 26, 110 + np.sin(a) * 26
        runes = np.maximum(runes, cv.poly([(x - 2, y), (x, y - 3), (x + 2, y), (x, y + 3)]))
    cv.fill(runes, '#ffffff')
    cv.glow(runes, '#80c0ff', 4, 0.5)
    cv.animate(runes, ['#ffffff', '#a0d0ff', '#4080ff', '#a0d0ff'], speed=5, regs=4,
               phase=((np.arctan2(cv.Y - 110, cv.X - 160) / (2 * np.pi)) % 1))
    cv.vignette(0.3)
    return cv


def statue(cv, x, y, h, mirror=False):
    s = stronkie(cv, x, y, h, fur='#8a8a98')
    cv.fill(s, cv.texture('#7a7a88', '#b0b0c0', 2, 3, abs(int(x))), 0.8)
    cv.shade_sphere(x, y - h * 0.5, h * 0.6, s, amb=0.4)
    eyes = cv.ellipse(x - h * 0.09, y - h * 0.7, h * 0.05, h * 0.05) + cv.ellipse(x + h * 0.09, y - h * 0.7, h * 0.05, h * 0.05)
    cv.fill(np.clip(eyes, 0, 1), '#60e0ff')
    cv.glow(np.clip(eyes, 0, 1), '#60e0ff', 3, 0.6)
    base = cv.rect(x - h * 0.35, y, x + h * 0.35, y + h * 0.15)
    cv.fill(base, '#6a6a78')
    cv.bevel(base, 1, 0.6)
    if mirror:
        mm = cv.ellipse(x + h * 0.3, y - h * 0.5, h * 0.14, h * 0.18)
        cv.fill(mm, cv.lgrad((x, y - h), (x + h, y), '#ffffff', '#8090b0'))
        cv.fill(cv.ellipse(x + h * 0.3, y - h * 0.5, h * 0.17, h * 0.21) * (1 - mm), '#c0a040')
    return np.clip(eyes, 0, 1)


def temple_room(cv, col=('#8a90b0', '#c8d0f0'), back=(70, 30, 250, 120)):
    r = Room(cv, back)
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, blocks(cv, 1 / z * 50, a, col[0], col[1], 24, 12, rgb(col[0]) * 0.6))
        r.depth_shade(m, z, 0.85, 0.45)
    m, u, z = r.surface('floor')
    cv.fill(m, blocks(cv, u, 1 / z * 50, col[0], col[1], 20, 20, rgb(col[0]) * 0.6))
    r.depth_shade(m, z, 0.95, 0.5)
    bk = cv.rect(*back)
    cv.fill(bk, blocks(cv, cv.X, cv.Y, col[0], col[1], 24, 12, rgb(col[0]) * 0.6))
    cv.tint(bk, 0.7)
    return r


def statues():
    cv = Canvas()
    r = temple_room(cv)
    eyes = np.zeros((cv.h, cv.w), np.float32)
    for x, y, h, mir in ((40, 186, 90, False), (100, 150, 56, False), (220, 150, 56, True), (280, 186, 90, False)):
        eyes = np.maximum(eyes, statue(cv, x, y - h * 0.15, h, mirror=mir))
    cv.animate(eyes, ['#60e0ff', '#a0ffff', '#60e0ff', '#2080c0'], speed=7)
    m, u, z = r.surface('floor')
    dust = m * (cv.noise(0.8, 1, 3) > 0.9)
    cv.animate(dust, ['#ffffff', '#c0c8f0', '#8a90b0', '#c0c8f0'], speed=4, regs=3, phase=cv.noise(2, 1, 7))
    x1 = cv.line([(140, 150), (180, 168)], 2) + cv.line([(180, 150), (140, 168)], 2)
    cv.fill(np.clip(x1, 0, 1), '#5a6080')
    cv.vignette(0.35)
    return cv


def mirrors():
    cv = Canvas()
    m = cv.rect(0, 0, W, H)
    cv.fill(m, blocks(cv, cv.X, cv.Y, '#7a80a0', '#b8c0e0', 24, 12, '#4a5070'))
    cv.tint(m, cv.hgrad([(0, '#606060'), (160, '#ffffff'), (W, '#606060')])[..., 0])
    fl = cv.ellipse(160, 200, 220, 60)
    cv.fill(fl, blocks(cv, cv.X, cv.Y * 2, '#7a80a0', '#a8b0d0', 20, 20, '#4a5070'))
    beam = cv.poly([(140, 0), (180, 0), (172, 160), (148, 160)])
    cv.add(beam, '#fff0c0', 0.35)
    motes = beam * (cv.noise(0.7, 1, 2) > 0.8)
    cv.animate(motes, ['#ffffff', '#fff0c0', '#d0c090', '#fff0c0'], speed=4, regs=3, phase=cv.noise(1, 1, 3))
    stand = cv.rect(150, 140, 170, 170)
    cv.fill(stand, cv.hgrad([(150, '#8a90b0'), (156, '#e0e8ff'), (170, '#6a7090')]))
    top = cv.ellipse(160, 140, 14, 4)
    cv.fill(top, '#c0c8e8')
    dr = cv.rect(130, 40, 190, 130) + cv.ellipse(160, 40, 30, 22)
    dr = np.clip(dr, 0, 1)
    cv.fill(dr, cv.vgrad([(18, '#a0b0e0'), (130, '#4a5a90')]))
    cv.bevel(dr, 3, 0.6, (0.7, 0.7))
    eye = cv.ellipse(160, 50, 10, 6)
    cv.fill(eye, '#60e0ff')
    cv.fill(cv.ellipse(160, 50, 3, 4), '#102040')
    cv.glow(eye, '#60e0ff', 6, 0.5)
    cv.vignette(0.35)
    return cv


def starbridge():
    cv = Canvas()
    m = cv.rect(0, 0, W, H)
    cv.fill(m, cv.vgrad([(0, '#0a0620'), (H, '#000004')]))
    nebula(cv, m, '#401060', '#103060', 40, 3, 0.6)
    star_field(cv, 0, 0, W, H, 200, 9)
    d = cv.rect(240, 70, 270, 110) + cv.ellipse(255, 70, 15, 10)
    d = np.clip(d, 0, 1)
    cv.fill(d, cv.vgrad([(60, '#fff0a0'), (110, '#c08020')]))
    cv.glow(d, '#ffd060', 14, 0.6)
    ledge_m = cv.poly([(0, 150), (110, 150), (90, 192), (0, 192)])
    cv.fill(ledge_m, blocks(cv, cv.X, cv.Y, '#7a80a0', '#b8c0e0', 20, 10, '#4a5070'))
    cv.bevel(ledge_m, 3, 0.6)
    cv.vignette(0.3)
    return cv


def heartdoor():
    cv = Canvas()
    r = temple_room(cv, ('#806a40', '#c0a870'), (70, 20, 250, 130))
    d = cv.rect(100, 40, 220, 130) + cv.ellipse(160, 40, 60, 30)
    d = np.clip(d, 0, 1) * (cv.Y > 8)
    cv.fill(d, cv.vgrad([(10, '#fff0a0'), (70, '#e0b040'), (130, '#906010')]))
    cv.bevel(d, 3, 0.7)
    sy = np.zeros((cv.h, cv.w), np.float32)
    rng = np.random.default_rng(5)
    for i in range(24):
        x, y = rng.uniform(110, 210), rng.uniform(30, 124)
        sy = np.maximum(sy, cv.ellipse(x, y, 2, 2) * (1 - cv.ellipse(x, y, 1, 1)))
    cv.fill(sy * d, '#6a4010')
    hb = cv.ellipse(160, 85, 30, 30)
    cv.add(hb * 0 + cv.everywhere() * 0, '#000000', 0)
    glow_m = d * (cv.noise(30, 1, 1) * 0 + 1)
    pulse = d * (np.sqrt((cv.X - 160) ** 2 + (cv.Y - 85) ** 2) < 40)
    cv.animate(pulse * (cv.c[..., 0] > 0.7), ['#fff0a0', '#ffe080', '#ffd060', '#ffe080', '#fff0a0', '#fff8d0'], speed=6)
    cv.vignette(0.4)
    return cv


def heart_orb(cv, x, y, r, weak=False):
    o = cv.ellipse(x, y, r, r)
    cv.glow(o, '#ffd0ff', r * 2, 0.7 if not weak else 0.4)
    cv.fill(o, cv.rgrad(x - r * 0.3, y - r * 0.3, r * 1.2, '#ffffff', '#e060ff'))
    ph = (np.sqrt((cv.X - x) ** 2 + (cv.Y - y) ** 2) / r) % 1
    cols = ['#ffffff', '#ffc0ff', '#e060ff', '#a020c0', '#e060ff', '#ffc0ff']
    if weak:
        cols = ['#e0a0e0', '#a060b0', '#502060', '#301040', '#502060', '#a060b0']
    cv.animate(o, cols, speed=5, regs=4, phase=ph)
    return o


def heart():
    cv = Canvas()
    r = temple_room(cv, ('#6a5a80', '#a898c0'), (60, 20, 260, 120))
    for i in range(4):
        st = cv.rect(110 + i * 8, 128 - i * 10, 210 - i * 8, 138 - i * 10)
        cv.fill(st, cv.vgrad([(118 - i * 10, '#d0c8e8'), (138 - i * 10, '#7a7090')]))
    alt = cv.rect(136, 70, 184, 98)
    cv.fill(alt, cv.hgrad([(136, '#7a7090'), (152, '#e0d8f0'), (184, '#6a6080')]))
    heart_orb(cv, 160, 50, 15, weak=True)
    for x in (66, 254):
        ar = cv.rect(x - 14, 50, x + 14, 130) + cv.ellipse(x, 50, 14, 10)
        cv.fill(np.clip(ar, 0, 1), '#0a0810')
    cv.vignette(0.4)
    return cv


def gallery(cv, col=('#6a5a80', '#a898c0')):
    r = Room(cv, (120, 40, 200, 110))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, blocks(cv, 1 / z * 50, a, col[0], col[1], 24, 12, rgb(col[0]) * 0.6))
        r.depth_shade(m, z, 0.9, 0.35)
    m, u, z = r.surface('floor')
    cv.fill(m, blocks(cv, u, 1 / z * 50, col[0], col[1], 20, 20, rgb(col[0]) * 0.6))
    r.depth_shade(m, z, 0.95, 0.35)
    cv.fill(cv.rect(120, 40, 200, 110), '#0a0810')
    return r


def westgal():
    cv = Canvas()
    r = gallery(cv)
    m, v, z = r.surface('left')
    u = 1 / z * 50
    mural = m * (v > -25) * (v < 15)
    cv.fill(mural, cv.texture('#c0a070', '#e0c890', 3, 2, 4))
    figs = mural * (((np.sin(u * 0.5) > 0.3) & (np.abs(v + 2) < 9)) | ((np.abs(((u * 0.5) % 6.28) - 4.5) < 0.5) & (np.abs(v + 6) < 4)))
    cv.fill(figs, '#3a60b0')
    horn = mural * (np.abs(((u * 0.17) % 6.28) - 1.0) < 0.3) * (np.abs(v + 12) < 3)
    cv.fill(horn, '#e0b030')
    mon = mural * (np.abs(((u * 0.13) % 6.28) - 3.0) < 0.6) * (np.abs(v) < 12)
    cv.fill(mon, '#601010')
    r.depth_shade(mural, z, 0.95, 0.4)
    cv.vignette(0.35)
    return cv


def eastgal():
    cv = Canvas()
    r = gallery(cv)
    cab = np.zeros((cv.h, cv.w), np.float32)
    for k in (-1, 1):
        cab = np.maximum(cab, cv.line([(130 + k * 6, 192), (148 + k * 4, 130), (180 + k * 3, 112)], 4 - k))
    cv.fill(cab, '#1a1a1a')
    cv.bevel(cab, 1.2, 0.7)
    plug = cv.rect(214, 70, 250, 104)
    cv.fill(plug, '#2a2a30')
    cv.bevel(plug, 2, 0.6)
    pins = cv.rect(222, 78, 226, 96) + cv.rect(238, 78, 242, 96)
    cv.fill(np.clip(pins, 0, 1), '#e0c040')
    cv.fill(cv.line([(180, 112), (200, 100), (214, 88)], 4), '#1a1a1a')
    l = blinker(cv, 246, 74, 1.5, '#ff2020', '#300404', 10)
    cv.vignette(0.35)
    return cv


def altar():
    cv = Canvas()
    m = cv.rect(0, 0, W, H)
    cv.fill(m, cv.rgrad(160, 60, 200, '#6a5a80', '#1a1424'))
    heart_orb(cv, 160, 52, 34, weak=True)
    base = cv.rect(90, 110, 230, 192)
    cv.fill(base, cv.hgrad([(90, '#6a6080'), (130, '#d8d0f0'), (230, '#5a5070')]))
    cv.bevel(base, 3, 0.4)
    hollow = cv.ellipse(160, 140, 16, 16)
    cv.fill(hollow, '#201830')
    cv.bevel(hollow, 2, 0.8, (0.7, 0.7))
    lock = cv.poly([(146, 134), (174, 134), (178, 156), (142, 156)])
    cv.fill(lock, '#2a2a30')
    cv.bevel(lock, 1.5, 0.7)
    raven = cv.poly([(150, 140), (160, 136), (172, 140), (164, 144), (172, 150), (158, 146), (150, 152), (154, 144)])
    cv.fill(raven, '#8a8a98')
    cv.bevel(raven, 0.8, 0.6)
    cv.vignette(0.4)
    return cv


def catacomb():
    cv = Canvas(bg='#06040a')
    r = Room(cv, (120, 50, 200, 120))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, cv.texture('#2a2030', '#4a3a58', 4, 4, side.__len__(), 1.5, sx=1 / z * 50, sy=a))
        r.depth_shade(m, z, 0.8, 0.25)
    m, u, z = r.surface('floor')
    cv.fill(m, cv.texture('#2a2030', '#3a3048', 3, 3, 9))
    r.depth_shade(m, z, 0.9, 0.3)
    cv.fill(cv.rect(120, 50, 200, 120), '#050308')
    cr = np.zeros((cv.h, cv.w), np.float32)
    for (x, y, h, c) in [(30, 80, 20, '#60e0ff'), (290, 70, 24, '#ff80e0'), (60, 190, 26, '#60e0ff'), (270, 190, 22, '#a0ff80')]:
        cr = np.maximum(cr, crystal(cv, x, y, h, h * 0.35, c, '#102030', lean=4))
    cv.animate(cr * (cv.c.max(2) > 0.6), ['#ffffff', '#a0f0ff', '#60a0c0', '#a0f0ff'], speed=6, regs=2, phase=(cv.X > 160) * 0.5)
    lv = cv.line([(236, 120), (246, 100)], 2.5)
    cv.fill(lv, '#6a6050')
    cv.bevel(lv, 1, 0.6)
    ar = cv.rect(250, 70, 280, 150) + cv.ellipse(265, 70, 15, 10)
    cv.fill(np.clip(ar, 0, 1), '#050308')
    cv.vignette(0.45)
    return cv


def deadend():
    cv = Canvas(bg='#06040a')
    m = cv.rect(0, 0, W, H)
    cv.fill(m, cv.texture('#2a2030', '#4a3a58', 8, 5, 4, 1.5))
    ch = cv.poly([(80, 192), (240, 192), (200, 130), (120, 130)])
    cv.fill(ch, cv.vgrad([(130, '#100818'), (192, '#000000')]))
    edge = cv.poly([(0, 192), (80, 192), (120, 130), (0, 130)])
    cv.fill(edge, cv.texture('#3a3048', '#5a4a6a', 3, 3, 5))
    cv.bevel(edge, 3, 0.6)
    ar = cv.rect(100, 20, 220, 130) + cv.ellipse(160, 20, 60, 20)
    ar = np.clip(ar, 0, 1)
    cv.fill(ar * (1 - ch), '#0a0610')
    bars = np.zeros((cv.h, cv.w), np.float32)
    for x in range(108, 216, 12):
        bars = np.maximum(bars, crystal(cv, x, 60, 50, 7, '#a0f0ff', '#204060', glow=False))
    cv.glow(bars, '#80e0ff', 6, 0.35)
    cv.vignette(0.45)
    return cv


def mineentry():
    cv = Canvas()
    alien_sky(cv, 100, seed=29)
    rock(cv, [(180, 0), (W, 0), (W, 192), (200, 192), (190, 120)], '#3a2a4a', '#6a5a80', 7)
    tun = cv.ellipse(250, 120, 30, 36) * (cv.Y < 160)
    cv.fill(tun, '#08040c')
    for x in (218, 280):
        b = cv.rect(x, 84, x + 6, 160)
        cv.fill(b, '#6a4428')
        cv.bevel(b, 1, 0.6)
    bm = cv.rect(214, 80, 290, 88)
    cv.fill(bm, '#6a4428')
    cv.bevel(bm, 1, 0.6)
    purple_ground(cv, 150, 17)
    tree(cv, 80, 160, 150, '#4a2060', ('#5a1a7a', '#c060e0'), seed=8)
    kite = cv.poly([(100, 40), (110, 30), (120, 40), (110, 54)])
    cv.fill(kite, '#ff4040')
    cv.bevel(kite, 1, 0.5)
    cv.fill(cv.line([(110, 54), (106, 70), (114, 84)], 0.6), '#e0e0e0')
    pip = stronkie(cv, 140, 176, 30, glow_ears=True)
    tears = cv.ellipse(136, 158, 1, 1.5) + cv.ellipse(146, 158, 1, 1.5)
    cv.animate(np.clip(tears, 0, 1), ['#80c0ff', '#ffffff', '#4080ff'], speed=6)
    cv.vignette(0.35)
    return cv


def maze():
    cv = Canvas(bg='#06040a')
    r = Room(cv, (130, 50, 190, 110))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, cv.texture('#2a3050', '#5a70a0', 3, 4, 3, 1.6, sx=1 / z * 50, sy=a))
        r.depth_shade(m, z, 0.9, 0.15)
    m, u, z = r.surface('floor')
    cv.fill(m, cv.texture('#2a2a40', '#3a3a58', 3, 3, 9))
    r.depth_shade(m, z, 0.9, 0.2)
    cv.fill(cv.rect(130, 50, 190, 110), '#020205')
    for side in ('left', 'right'):
        x, y = r.wall_point(side, 0.55, 0.0)
        o = cv.rect(x - 8, y - 30, x + 8, y) if side == 'left' else cv.rect(x - 8, y - 30, x + 8, y)
        cv.fill(o, '#030308')
    glow = cv.rgrad(160, 200, 160, '#ffffa0', '#000000')
    cv.add(cv.everywhere(), '#ffff80', 0)
    cv.c = np.clip(cv.c * (0.4 + 1.2 * glow[..., 0:1]), 0, 1)
    cr = np.zeros((cv.h, cv.w), np.float32)
    rng = np.random.default_rng(3)
    for i in range(10):
        x = rng.choice([rng.uniform(0, 100), rng.uniform(220, W)])
        cr = np.maximum(cr, crystal(cv, x, rng.uniform(60, 190), rng.uniform(8, 18), 5, '#80c0ff', '#102040', lean=rng.uniform(-4, 4), glow=False))
    cv.animate(cr * (cv.c.max(2) > 0.5), ['#c0e0ff', '#80c0ff', '#4060a0', '#80c0ff'], speed=7, regs=2, phase=cv.noise(3, 1, 2))
    cv.vignette(0.5)
    return cv


def vein():
    cv = Canvas(bg='#06040a')
    cave_room(cv, ('#2a2038', '#4a3a60'), 11)
    v = cv.line([(0, 70), (80, 60), (160, 78), (240, 56), (W, 70)], 10)
    cv.fill(v, '#204060')
    sp = v * (cv.noise(1.2, 2, 4) > 0.55)
    cv.fill(sp, '#c0f8ff')
    cv.glow(v, '#60e0ff', 10, 0.5)
    cv.animate(sp, ['#ffffff', '#a0f0ff', '#60c0e0', '#a0f0ff'], speed=4, regs=3, phase=cv.noise(2, 1, 8))
    rng = np.random.default_rng(5)
    for i in range(16):
        x, y, s = rng.uniform(0, W), rng.uniform(140, 190), rng.uniform(5, 14)
        pts = [(x + np.cos(a) * s * rng.uniform(0.7, 1.1), y + np.sin(a) * s * 0.6) for a in np.linspace(0, 2 * np.pi, 7, endpoint=False)]
        rock(cv, pts, '#3a3048', '#6a5a80', i)
    pick = cv.line([(230, 170), (260, 140)], 2)
    cv.fill(pick, '#8a6a40')
    head = cv.line([(250, 134), (266, 148)], 2.5)
    cv.fill(head, '#a0a0a8')
    cv.vignette(0.45)
    return cv


SCENES = dict(wreck=wreck, crash=crash, jungle=jungle, river=river, ccave=ccave, vgate=vgate, vsquare=vsquare,
              market=market, elder=elder, workshop=workshop, tower=tower, ledge=ledge, icecave=icecave,
              icebridge=icebridge, camp=camp, tent=tent, steps=steps, tgate=tgate, statues=statues, mirrors=mirrors,
              starbridge=starbridge, heartdoor=heartdoor, heart=heart, westgal=westgal, eastgal=eastgal, altar=altar,
              catacomb=catacomb, deadend=deadend, mineentry=mineentry, maze=maze, vein=vein)
