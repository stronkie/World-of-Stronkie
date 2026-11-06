"""The Iron Raven, Vex's flagship (parts 14-16)."""
import numpy as np
from paint import Canvas, rgb, mix, W, H
from kit import *
from scenes1 import starraven, manor_silhouette
from scenes2 import scifi_room, earth

BLACK = ('#16161c', '#2a2a34')
RED = '#ff2030'


def red_strip(cv, m, speed=10):
    cv.fill(m, RED)
    cv.glow(m, RED, 6, 0.4)
    cv.animate(m, ['#ff4050', '#c01020', '#600810', '#c01020'], speed=speed, regs=3, phase=(cv.X / 40) % 1)


def guard(cv, x, y, h):
    p = person(cv, x, y, h, coat='#1a1a22', legs='#101016', head_col='#2a2a34')
    visor = cv.rect(x - h * 0.06, y - h * 0.9, x + h * 0.06, y - h * 0.86)
    cv.fill(visor, RED)
    cv.glow(visor, RED, 3, 0.5)
    return p


def raven_emblem(cv, x, y, s):
    b = cv.poly([(x - 20 * s, y - 4 * s), (x - 6 * s, y - 8 * s), (x, y - 16 * s), (x + 6 * s, y - 8 * s), (x + 20 * s, y - 4 * s),
                 (x + 6 * s, y), (x + 4 * s, y + 10 * s), (x, y + 6 * s), (x - 4 * s, y + 10 * s), (x - 6 * s, y)])
    cv.fill(b, '#c01020')
    cv.bevel(b, 1, 0.6)
    return b


def shuttle(cv, x, y, s):
    b = cv.poly([(x - 30 * s, y), (x - 20 * s, y - 14 * s), (x + 24 * s, y - 14 * s), (x + 34 * s, y - 4 * s), (x + 30 * s, y)])
    cv.fill(b, cv.vgrad([(y - 14 * s, '#4a4a58'), (y, '#141418')]))
    cv.bevel(b, 1.5, 0.5)
    w = cv.poly([(x + 14 * s, y - 13 * s), (x + 24 * s, y - 13 * s), (x + 30 * s, y - 6 * s), (x + 16 * s, y - 6 * s)])
    cv.fill(w, '#a01020')


def fhangar():
    cv = Canvas()
    r = scifi_room(cv, (40, 30, 280, 120), wall=BLACK, floor=('#1a1a20', '#26262e'), pw=30, ph=16, dark=0.4)
    for i, (x, y, s) in enumerate([(80, 116, 0.6), (160, 116, 0.6), (240, 116, 0.6), (60, 140, 0.9), (260, 140, 0.9)]):
        shuttle(cv, x, y, s)
    door_m = cv.rect(140, 60, 180, 120)
    cv.fill(door_m, panels(cv, cv.X, cv.Y, '#2a2a34', '#3a3a46', 20, 30, 7))
    cv.bevel(door_m, 2, 0.6)
    hol = cv.ellipse(160, 82, 6, 7) + cv.ellipse(152, 80, 3, 3) + cv.ellipse(168, 80, 3, 3) + cv.rect(156, 88, 164, 102)
    cv.fill(np.clip(hol, 0, 1), '#08080a')
    cv.bevel(np.clip(hol, 0, 1), 1, 0.8, (0.7, 0.7))
    red_strip(cv, cv.rect(40, 28, 280, 30))
    starraven(cv, 120, 188, 0.6)
    crate(cv, 70, 150, 150, 190, 8, '#3a3a40', '#5a5a64', label='VEX')
    cv.vignette(0.4)
    return cv


def fcorr():
    cv = Canvas()
    r = scifi_room(cv, (130, 60, 190, 104), wall=BLACK, floor=('#141418', '#22222a'), pw=20, ph=10, dark=0.25, light=False)
    for t in (0.15, 0.45, 0.75):
        for side in ('left', 'right'):
            x, y = r.wall_point(side, t, 0.5)
            pass
    m, u, z = r.surface('ceiling')
    strip = m * (np.abs(u) < 3)
    red_strip(cv, strip, 8)
    m, u, z = r.surface('floor')
    red_strip(cv, m * (np.abs(np.abs(u) - 26) < 1.2), 8)
    lift = cv.rect(140, 64, 180, 104)
    cv.fill(lift, cv.hgrad([(140, '#3a3a46'), (160, '#6a6a7a'), (180, '#3a3a46')]))
    cv.fill(cv.rect(159.5, 64, 160.5, 104), '#101010')
    cp = cv.rect(130, 98, 190, 106)
    warning_stripes(cv, cp, '#c0a000', 4)
    guard(cv, 196, 140, 64)
    for side in ('left', 'right'):
        x, y = r.wall_point(side, 0.3, 0.0)
        x2, y2 = r.wall_point(side, 0.45, 0.0)
        top = r.wall_point(side, 0.3, 0.8)[1]
        d = cv.poly([(x, y), (x2, y2), (x2, r.wall_point(side, 0.45, 0.8)[1]), (x, top)])
        cv.fill(d, '#08080c')
        cv.bevel(d, 1, 0.6)
    cv.vignette(0.45)
    return cv


def breakroom():
    cv = Canvas()
    scifi_room(cv, (60, 30, 260, 120), wall=BLACK, floor=('#1a1a22', '#2a2a32'), dark=0.45)
    po = cv.rect(190, 44, 236, 100)
    cv.fill(po, cv.vgrad([(44, '#e0d040'), (100, '#e06020')]))
    cv.bevel(po, 1, 0.5)
    ch = cv.ellipse(213, 70, 10, 12)
    cv.fill(ch, '#ffffff')
    cv.fill(cv.poly([(213, 56), (219, 52), (217, 60)]), RED)
    cv.fill(cv.rect(198, 86, 228, 92), '#202020')
    arc = cv.rect(80, 50, 130, 120)
    cv.fill(arc, cv.hgrad([(80, '#2a2a40'), (105, '#4a4a6a'), (130, '#20202e')]))
    cv.bevel(arc, 2, 0.6)
    screen(cv, 88, 58, 122, 86, '#40ff80', content='graph', seed=3)
    table(cv, 110, 230, 150, 18, 10, '#3a3a46', '#16161c')
    badge = cv.rect(170, 144, 182, 150)
    cv.fill(badge, '#e0c040')
    cv.glow(badge, '#ffe080', 3, 0.4)
    guard(cv, 92, 186, 70)
    guard(cv, 140, 186, 66)
    cv.vignette(0.4)
    return cv


def holodeck():
    cv = Canvas()
    m = cv.rect(0, 0, W, 104)
    cv.fill(m, cv.vgrad([(0, '#2060c0'), (104, '#a0d8ff')]))
    cv.set_sky(m)
    sun = cv.ellipse(250, 30, 12, 12)
    cv.glow(sun, '#fff0a0', 24, 0.5)
    cv.fill(sun, '#fffff0')
    cv.cut_sky(sun)
    sea = cv.rect(0, 100, W, 130)
    water(cv, sea, '#1060a0', '#30a0e0', '#e0ffff', speed=4, regs=4)
    sand = cv.poly([(0, 126), (W, 118), (W, H), (0, H)])
    cv.fill(sand, cv.texture('#c0a060', '#f0d898', 2, 3, 4))
    for x, h in ((40, 120), (290, 100)):
        tr = cv.line([(x, 190), (x + 8, 130), (x + 4, 190 - h)], 4)
        cv.fill(tr, planks(cv, cv.X, cv.Y * 2, '#6a4820', '#9a7040', 3))
        cv.bevel(tr, 1.5, 0.6)
        top = (x + 4, 190 - h)
        for a in np.linspace(0, 2 * np.pi, 7, endpoint=False):
            f = cv.line([top, (top[0] + np.cos(a) * 26, top[1] + np.sin(a) * 8 - 6), (top[0] + np.cos(a) * 38, top[1] + 12)], 3)
            cv.fill(f, cv.vgrad([(top[1] - 10, '#60c040'), (top[1] + 14, '#205010')]))
    st = cv.rect(120, 120, 190, 160)
    cv.fill(st, planks(cv, cv.X, cv.Y, '#6a4420', '#9a6a34', 6))
    cv.bevel(st, 2, 0.5)
    roof = cv.poly([(112, 118), (198, 118), (190, 104), (120, 104)])
    cv.fill(roof, '#d0b050')
    cv.bevel(roof, 1.5, 0.5)
    cv.fill(cv.rect(132, 108, 178, 116), '#3a2010')
    sign = cv.rect(210, 132, 270, 152)
    cv.fill(sign, '#c09050')
    cv.bevel(sign, 1.5, 0.5)
    cv.fill(cv.rect(238, 152, 242, 178), '#6a4420')
    cv.fill(cv.line([(214, 142), (266, 142)], 1), '#202020')
    grid = sand * ((np.abs((cv.X % 32) - 16) < 0.4) | (np.abs((cv.Y % 16) - 8) < 0.3)) * (cv.X < 40)
    cv.fill(grid, '#40ffa0', 0.3)
    cv.vignette(0.25)
    return cv


def lift():
    cv = Canvas()
    scifi_room(cv, (70, 20, 250, 140), wall=BLACK, floor=('#16161c', '#24242c'), light=False, dark=0.4)
    d = cv.rect(110, 34, 210, 140)
    cv.fill(d, cv.hgrad([(110, '#2a2a34'), (160, '#5a5a6a'), (210, '#2a2a34')]))
    cv.fill(cv.rect(159.4, 34, 160.6, 140), '#06060a')
    cv.bevel(d, 2, 0.6)
    fr = cv.rect(104, 28, 216, 140) * (1 - d)
    red_strip(cv, fr, 6)
    pad = cv.rect(222, 80, 236, 100)
    cv.fill(pad, '#2a2a30')
    cv.bevel(pad, 1, 0.6)
    blinker(cv, 229, 90, 2.5, '#ff3020', '#300404', 12)
    arrow = cv.poly([(152, 24), (168, 24), (160, 16)])
    cv.fill(arrow, '#ffb020')
    cv.vignette(0.4)
    return cv


def forcefield(cv, m):
    cv.fill(m, '#4090ff', 0.35)
    lines = m * (np.abs(((cv.Y * 0.7 + cv.X * 0.1) % 6) - 3) < 0.6)
    cv.animate(lines, ['#c0e0ff', '#6090ff', '#2040a0', '#6090ff'], speed=3, regs=3, phase=(cv.Y / 20) % 1)


def cellblock():
    cv = Canvas()
    r = scifi_room(cv, (120, 40, 200, 110), wall=BLACK, floor=('#16161c', '#22222a'), dark=0.3)
    cells = [(0, 30, 70, 170), (250, 30, W, 170), (80, 50, 116, 112), (204, 50, 240, 112)]
    for i, (x0, y0, x1, y1) in enumerate(cells):
        c = cv.rect(x0, y0, x1, y1)
        cv.fill(c, '#0a0a10')
        if i == 0:
            stronkie(cv, 24, 160, 40)
            stronkie(cv, 52, 164, 32, fur='#5a8ae0')
        elif i == 1:
            person(cv, 286, 168, 110, coat='#6a4a2a', beard='#c0c0c0', hat='#2a2a2a')
        elif i == 2:
            person(cv, 98, 110, 50, coat='#7a2020', hat='#202020')
        else:
            stronkie(cv, 222, 110, 26)
        forcefield(cv, c)
        cv.bevel(cv.rect(x0 - 2, y0 - 2, x1 + 2, y1 + 2) * (1 - c), 1, 0.6)
    notes = np.zeros((cv.h, cv.w), np.float32)
    for k, (x, y) in enumerate(((256, 40), (266, 30), (276, 36))):
        notes = np.maximum(notes, cv.ellipse(x, y, 2.5, 2) + cv.rect(x + 1.6, y - 10, x + 2.6, y))
    notes = np.clip(notes, 0, 1)
    cv.fill(notes, '#ffffff')
    cv.animate(notes, ['#ffffff', '#ffe080', '#0a0a10', '#ffe080'], speed=6, regs=3, phase=(cv.X - 256) / 30)
    cv.vignette(0.4)
    return cv


def guardroom():
    cv = Canvas()
    scifi_room(cv, (60, 30, 260, 120), wall=BLACK, floor=('#1a1a20', '#282830'), dark=0.45)
    d = cv.rect(140, 50, 180, 120)
    cv.fill(d, panels(cv, cv.X, cv.Y, '#2a2a34', '#3a3a46', 20, 35, 9))
    cv.bevel(d, 2, 0.6)
    red_strip(cv, cv.rect(138, 46, 182, 48), 8)
    for i, x in enumerate((70, 92)):
        lk = cv.rect(x, 50, x + 20, 118)
        cv.fill(lk, panels(cv, cv.X, cv.Y, '#2a2e36', '#3a3e48', 20, 70, i))
        cv.bevel(lk, 1.5, 0.6)
    rack = cv.rect(200, 56, 250, 104)
    cv.fill(rack, '#121218')
    for k in range(4):
        g = cv.line([(206 + k * 12, 100), (208 + k * 12, 60)], 2)
        cv.fill(g, '#5a5a66')
        cv.bevel(g, 0.8, 0.6)
    console(cv, 0, 150, W, 192, '#1e1e26', seed=41, slope=10)
    screen(cv, 20, 128, 80, 152, '#ff3030', content='radar', seed=4)
    screen(cv, 240, 128, 300, 152, '#ff3030', content='lines', seed=5)
    cv.vignette(0.4)
    return cv


def fbridge():
    cv = Canvas()
    win = cv.poly([(20, 10), (300, 10), (280, 100), (40, 100)])
    space(cv, sky=False)
    earth_like = planet(cv, 230, 110, 70, '#5a2a8a', '#c070e0', bands=False, atmo='#e0a0ff', seed=7)
    fr = cv.everywhere() * (1 - win)
    cv.fill(fr, panels(cv, cv.X, cv.Y, '#16161c', '#26262e', 40, 20, 3))
    cv.bevel(fr, 3, 0.8)
    for x in (110, 210):
        cv.fill(cv.line([(x, 10), (x - 4 + (x - 160) * 0.05, 100)], 2.5), '#16161c')
    red_strip(cv, cv.rect(40, 100, 280, 102), 6)
    console(cv, 0, 150, W, 192, '#1a1a22', seed=7, slope=12)
    vex = person(cv, 160, 150, 96, coat='#0e0e12', legs='#08080a', head_col='#2a2a34')
    cape = cv.poly([(146, 76), (174, 76), (184, 150), (136, 150)])
    cv.fill(cape, cv.hgrad([(136, '#3a0810'), (160, '#801020'), (184, '#3a0810')]), 0.9)
    raven_emblem(cv, 160, 30, 0.6)
    person(cv, 40, 192, 110, coat='#6a4a2a', beard='#c0c0c0', hat='#2a2a2a')
    ld = cv.rect(286, 110, 300, 192)
    rails = ld * ((np.abs(cv.X - 288) < 1) | (np.abs(cv.X - 298) < 1) | ((cv.Y % 10) < 1.2))
    cv.fill(rails, '#6a6a76')
    cv.vignette(0.35)
    return cv


def cannon():
    cv = Canvas()
    scifi_room(cv, (60, 20, 260, 110), wall=BLACK, floor=('#16161c', '#22222a'), dark=0.4, light=False)
    def world(m):
        keep = cv.c.copy()
        cv.fill(cv.everywhere(), '#04040e')
        rng = np.random.default_rng(5)
        for i in range(40):
            cv.fill(cv.ellipse(rng.uniform(110, 210), rng.uniform(8, 108), 0.6, 0.6), '#ffffff')
        planet(cv, 172, 70, 30, '#5a2a8a', '#c070e0', bands=False, atmo='#e0a0ff', seed=7)
        cv.c = np.where(m[..., None] > 0.5, cv.c, keep)
    vp = viewport(cv, 110, 26, 210, 90, frame='#2a2a34', round_=True, inner=world)
    can = cylinder(cv, 120, 70, 300, 104, '#3a3a46', '#7a7a8a', vertical=False, spec=0.5)
    barrel_m = cv.poly([(100, 80), (180, 76), (180, 96), (100, 92)])
    cv.fill(barrel_m, cv.vgrad([(76, '#8a8a98'), (96, '#2a2a34')]))
    rings = (barrel_m + can) * (np.abs((cv.X % 24) - 12) < 1.5)
    cv.fill(np.clip(rings, 0, 1), '#16161c')
    coil = np.clip(barrel_m + can, 0, 1) * (np.abs((cv.X % 24) - 6) < 2)
    cv.fill(coil, '#ff3040')
    cv.animate(coil, ['#ff6070', '#ff2030', '#800810', '#ff2030'], speed=4, regs=3, phase=(cv.X / 120) % 1)
    muzzle = cv.ellipse(100, 86, 4, 8)
    cv.glow(muzzle, '#ff4060', 10, 0.6)
    console(cv, 0, 140, W, 192, '#1a1a22', seed=13, slope=12, lights=False)
    btn = np.zeros((cv.h, cv.w), np.float32)
    for i in range(6):
        btn = np.maximum(btn, cv.ellipse(60 + i * 40, 166, 6, 3))
    cv.fill(btn, '#ff2030')
    cv.glow(btn, '#ff2030', 6, 0.5)
    cv.animate(btn, ['#ff4050', '#a01020', '#ff4050', '#ff8080'], speed=10, regs=2, phase=(cv.X / 80) % 1)
    cv.vignette(0.4)
    return cv


def vexroom():
    cv = Canvas()
    scifi_room(cv, (70, 30, 250, 120), wall=('#121216', '#1e1e24'), floor=('#141418', '#1e1e24'), dark=0.45)
    vp = viewport(cv, 170, 46, 230, 90, frame='#2a2a34')
    bed = cv.rect(10, 130, 120, 160)
    cv.fill(bed, cv.vgrad([(130, '#3a3a44'), (160, '#16161c')]))
    cv.bevel(bed, 2, 0.5)
    cv.fill(cv.rect(10, 126, 40, 134), '#4a4a56')
    table(cv, 170, 300, 150, 30, 10, '#141418', '#0a0a0c')
    frame = cv.rect(226, 116, 254, 146)
    cv.fill(frame, cv.lgrad((226, 116), (254, 146), '#ffffff', '#707080'))
    cv.bevel(frame, 1, 0.6)
    ph = cv.rect(230, 120, 250, 142)
    cv.fill(ph, '#a08a60')
    person(cv, 236, 142, 20, coat='#6a4a2a', beard='#808080')
    person(cv, 245, 142, 14, coat='#304060')
    lamp_glow(cv, 240, 120, 40, '#fff0c0', 0.4)
    raven_emblem(cv, 110, 60, 0.8)
    cv.vignette(0.45)
    return cv


def egarden():
    """the epilogue: the garden in the morning, the Starraven on the lawn"""
    cv = Canvas()
    m = cv.rect(0, 0, W, 100)
    cv.fill(m, cv.vgrad([(0, '#3a6ac0'), (60, '#a0c0e8'), (100, '#ffd8a0')]))
    cv.set_sky(m)
    sun = cv.ellipse(60, 84, 16, 16)
    cv.glow(sun, '#fff0b0', 40, 0.6)
    cv.fill(sun, '#fffff0')
    cv.cut_sky(sun)
    clouds(cv, m, 10, 60, '#c0c8e0', '#ffffff', seed=12, cover=0.35, scale=24)
    hills(cv, 92, 6, '#4a6a8a', '#3a5a70', 31)
    manor_silhouette(cv, 160, 96, 0.9)
    g = hills(cv, 98, 2, '#4a8a30', '#2a5a1a', 32)
    grass(cv, g, '#2a5a1a', '#6aaa3a', seed=9)
    for i in range(140):
        rng = np.random.default_rng(i)
        x = rng.uniform(0, W)
        y = rng.uniform(150, 194)
        bl = cv.line([(x, y), (x + rng.uniform(-3, 3), y - rng.uniform(6, 14))], 0.7)
        cv.fill(bl, mix(rgb('#3a7020'), rgb('#90c050'), rng.random()))
    sh = cv.ellipse(220, 176, 40, 6)
    cv.fill(sh, '#1a3a10', 0.6)
    starraven(cv, 220, 176, 1.1)
    for x, y in ((90, 160), (120, 170), (60, 176)):
        f = cv.ellipse(x, y, 2.5, 2.5)
        cv.fill(f, '#ffe040')
    stronkie(cv, 150, 182, 30)
    cv.vignette(0.25)
    return cv


SCENES = dict(egarden=egarden, fhangar=fhangar, fcorr=fcorr, breakroom=breakroom, holodeck=holodeck, lift=lift, cellblock=cellblock,
              guardroom=guardroom, fbridge=fbridge, cannon=cannon, vexroom=vexroom)
