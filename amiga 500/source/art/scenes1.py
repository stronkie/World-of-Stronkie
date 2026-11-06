"""Ravenmoor: the grounds, the manor and the launch base (parts 1-3)."""
import numpy as np
from paint import Canvas, rgb, mix, W, H
from kit import *


def stormy_sky(cv, horizon=120, seed=3, moon_at=(262, 34)):
    night_sky(cv, '#060818', '#3a3060', horizon, 150, seed=seed)
    if moon_at:
        moon(cv, moon_at[0], moon_at[1], 15)
    clouds(cv, cv.rect(0, 0, W, horizon), 0, 75, '#262448', '#6a6a9a', seed=seed + 5, cover=0.45)


def manor_silhouette(cv, x, y, s=1.0, lit=True):
    pts = [(x - 42 * s, y), (x - 42 * s, y - 30 * s), (x - 30 * s, y - 42 * s), (x - 18 * s, y - 30 * s), (x - 18 * s, y - 38 * s),
           (x, y - 54 * s), (x + 18 * s, y - 38 * s), (x + 18 * s, y - 30 * s), (x + 30 * s, y - 42 * s), (x + 42 * s, y - 30 * s), (x + 42 * s, y)]
    m = cv.poly(pts)
    cv.fill(m, cv.vgrad([(y - 54 * s, '#26243c'), (y, '#121019')]))
    tw = cv.rect(x + 26 * s, y - 60 * s, x + 32 * s, y - 40 * s)
    cv.fill(tw, '#1a1828')
    if lit:
        for wx, wy in [(-34, -24), (-26, -24), (-8, -30), (4, -30), (24, -24), (32, -24), (-2, -14)]:
            w = cv.rect(x + wx * s, y + wy * s, x + (wx + 3) * s, y + (wy + 5) * s)
            cv.fill(w, '#ffd060')
            cv.glow(w, '#ffa030', 3, 0.4)
    return m


def road():
    cv = Canvas()
    stormy_sky(cv)
    hills(cv, 112, 10, '#14142a', '#101020', 21)
    manor_silhouette(cv, 160, 100)
    cv.animate(cv.rect(158, 86, 161, 91), ['#ffd060', '#ffd060', '#a06020', '#ffd060', '#ffe080'], speed=9)
    g = hills(cv, 120, 3, '#1c3018', '#0c140a', 22)
    grass(cv, g * (cv.Y > 118), '#0e1a0a', '#2a4420', seed=6)
    road_m = cv.poly([(150, 112), (170, 112), (240, 192), (80, 192)])
    cv.fill(road_m, cv.texture('#2a2018', '#5a4632', 3, 4, 9, 1.5))
    for i in range(10):
        p = cv.ellipse(120 + i * 9 + (i % 3) * 4, 150 + (i * 7) % 40, 6, 1.5) * road_m
        cv.fill(p, '#6a7090', 0.5)
    for px in (95, 210):
        post = cv.rect(px, 70, px + 16, 160)
        cv.fill(post, blocks(cv, cv.X, cv.Y, '#3a3a44', '#6a6a78', 8, 5, '#1a1a20'))
        cv.bevel(post, 2, 0.6)
        cap = cv.rect(px - 3, 64, px + 19, 71)
        cv.fill(cap, '#5a5a68')
        cv.bevel(cap, 1.5, 0.7)
        ball = cv.ellipse(px + 8, 59, 6, 6)
        cv.fill(ball, '#6a6a7a')
        cv.shade_sphere(px + 8, 59, 6, ball, spec=0.3)
    bars = np.zeros((cv.h, cv.w), np.float32)
    for x0, x1 in ((111, 140), (180, 210)):
        for i in range(7):
            x = x0 + i * (x1 - x0) / 6
            top = 92 - abs(i - 3) * 2
            bars = np.maximum(bars, cv.line([(x, 150), (x, top)], 1.2))
            bars = np.maximum(bars, cv.poly([(x - 1.5, top), (x + 1.5, top), (x, top - 4)]))
        bars = np.maximum(bars, cv.line([(x0, 100), (x1, 100)], 1.2))
        bars = np.maximum(bars, cv.line([(x0, 140), (x1, 140)], 1.2))
    cv.fill(bars, '#20202a')
    cv.add(bars * (cv.X > 150), '#5060a0', 0.25)
    tree(cv, 30, 150, 110, '#2a2016', seed=3, bare=True)
    tree(cv, 290, 160, 120, '#2a2016', seed=5, bare=True)
    cv.vignette(0.4)
    return cv


def garden():
    cv = Canvas()
    stormy_sky(cv, 95, seed=7, moon_at=(60, 28))
    hills(cv, 92, 6, '#1a1a30', '#14141f', 31)
    manor_silhouette(cv, 160, 96, 0.9)
    g = hills(cv, 98, 2, '#1e3418', '#0e180a', 32)
    grass(cv, g, '#0e1a0a', '#2e4a22', seed=9)
    # long grass in front
    for i in range(140):
        rng = np.random.default_rng(i)
        x = rng.uniform(0, W)
        y = rng.uniform(150, 194)
        bl = cv.line([(x, y), (x + rng.uniform(-3, 3), y - rng.uniform(6, 14))], 0.7)
        cv.fill(bl, mix(rgb('#1a3014'), rgb('#4a6a30'), rng.random()))
    # the mound of earth
    mound = cv.ellipse(160, 150, 34, 12) * (cv.Y < 156)
    cv.fill(mound, cv.texture('#3a2614', '#6a4a2a', 2, 4, 3, 1.8))
    cv.shade_sphere(160, 156, 34, mound, amb=0.45)
    sh = cv.line([(176, 150), (184, 120)], 1.5)
    cv.fill(sh, '#6a4a28')
    blade = cv.poly([(173, 150), (179, 150), (178, 160), (174, 160)])
    cv.fill(blade, '#9098a0')
    cv.bevel(blade, 0.8, 0.6)
    # the shed (right) and the well (left)
    sh_body = cv.rect(240, 92, 300, 140)
    cv.fill(sh_body, planks(cv, cv.X, cv.Y, '#3a2614', '#6a4a2a', 6, along='v'))
    roof = cv.poly([(234, 94), (306, 94), (290, 76), (250, 76)])
    cv.fill(roof, cv.texture('#2a2a30', '#4a4a56', 2, 3, 5))
    cv.bevel(roof, 1.5, 0.6)
    door(cv, 260, 108, 278, 140, '#3a2410', '#5a3a1c', knob=False)
    well = cv.ellipse(56, 128, 24, 8)
    wb = cv.rect(32, 110, 80, 128)
    cv.fill(np.clip(wb + well, 0, 1) * (cv.Y > 108), blocks(cv, cv.X, cv.Y, '#4a4a50', '#7a7a80', 8, 5, '#202024'))
    cv.bevel(wb, 2, 0.5)
    cv.fill(cv.ellipse(56, 110, 24, 6), '#0a0a0c')
    for px in (36, 74):
        p = cv.rect(px, 82, px + 4, 112)
        cv.fill(p, '#4a3018')
        cv.bevel(p, 0.8, 0.6)
    rf = cv.poly([(28, 84), (84, 84), (56, 70)])
    cv.fill(rf, '#3a2a20')
    cv.bevel(rf, 1, 0.6)
    tree(cv, 120, 102, 60, '#2a2016', seed=12, bare=True, depth=3)
    bush(cv, 210, 138, 16, ('#0e2410', '#2a4a22'), 5)
    bush(cv, 108, 142, 14, ('#0e2410', '#2a4a22'), 6)
    cv.vignette(0.4)
    return cv


def shed():
    cv = Canvas()
    r = Room(cv, (80, 40, 240, 128))
    for side in ('left', 'right'):
        m, v, z = r.surface(side)
        cv.fill(m, planks(cv, 1 / z * 40, v, '#3a2614', '#6a4a2a', 7, along='v'))
        r.depth_shade(m, z, 0.85, 0.5)
    m, u, z = r.surface('floor')
    cv.fill(m, planks(cv, u, 1 / z * 30, '#2a1a0c', '#4a321a', 5))
    r.depth_shade(m, z, 0.9, 0.5)
    m, u, z = r.surface('ceiling')
    cv.fill(m, planks(cv, u, 1 / z * 30, '#1a1008', '#3a2412', 6))
    back = cv.rect(80, 40, 240, 128)
    cv.fill(back, planks(cv, cv.X, cv.Y, '#3a2614', '#6a4a2a', 7, along='v'))
    cv.tint(back, 0.7)
    # a small window with moonlight
    win = window_frame(cv, 196, 54, 226, 80, '#2a1a0c')
    cv.fill(win, cv.vgrad([(54, '#1a1a40'), (80, '#4a4a80')]))
    moon(cv, 214, 62, 5, glow=False)
    beam = cv.poly([(196, 54), (226, 54), (180, 192), (110, 192)])
    cv.add(beam * (1 - win), '#8090d0', 0.12)
    # workbench
    table(cv, 96, 190, 116, 20, 12, '#5a3a1a', '#3a2410')
    for i, c in enumerate(['#7a2a20', '#2a4a6a', '#6a6a20']):
        tin = cylinder(cv, 104 + i * 12, 100, 112 + i * 12, 113, c)
    # tools on the wall
    tools = [(120, 50, 'saw'), (140, 48, 'rake'), (160, 46, 'spade'), (178, 50, 'hammer')]
    for x, y, t in tools:
        h = cv.line([(x, y), (x, y + 40)], 2)
        cv.fill(h, '#6a4626')
        cv.bevel(h, 0.8, 0.6)
        if t == 'rake':
            hd = cv.rect(x - 7, y + 40, x + 7, y + 43)
            for i in range(6):
                hd = np.maximum(hd, cv.rect(x - 6 + i * 2.4, y + 43, x - 5.2 + i * 2.4, y + 48))
        elif t == 'spade':
            hd = cv.poly([(x - 5, y + 40), (x + 5, y + 40), (x + 4, y + 52), (x, y + 55), (x - 4, y + 52)])
        elif t == 'saw':
            hd = cv.poly([(x - 2, y + 20), (x + 14, y + 22), (x + 14, y + 30), (x - 2, y + 30)])
        else:
            hd = cv.rect(x - 5, y, x + 5, y + 5)
        cv.fill(hd, '#7a7468')
        cv.tint(hd, cv.noise(1.5, 2, x) * 0.6 + 0.6)
        cv.bevel(hd, 0.8, 0.6)
    # cobwebs in the corners
    for cx, cy, sx in ((80, 40, 1), (240, 40, -1)):
        web = np.zeros((cv.h, cv.w), np.float32)
        for a in np.linspace(0, np.pi / 2, 6):
            web = np.maximum(web, cv.line([(cx, cy), (cx + sx * np.cos(a) * 30, cy + np.sin(a) * 30)], 0.3))
        for rr in (8, 15, 22, 29):
            pts = [(cx + sx * np.cos(a) * rr, cy + np.sin(a) * rr) for a in np.linspace(0, np.pi / 2, 7)]
            web = np.maximum(web, cv.line(pts, 0.3))
        cv.fill(web, '#c0c4d0', 0.6)
    barrel(cv, 60, 170, 16, 38)
    cv.vignette(0.45)
    return cv


def well():
    cv = Canvas()
    stormy_sky(cv, 110, seed=11, moon_at=(280, 26))
    hills(cv, 104, 8, '#141428', '#10101c', 41)
    g = hills(cv, 112, 3, '#1e3418', '#0e180a', 42)
    grass(cv, g, '#0e1a0a', '#2e4a22', seed=4)
    tree(cv, 40, 128, 100, '#2a2016', seed=21, bare=True)
    # the well, big
    body = cv.rect(100, 112, 220, 172)
    cv.fill(body, blocks(cv, cv.X, cv.Y, '#4a4a50', '#82828a', 14, 8, '#202024'))
    xx = (cv.X - 160) / 60
    cv.tint(body, 0.55 + 0.6 * np.clip(1 - (xx + 0.3) ** 2, 0, 1))
    rim = cv.ellipse(160, 112, 62, 13)
    cv.fill(rim, blocks(cv, cv.X * 1.3, cv.Y * 2.5, '#5a5a62', '#92929a', 14, 8, '#202024'))
    hole = cv.ellipse(160, 112, 50, 9)
    cv.fill(hole, cv.vgrad([(103, '#050506'), (121, '#121218')]))
    for px in (104, 210):
        p = cv.rect(px, 50, px + 7, 114)
        cv.fill(p, planks(cv, cv.X, cv.Y, '#3a2410', '#6a4626', 7, along='v'))
        cv.bevel(p, 1.5, 0.6)
    roof = cv.poly([(92, 54), (228, 54), (160, 22)])
    cv.fill(roof, planks(cv, cv.X, cv.Y, '#3a2014', '#5a3424', 4))
    cv.bevel(roof, 2, 0.6)
    axle = cylinder(cv, 108, 62, 214, 68, '#5a3a1c', vertical=False)
    rope = cv.line([(160, 68), (160, 118)], 1)
    cv.fill(rope, '#8a7a50')
    stub = cv.rect(214, 63, 220, 67)
    cv.fill(stub, '#6a6a70')
    cv.vignette(0.4)
    return cv


def porch():
    cv = Canvas()
    m = cv.rect(0, 0, W, H)
    cv.fill(m, blocks(cv, cv.X, cv.Y, '#3a3440', '#5a5260', 18, 9, '#1a1620'))
    cv.tint(m, 0.75)
    # columns
    for x in (40, 252):
        col = cylinder(cv, x, 0, x + 28, 160, '#8a8494')
        cap = cv.rect(x - 4, 0, x + 32, 10)
        cv.fill(cap, '#7a7482')
        cv.bevel(cap, 1.5, 0.6)
        base = cv.rect(x - 4, 152, x + 32, 162)
        cv.fill(base, '#6a6472')
        cv.bevel(base, 1.5, 0.6)
    # the door
    door(cv, 110, 30, 210, 160, '#3a1e0c', '#6a3a1a', '#1e1208', knob=False, arch=True)
    knocker = cv.ellipse(160, 80, 7, 7) * (1 - cv.ellipse(160, 80, 5, 5))
    cv.fill(knocker, '#c8a040')
    cv.bevel(knocker, 0.8, 0.8)
    lion = cv.ellipse(160, 70, 5, 5)
    cv.fill(lion, '#c8a040')
    cv.shade_sphere(160, 70, 5, lion, spec=0.6)
    ks = cv.rect(190, 96, 196, 104)
    cv.fill(ks, '#c8a040')
    cv.bevel(ks, 0.8, 0.8)
    # lantern with flickering light
    lm = cv.rect(226, 40, 236, 56)
    cv.fill(lm, '#ffd070')
    cv.glow(lm, '#ff9030', 25, 0.6)
    fr = cv.rect(224, 38, 238, 58) * (1 - lm)
    cv.fill(fr, '#202020')
    cv.animate(lm, ['#ffd070', '#ffe090', '#ffb050', '#ffd070', '#ff9040'], speed=4)
    # floor boards and the mat
    fl = cv.poly([(0, 160), (W, 160), (W, H), (0, H)])
    d = np.maximum(cv.Y - 120, 0.1)
    cv.fill(fl, planks(cv, (cv.X - 160) * 40 / d, 400 / d, '#3a2614', '#6a4a2a', 3))
    mat = cv.poly([(118, 166), (202, 166), (214, 188), (106, 188)])
    cv.fill(mat, cv.texture('#5a3a1a', '#8a6a3a', 0.6, 2, 9, 1.4))
    cv.bevel(mat, 1, 0.5)
    txt = cv.rect(130, 173, 190, 181) * ((cv.X.astype(int) // 3 + cv.Y.astype(int) // 2) % 2 == 0)
    cv.fill(txt, '#3a2410', 0.6)
    cv.vignette(0.4)
    return cv


def hall():
    cv = Canvas()
    r = Room(cv, (90, 40, 230, 120))
    m, u, v = r.surface('floor')
    cv.fill(m, checker(u * 0.5, (1 / v) * 40, '#e8e4dc', '#1a1a1e', 10))
    cv.fill(m, cv.texture('#000000', '#ffffff', 2, 2, 5), 0.06)
    r.depth_shade(m, v, 1.0, 0.6)
    for side in ('left', 'right'):
        m, vv, z = r.surface(side)
        cv.fill(m, wallpaper(cv, (1 / z) * 30, vv, '#3a1830', '#5a2848', 8))
        wain = m * (vv > 18)
        cv.fill(wain, planks(cv, (1 / z) * 30, vv, '#3a2010', '#5a3418', 6, along='v'))
        r.depth_shade(m, z, 0.9, 0.55)
    m, u, z = r.surface('ceiling')
    cv.fill(m, cv.texture('#2a1620', '#3a2030', 4, 3, 3))
    r.depth_shade(m, z, 0.8, 0.5)
    back = cv.rect(90, 40, 230, 120)
    cv.fill(back, wallpaper(cv, cv.X, cv.Y, '#3a1830', '#5a2848', 8))
    cv.fill(back * (cv.Y > 100), planks(cv, cv.X, cv.Y, '#3a2010', '#5a3418', 5, along='v'))
    cv.tint(back, 0.62)
    for i in range(10):
        y = 120 - i * 7
        w = 40 - i * 2.2
        st = cv.rect(160 - w, y - 7, 160 + w, y)
        cv.fill(st, cv.lgrad((0, y - 7), (0, y), '#7a4a24', '#3a2010'))
        cv.fill(cv.rect(160 - w, y - 7, 160 + w, y - 5.5), '#a06a3a')
        cv.fill(cv.rect(160 - w * 0.6, y - 7, 160 + w * 0.6, y) , '#6a1018', 0.7)
    for x in (118, 196):
        p = cv.rect(x, 55, x + 6, 120)
        cv.fill(p, '#3a2010')
        cv.bevel(p, 1, 0.6)
    for a, b in (((120, 92), (200, 78)), ((122, 78), (198, 94))):
        pl = cv.line([a, b], 3)
        cv.fill(pl, '#8a6a40')
        cv.bevel(pl, 1, 0.6)
    door(cv, 46, 70, 70, 132, arch=True)
    door(cv, 250, 70, 274, 132, arch=True)
    door(cv, 150 - 52, 92, 150 - 40, 120, knob=False)
    pf = cv.rect(100, 50, 116, 72)
    cv.fill(pf, '#c09030')
    cv.bevel(pf, 1, 0.8)
    cv.fill(cv.rect(102, 52, 114, 70), cv.texture('#202018', '#3a3020', 2, 2, 3))
    person(cv, 108, 72, 22, coat='#301010', skin='#c09070', hair='#d0d0d0')
    cv.fill(cv.line([(160, 0), (160, 14)], 0.8), '#806020')
    arm = cv.ellipse(160, 18, 22, 5) * (1 - cv.ellipse(160, 17, 20, 3.5))
    cv.fill(arm, '#c09030')
    cv.bevel(arm, 0.8, 0.6)
    flames = np.zeros((cv.h, cv.w), np.float32)
    for i in range(7):
        x = 140 + i * 6.6
        cv.fill(cv.rect(x - 0.8, 10, x + 0.8, 16), '#f0f0e0')
        flames = np.maximum(flames, cv.ellipse(x, 8.5, 1.2, 2))
    cv.glow(flames, '#ffc060', 14, 0.5)
    cv.fill(flames, '#ffe080')
    cv.animate(flames, ['#ffe080', '#fff0c0', '#ffc040', '#ffe080'], speed=5, regs=2, phase=(cv.X / 13) % 1)
    cv.vignette(0.35)
    return cv


def library():
    cv = Canvas()
    r = Room(cv, (70, 30, 250, 130))
    m, u, z = r.surface('floor')
    cv.fill(m, cv.texture('#4a1018', '#6a2028', 3, 3, 4))
    carpet = m * (np.abs(u) < 70)
    cv.fill(carpet * ((np.abs(np.abs(u) - 62) < 3)), '#c09030')
    r.depth_shade(m, z, 0.95, 0.55)
    for side in ('left', 'right'):
        m, v, z = r.surface(side)
        cv.fill(m, planks(cv, 1 / z * 40, v, '#2a1608', '#4a2a12', 9, along='v'))
        r.depth_shade(m, z, 0.85, 0.5)
    m, u, z = r.surface('ceiling')
    cv.fill(m, planks(cv, u, 1 / z * 30, '#1a0e06', '#2a1a0c', 6))
    bookshelf(cv, 70, 30, 250, 130, 5, seed=4)
    cv.tint(cv.rect(70, 30, 250, 130), 0.85)
    # the red book sticking out
    rb = cv.poly([(186, 72), (192, 72), (194, 92), (188, 94)])
    cv.fill(rb, '#d02020')
    cv.bevel(rb, 0.8, 0.7)
    cv.glow(rb, '#ff4020', 4, 0.2)
    for side in ('left', 'right'):
        m, v, z = r.surface(side)
        cv.fill(m, book_texture(cv, 1 / z * 60, v, 20))
        r.depth_shade(m, z, 0.85, 0.5)
    # a reading lamp
    lamp_glow(cv, 40, 120, 40, '#ffb050', 0.55)
    st = cv.rect(38, 120, 42, 170)
    cv.fill(st, '#c0a040')
    shade = cv.poly([(28, 120), (52, 120), (46, 106), (34, 106)])
    cv.fill(shade, '#3a6a3a')
    cv.bevel(shade, 1, 0.6)
    chair = cv.poly([(252, 140), (300, 140), (306, 192), (246, 192)])
    cv.fill(chair, cv.texture('#5a1010', '#8a2020', 2, 3, 6))
    cv.bevel(chair, 3, 0.7)
    cv.vignette(0.45)
    return cv


def kitchen():
    cv = Canvas()
    r = Room(cv, (60, 36, 260, 120))
    m, u, z = r.surface('floor')
    cv.fill(m, checker(u * 0.4, 1 / z * 34, '#5a4e40', '#463a2e', 10))
    r.depth_shade(m, z, 0.9, 0.55)
    for side in ('left', 'right'):
        m, v, z = r.surface(side)
        cv.fill(m, checker(1 / z * 30, v, '#c8c8c0', '#a8a8a0', 6))
        r.depth_shade(m, z, 0.8, 0.45)
    m, u, z = r.surface('ceiling')
    cv.fill(m, '#40403a')
    r.depth_shade(m, z, 0.7, 0.5)
    back = cv.rect(60, 36, 260, 120)
    cv.fill(back, checker(cv.X, cv.Y, '#b8b8b0', '#98988f', 6))
    cv.tint(back, 0.7)
    # iron stove
    stove = cv.rect(110, 70, 190, 120)
    cv.fill(stove, cv.texture('#1a1a1e', '#3a3a40', 2, 3, 8))
    cv.bevel(stove, 2, 0.6)
    fb = cv.rect(130, 90, 170, 110)
    cv.fill(fb, '#0a0a0a')
    emb = cv.rect(134, 100, 166, 108)
    fire(cv, emb, speed=4, regs=3)
    cv.fill(cv.rect(146, 30, 156, 70), '#2a2a30')
    cv.bevel(cv.rect(146, 30, 156, 70), 1, 0.6)
    # pots hanging
    cv.fill(cv.line([(90, 40), (230, 40)], 1.5), '#3a3a40')
    for i, x in enumerate([100, 128, 186, 214]):
        cv.fill(cv.line([(x, 40), (x, 48)], 0.6), '#808080')
        p = cv.ellipse(x, 54, 8, 6) * (cv.Y > 50)
        cv.fill(p, '#b06a30' if i % 2 else '#808890')
        cv.shade_sphere(x, 52, 9, p, spec=0.5)
    # steps down (left), microwave (right corner)
    for i in range(5):
        st = cv.poly([(20 + i * 6, 130 + i * 10), (60 + i * 3, 130 + i * 10), (60 + i * 3, 136 + i * 10), (20 + i * 6, 136 + i * 10)])
        cv.fill(st, '#5a5048')
        cv.tint(st, 0.9 - i * 0.12)
    mw = cv.rect(232, 92, 276, 118)
    cv.fill(mw, '#d0d0c8')
    cv.bevel(mw, 1.5, 0.6)
    glass = cv.rect(236, 96, 262, 114)
    cv.fill(glass, '#202830')
    cv.add(glass * (cv.X < 248), '#ffffff', 0.08)
    for i in range(3):
        cv.fill(cv.rect(265, 98 + i * 5, 272, 100 + i * 5), '#404040')
    table(cv, 230, 290, 120, 30, 8, '#7a5a3a', '#4a3020')
    cv.vignette(0.45)
    return cv


def cellar():
    cv = Canvas(bg='#000000')
    r = Room(cv, (90, 50, 230, 120))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, blocks(cv, 1 / z * 40, a * (1 if side != 'ceiling' else 1), '#3a342c', '#5a5246', 16, 8, '#161410'))
        r.depth_shade(m, z, 0.85, 0.35)
    m, u, z = r.surface('floor')
    cv.fill(m, cv.texture('#2a241c', '#3e352a', 3, 4, 2))
    r.depth_shade(m, z, 0.9, 0.35)
    back = cv.rect(90, 50, 230, 120)
    cv.fill(back, blocks(cv, cv.X, cv.Y, '#3a342c', '#5a5246', 16, 8, '#161410'))
    cv.tint(back, 0.4)
    arch = cv.ellipse(160, 80, 26, 30) * (cv.Y > 50)
    cv.fill(arch, '#050404')
    for i, (x, y, s) in enumerate([(40, 170, 1.3), (95, 150, 1.0), (240, 150, 1.0), (285, 172, 1.3), (130, 128, 0.7), (190, 128, 0.7)]):
        barrel(cv, x, y, 18 * s, 36 * s, seed=i) if False else barrel(cv, x, y, 18 * s, 36 * s)
    # candle light
    cd = cv.rect(157, 150, 163, 168)
    cv.fill(cd, '#e8e0c8')
    cv.bevel(cd, 0.8, 0.5)
    fl = cv.ellipse(160, 146, 2, 4)
    cv.glow(fl, '#ffb040', 45, 0.55)
    cv.fill(fl, '#fff0a0')
    cv.animate(fl, ['#fff0a0', '#ffd060', '#fff8c0', '#ffc040'], speed=3, regs=2, phase=(cv.Y / 4) % 1)
    cv.fill(cv.ellipse(160, 168, 10, 3), '#4a4030')
    cv.vignette(0.55)
    return cv


def study():
    cv = Canvas()
    night_sky(cv, '#0a0c22', '#2a3060', 100, 30, seed=2)
    moon(cv, 172, 54, 8, glow=False)
    r = Room(cv, (70, 30, 250, 120))
    m, u, z = r.surface('floor')
    cv.fill(m, planks(cv, u, 1 / z * 34, '#2a160a', '#5a341a', 4))
    r.depth_shade(m, z, 0.9, 0.5)
    for side in ('left', 'right'):
        m, v, z = r.surface(side)
        cv.fill(m, wallpaper(cv, 1 / z * 30, v, '#1a2a20', '#2a4030', 9))
        r.depth_shade(m, z, 0.8, 0.45)
    m, u, z = r.surface('ceiling')
    cv.fill(m, '#1a1814')
    win = cv.rect(130, 36, 190, 100)
    back = cv.rect(70, 30, 250, 120) * (1 - win)
    cv.fill(back, wallpaper(cv, cv.X, cv.Y, '#1a2a20', '#2a4030', 9))
    cv.tint(back, 0.7)
    window_frame(cv, 130, 36, 190, 100, '#2a1a0c', (2, 3))
    beam = cv.poly([(130, 100), (190, 100), (230, 192), (100, 192)])
    cv.add(beam, '#90a0e0', 0.12)
    # desk with papers
    desk = cv.rect(90, 128, 230, 170)
    cv.fill(desk, planks(cv, cv.X, cv.Y, '#3a1e0a', '#6a3a1a', 10))
    cv.bevel(desk, 2, 0.6)
    top = cv.poly([(84, 128), (236, 128), (226, 116), (94, 116)])
    cv.fill(top, planks(cv, cv.X, cv.Y * 3, '#5a3418', '#8a5a2a', 6))
    rng = np.random.default_rng(3)
    for i in range(7):
        x, y = rng.uniform(100, 210), rng.uniform(117, 125)
        a = rng.uniform(-0.4, 0.4)
        p = cv.poly([(x, y), (x + 12 * np.cos(a), y + 3 * np.sin(a)), (x + 12 * np.cos(a) - 2, y + 6), (x - 2, y + 6 - 3 * np.sin(a))])
        cv.fill(p, '#e8e0c8')
        cv.fill(cv.rect(x + 1, y + 2, x + 9, y + 2.5) * p, '#606060')
    for i in range(3):
        d = cv.rect(100 + i * 44, 140, 136 + i * 44, 160)
        cv.bevel(d, 1, 0.6, light=(0.7, 0.7))
    # shelf with the jar
    sh = cv.rect(250, 70, 300, 74)
    cv.fill(sh, '#5a3418')
    jar = cv.rect(262, 52, 278, 70)
    cv.fill(jar, '#8040c0')
    cv.glow(jar, '#c060ff', 6, 0.4)
    cv.animate(jar, ['#9050d0', '#b070f0', '#c080ff', '#b070f0', '#9050d0', '#7030b0'], speed=6)
    lid = cv.rect(261, 49, 279, 53)
    cv.fill(lid, '#a08040')
    cv.add(cv.rect(264, 54, 266, 68), '#ffffff', 0.4)
    cv.vignette(0.45)
    return cv


def secret():
    cv = Canvas(bg='#000000')
    r = Room(cv, (80, 40, 240, 120))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, blocks(cv, 1 / z * 40, a, '#2a2a34', '#45455a', 14, 7, '#101016'))
        r.depth_shade(m, z, 0.7, 0.3)
    m, u, z = r.surface('floor')
    cv.fill(m, blocks(cv, u, 1 / z * 50, '#2a2a34', '#3a3a48', 16, 16, '#101016'))
    r.depth_shade(m, z, 0.8, 0.35)
    back = cv.rect(80, 40, 240, 120)
    cv.fill(back, blocks(cv, cv.X, cv.Y, '#2a2a34', '#45455a', 14, 7, '#101016'))
    cv.tint(back, 0.45)
    # the glowing circle
    ring = cv.ellipse(160, 158, 100, 24) * (1 - cv.ellipse(160, 158, 94, 21.5))
    syms = np.zeros((cv.h, cv.w), np.float32)
    for i in range(12):
        a = i / 12 * 2 * np.pi
        x, y = 160 + np.cos(a) * 84, 158 + np.sin(a) * 19
        syms = np.maximum(syms, cv.poly([(x - 3, y), (x, y - 2), (x + 3, y), (x, y + 2)]))
    glow_m = np.maximum(ring, syms)
    cv.glow(glow_m, '#40ff90', 8, 0.6)
    cv.fill(glow_m, '#80ffb0')
    cv.animate(glow_m, ['#80ffb0', '#40e080', '#20a060', '#40e080', '#a0ffd0', '#e0fff0'], speed=4, regs=4,
               phase=((np.arctan2(cv.Y - 158, (cv.X - 160) / 4) / (2 * np.pi)) % 1))
    # the chair with uncle Edmund
    ch = cv.rect(145, 120, 175, 150)
    cv.fill(ch, planks(cv, cv.X, cv.Y, '#3a1e0a', '#6a3a1a', 6, along='v'))
    cv.bevel(ch, 1.5, 0.6)
    cv.fill(cv.rect(143, 95, 177, 122), '#4a2810')
    person(cv, 160, 150, 52, coat='#5a4a3a', skin='#e0b090', hair='#e0e0e0', beard='#e0e0e0')
    for y in (122, 132):
        rope = cv.line([(140, y), (180, y + 2)], 1.2)
        cv.fill(rope, '#b09060')
    cv.vignette(0.5)
    return cv


def stairs():
    cv = Canvas(bg='#000000')
    r = Room(cv, (130, 20, 190, 70), vp=(160, 40))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, blocks(cv, 1 / z * 50, a, '#3a3630', '#5e574a', 16, 9, '#161410'))
        r.depth_shade(m, z, 0.9, 0.2)
    cv.fill(cv.rect(130, 20, 190, 70), '#020202')
    # steps going down into the dark
    for i in range(14):
        d0 = i / 14
        z0 = 1 / (1 + (1 - d0) * 3)
        z1 = 1 / (1 + (1 - (i + 1) / 14) * 3)
        y0 = 40 + 30 / z0 * 0 + (H - 40) * (1 - d0) ** 1.6
        y1 = 40 + (H - 40) * (1 - (i + 1) / 14) ** 1.6
        hw0 = 30 + 130 * (1 - d0) ** 1.6
        hw1 = 30 + 130 * (1 - (i + 1) / 14) ** 1.6
        tread = cv.poly([(160 - hw0, y0), (160 + hw0, y0), (160 + hw1, y0 - (y0 - y1) * 0.35), (160 - hw1, y0 - (y0 - y1) * 0.35)])
        riser = cv.poly([(160 - hw1, y0 - (y0 - y1) * 0.35), (160 + hw1, y0 - (y0 - y1) * 0.35), (160 + hw1, y1), (160 - hw1, y1)])
        cv.fill(riser, cv.texture('#2a2620', '#3e382e', 2, 3, i))
        cv.fill(tread, cv.texture('#5a544a', '#7e7666', 2, 3, i + 20))
        cv.tint(np.clip(tread + riser, 0, 1), max(0.1, 1.0 - i * 0.07))
    for x, y in ((40, 60), (280, 60)):
        t = cv.rect(x - 2, y, x + 2, y + 14)
        cv.fill(t, '#4a3018')
        fl = cv.ellipse(x, y - 3, 3, 5)
        cv.glow(fl, '#ff9030', 30, 0.45)
        fire(cv, fl, speed=3, regs=2)
    cv.vignette(0.5)
    return cv


def bunker():
    cv = Canvas()
    r = Room(cv, (110, 50, 210, 120))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, panels(cv, 1 / z * 60, a, '#3a4048', '#5a6270', 24, 14, 5))
        r.depth_shade(m, z, 0.9, 0.45)
    m, u, z = r.surface('floor')
    grating(cv, m, u, 1 / z * 40, '#3a3e44', 5)
    r.depth_shade(m, z, 0.9, 0.4)
    lights = np.zeros((cv.h, cv.w), np.float32)
    for d in (0.15, 0.45, 0.75):
        x0, y0 = r.wall_point('left', d, 1.0)
        x1, _ = r.wall_point('right', d, 1.0)
        l = cv.rect(160 - (160 - x0) * 0.3, y0 + 1, 160 + (x1 - 160) * 0.3, y0 + 3 + (1 - d) * 3)
        lights = np.maximum(lights, l)
    cv.fill(lights, '#e0f0ff')
    cv.glow(lights, '#a0c0ff', 10, 0.5)
    cv.animate(lights, ['#e0f0ff', '#e0f0ff', '#c0d0e0', '#e0f0ff', '#ffffff'], speed=7)
    # blast door (back) with card slot
    bd = cv.rect(110, 50, 210, 120)
    cv.fill(bd, panels(cv, cv.X, cv.Y, '#4a5058', '#6a7480', 50, 70, 6, False))
    st = bd * (cv.Y > 105)
    warning_stripes(cv, st, '#e0b000', 5)
    seam = cv.rect(159, 50, 161, 105)
    cv.fill(seam, '#1a1c20')
    slot = cv.rect(192, 76, 202, 90)
    cv.fill(slot, '#202428')
    cv.bevel(slot, 0.8, 0.6, light=(0.7, 0.7))
    blinker(cv, 197, 72, 1.5, '#ff3030')
    cv.vignette(0.4)
    return cv


def lockers():
    cv = Canvas()
    r = Room(cv, (60, 40, 260, 124))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, panels(cv, 1 / z * 60, a, '#3a4048', '#4a525c', 30, 30, 7, False))
        r.depth_shade(m, z, 0.85, 0.45)
    m, u, z = r.surface('floor')
    cv.fill(m, checker(u * 0.5, 1 / z * 40, '#4a5058', '#3a3e46', 10))
    r.depth_shade(m, z, 0.9, 0.5)
    back = cv.rect(60, 40, 260, 124)
    cv.fill(back, '#3a4048')
    for i in range(8):
        x0 = 66 + i * 24
        lk = cv.rect(x0, 46, x0 + 22, 122)
        cv.fill(lk, cv.lgrad((x0, 0), (x0 + 22, 0), '#5a7090', '#3a4a64'))
        cv.bevel(lk, 1, 0.6)
        for j in range(4):
            cv.fill(cv.rect(x0 + 6, 52 + j * 3, x0 + 16, 53 + j * 3), '#202838')
        cv.fill(cv.rect(x0 + 17, 80, x0 + 19, 88), '#c0c8d0')
        if i == 5:
            lab = cv.rect(x0 + 3, 64, x0 + 19, 70)
            cv.fill(lab, '#e8e0c0')
            cv.fill(cv.rect(x0 + 5, 66, x0 + 17, 67.5) * ((cv.X.astype(int) % 2) == 0), '#202020')
    bench = cv.rect(90, 140, 230, 148)
    cv.fill(bench, planks(cv, cv.X, cv.Y, '#6a4a2a', '#9a7040', 8))
    cv.bevel(bench, 1, 0.6)
    for x in (100, 214):
        cv.fill(cv.rect(x, 148, x + 6, 168), '#3a3e46')
    cv.fill(cv.rect(60, 34, 260, 38), '#e8f0ff')
    cv.glow(cv.rect(60, 34, 260, 38), '#c0d0ff', 10, 0.4)
    cv.vignette(0.4)
    return cv


def starraven(cv, x, y, s=1.0, lit=True):
    """the silver ship, standing (y = ground)"""
    body = cv.poly([(x - 14 * s, y - 20 * s), (x - 16 * s, y - 70 * s), (x - 8 * s, y - 108 * s), (x, y - 120 * s), (x + 8 * s, y - 108 * s),
                    (x + 16 * s, y - 70 * s), (x + 14 * s, y - 20 * s)])
    cv.fill(body, cv.hgrad([(x - 16 * s, '#606878'), (x - 6 * s, '#e8f0ff'), (x + 16 * s, '#40485a')]))
    for sgn in (-1, 1):
        fin = cv.poly([(x + sgn * 12 * s, y - 50 * s), (x + sgn * 36 * s, y - 10 * s), (x + sgn * 34 * s, y), (x + sgn * 12 * s, y - 18 * s)])
        cv.fill(fin, cv.hgrad([(x - 36 * s, '#8088a0'), (x + 36 * s, '#404858')]))
        cv.bevel(fin, 1, 0.5)
    noz = cv.poly([(x - 10 * s, y - 20 * s), (x + 10 * s, y - 20 * s), (x + 13 * s, y - 6 * s), (x - 13 * s, y - 6 * s)])
    cv.fill(noz, '#30343c')
    win = cv.ellipse(x, y - 92 * s, 5 * s, 6 * s)
    cv.fill(win, '#204080')
    cv.add(cv.ellipse(x - 1.5 * s, y - 94 * s, 1.5 * s, 2 * s), '#ffffff', 0.6)
    stripe = body * (np.abs(cv.Y - (y - 60 * s)) < 2 * s)
    cv.fill(stripe, '#c02020')
    cv.tint(stripe, cv.hgrad([(x - 16 * s, '#808080'), (x - 6 * s, '#ffffff'), (x + 16 * s, '#606060')])[..., 0])
    txt = body * (np.abs(cv.Y - (y - 45 * s)) < 1.2 * s) * (np.abs(cv.X - x) < 7 * s) * ((cv.X * 2).astype(int) % 3 > 0)
    cv.fill(txt, '#202840')
    return body


def hangar():
    cv = Canvas()
    m = cv.rect(0, 0, W, H)
    cv.fill(m, cv.texture('#2a2622', '#4a443c', 8, 5, 3, 1.5))
    cv.tint(m, cv.vgrad([(0, '#909090'), (120, '#ffffff')])[..., 0])
    roof = cv.ellipse(160, 0, 130, 40)
    cv.fill(roof, cv.vgrad([(0, '#3a3e48'), (40, '#5a606c')]))
    for i in range(7):
        cv.fill(cv.line([(40 + i * 40, 0), (160 + (i - 3) * 30, 38)], 1), '#2a2e36')
    fl = cv.poly([(0, 140), (W, 140), (W, H), (0, H)])
    cv.fill(fl, cv.texture('#3a3a3e', '#55555a', 6, 3, 8))
    pad = cv.ellipse(160, 150, 90, 18)
    cv.fill(pad, '#4a4e56')
    cv.bevel(pad, 2, 0.6)
    ring = pad * (1 - cv.ellipse(160, 150, 84, 15.5))
    warning_stripes(cv, ring, '#e0b000', 6)
    starraven(cv, 160, 148, 1.0)
    cv.glow(cv.ellipse(160, 60, 30, 70), '#c0d8ff', 25, 0.15)
    for x in (30, 290):
        gan = cv.rect(x - 5, 50, x + 5, 150)
        cv.fill(gan, panels(cv, cv.X * 3, cv.Y, '#806020', '#c09030', 10, 10, 2, False))
        cv.bevel(gan, 1, 0.6)
        b = blinker(cv, x, 46, 2.2, '#ff2020')
    for i in range(6):
        l = cv.ellipse(30 + i * 52, 10 + abs(i - 2.5) * 6, 5, 2)
        cv.fill(l, '#fff8e0')
        cv.glow(l, '#fff0c0', 18, 0.4)
    door_n = cv.rect(130, 104, 190, 140)
    cv.vignette(0.4)
    return cv


def control():
    cv = Canvas()
    r = Room(cv, (60, 30, 260, 110))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, panels(cv, 1 / z * 60, a, '#2a3038', '#3a424e', 24, 14, 9))
        r.depth_shade(m, z, 0.8, 0.45)
    m, u, z = r.surface('floor')
    cv.fill(m, checker(u * 0.5, 1 / z * 40, '#2a2e34', '#22262c', 10))
    back = cv.rect(60, 30, 260, 110)
    cv.fill(back, panels(cv, cv.X, cv.Y, '#2a3038', '#3a424e', 40, 26, 9))
    cv.tint(back, 0.8)
    for i, (c, k) in enumerate([('#30e0a0', 'graph'), ('#40a0ff', 'radar'), ('#ffb030', 'lines'), ('#30e0a0', 'wave')]):
        screen(cv, 70 + i * 47, 40, 108 + i * 47, 72, c, content=k, seed=i)
    console(cv, 40, 120, 280, 175, '#3a4250', seed=7, slope=16)
    slot = cv.ellipse(160, 128, 8, 3)
    cv.fill(slot, '#101418')
    cv.fill(cv.ellipse(160, 128, 9.5, 4) * (1 - slot), '#c0a040')
    lv = cv.line([(290, 110), (300, 80)], 3)
    cv.fill(lv, '#808890')
    cv.bevel(lv, 1, 0.6)
    knob = cv.ellipse(301, 78, 6, 6)
    cv.fill(knob, '#e02020')
    cv.shade_sphere(301, 78, 6, knob, spec=0.6)
    base = cv.rect(284, 108, 300, 116)
    cv.fill(base, '#505860')
    cv.bevel(base, 1, 0.6)
    cv.vignette(0.4)
    return cv


def shipin():
    cv = Canvas()
    m = cv.rect(0, 0, W, H)
    cv.fill(m, cv.rgrad(160, 80, 200, '#4a5464', '#1a1e26'))
    # curved walls of lights
    for side in (-1, 1):
        wall = cv.poly([(160 + side * 60, 20), (160 + side * 170, 0), (160 + side * 170, 150), (160 + side * 60, 110)])
        cv.fill(wall, panels(cv, cv.X, cv.Y, '#2a3038', '#3e4654', 14, 10, 4 + side, False))
        cv.tint(wall, 0.85)
        bl = np.zeros((cv.h, cv.w), np.float32)
        rng = np.random.default_rng(10 + side)
        for row in range(10):
            for col in range(5):
                x = 160 + side * (75 + col * 16)
                y = 26 + row * 10 + col * 3 * (1 if side > 0 else 1) - col * 2
                l = cv.rect(x - 3, y, x + 3, y + 3) * wall
                c = ['#ff4040', '#40ff60', '#ffd040', '#40a0ff'][(row + col) % 4]
                cv.fill(l, c)
                cv.glow(l, c, 1.5, 0.3)
                if rng.random() < 0.6:
                    bl = np.maximum(bl, l)
        cv.animate(bl, ['#ff4040', '#401010', '#40ff60', '#102010', '#ffe040', '#40a0ff', '#101830'], speed=5, regs=4,
                   phase=cv.noise(1.5, 1, 9 + side))
    fw = cv.poly([(100, 20), (220, 20), (210, 70), (110, 70)])
    cv.fill(fw, cv.texture('#2a2622', '#4a443c', 6, 4, 3))
    cv.add(fw, '#405070', 0.15)
    cv.fill(cv.poly([(100, 20), (220, 20), (210, 70), (110, 70)]) * (1 - cv.poly([(104, 23), (216, 23), (207, 67), (113, 67)])), '#505868')
    seat = cv.poly([(130, 100), (190, 100), (196, 160), (124, 160)])
    cv.fill(seat, cv.texture('#3a2a20', '#6a4a30', 2, 3, 3))
    cv.bevel(seat, 4, 0.7)
    head = cv.ellipse(160, 96, 22, 10)
    cv.fill(head, '#4a3424')
    cv.bevel(head, 2, 0.6)
    console(cv, 60, 150, 260, 192, '#384050', seed=11, slope=10)
    btn = cv.ellipse(160, 158, 10, 4)
    cv.fill(btn, '#e01818')
    cv.shade_sphere(160, 156, 10, btn, spec=0.6)
    cv.glow(btn, '#ff2020', 6, 0.4)
    cv.animate(btn, ['#ff2020', '#ff2020', '#a01010', '#ff6060'], speed=10)
    cv.vignette(0.35)
    return cv


SCENES = dict(road=road, garden=garden, shed=shed, well=well, porch=porch, hall=hall, library=library, kitchen=kitchen,
              cellar=cellar, study=study, secret=secret, stairs=stairs, bunker=bunker, lockers=lockers, hangar=hangar,
              control=control, shipin=shipin)
