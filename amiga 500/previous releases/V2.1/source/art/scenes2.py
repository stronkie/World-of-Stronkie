"""Space: the STARRAVEN, station KX-9, Asteroid 42, the pirate ship (parts 4-7)."""
import numpy as np
from paint import Canvas, rgb, mix, W, H
from kit import *
from scenes1 import starraven


def scifi_room(cv, back, wall=('#2a3038', '#3e4654'), floor=('#2a2e34', '#3a3e46'), pw=24, ph=14, seed=5, grate=False,
               light=True, dark=0.45):
    r = Room(cv, back)
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, panels(cv, 1 / z * 60, a, wall[0], wall[1], pw, ph, seed))
        r.depth_shade(m, z, 0.9, dark)
    m, u, z = r.surface('floor')
    if grate:
        grating(cv, m, u, 1 / z * 40, floor[1], 5)
    else:
        cv.fill(m, checker(u * 0.5, 1 / z * 40, floor[0], floor[1], 10))
    r.depth_shade(m, z, 0.95, dark)
    bk = cv.rect(*back)
    cv.fill(bk, panels(cv, cv.X, cv.Y, wall[0], wall[1], pw * 1.5, ph * 1.5, seed + 1))
    cv.tint(bk, 0.75)
    if light:
        x0, y0, x1, y1 = back
        l = cv.poly([(x0 + 20, y0 - 1), (x1 - 20, y0 - 1), (x1 + 10, y0 - 12), (x0 - 10, y0 - 12)])
        cv.fill(l, '#d8e8ff')
        cv.glow(l, '#a0c0ff', 12, 0.35)
    return r


def earth(cv, x, y, r):
    pm = planet(cv, x, y, r, '#1040a0', '#40a0e0', bands=False, atmo='#60b0ff', seed=9)
    land = cv.noise(r * 0.18, 4, 21)
    lm = pm * (land > 0.55)
    cv.fill(lm, cv.texture('#2a6a20', '#7a8a40', 3, 3, 4))
    cl = cv.noise(r * 0.1, 4, 77, sx=cv.X * 0.6, sy=cv.Y * 1.4)
    cm = pm * (cl > 0.6)
    cv.fill(cm, '#f0f4ff', 0.75)
    cv.shade_sphere(x, y, r, np.clip(lm + cm, 0, 1), light=(-0.6, -0.4), amb=0.1)
    return pm


def cockpit_frame(cv, panel='#2a3038', panel2='#4a5260'):
    fr = cv.poly([(0, 0), (W, 0), (W, 130), (280, 110), (40, 110), (0, 130)]) * (1 - cv.poly([(30, 6), (290, 6), (272, 100), (48, 100)]))
    cv.fill(fr, panels(cv, cv.X, cv.Y, panel, panel2, 40, 20, 3))
    cv.bevel(fr, 3, 0.8)
    strut = cv.line([(160, 0), (160, 100)], 3)
    cv.fill(strut, '#3a424e')
    cv.bevel(strut, 1, 0.6)


def cockpit():
    cv = Canvas()
    space(cv, 0, 0, W, 120, seed=5, neb=('#301050', '#102860'))
    earth(cv, 200, 160, 95)
    cockpit_frame(cv)
    console(cv, 0, 118, W, 192, '#384050', seed=5, slope=14)
    s1 = screen(cv, 120, 140, 200, 175, '#ff3030', content='wave', seed=4)
    err = s1 * (cv.c[..., 0] > 0.5)
    cv.animate(err, ['#ff4040', '#ff4040', '#601010', '#601010'], speed=15)
    screen(cv, 30, 140, 95, 172, '#30e0a0', content='radar')
    screen(cv, 225, 140, 290, 172, '#40a0ff', content='graph')
    cv.vignette(0.3)
    return cv


def shipcorr():
    cv = Canvas()
    r = scifi_room(cv, (120, 50, 200, 120), seed=8)
    door_b = cv.rect(140, 62, 180, 120)
    cv.fill(door_b, panels(cv, cv.X, cv.Y, '#4a5868', '#6a7a8c', 20, 60, 2, False))
    cv.fill(cv.rect(159.3, 62, 160.7, 120), '#1a1e24')
    cv.fill(cv.rect(140, 58, 180, 62), '#ffb020')
    for side, x in (('left', 0), ('right', 1)):
        p0 = r.wall_point(side, 0.35, 0.0)
        p1 = r.wall_point(side, 0.55, 0.0)
        t0 = r.wall_point(side, 0.35, 0.8)
        t1 = r.wall_point(side, 0.55, 0.8)
        d = cv.poly([p0, p1, t1, t0])
        cv.fill(d, panels(cv, cv.X, cv.Y, '#4a5868', '#6a7a8c', 20, 60, 3, False))
        cv.bevel(d, 1, 0.6)
    hole = cv.ellipse(160, 172, 30, 9)
    cv.fill(hole, '#08080a')
    rim = cv.ellipse(160, 172, 34, 11) * (1 - hole)
    warning_stripes(cv, rim, '#e0b000', 4)
    for y in (166, 172, 178):
        cv.fill(cv.rect(146, y, 174, y + 1.5) * hole, '#909aa8')
    for x in (146, 174):
        cv.fill(cv.rect(x, 160, x + 1.5, 182) * cv.ellipse(160, 172, 32, 12), '#909aa8')
    for x, y in ((128, 46), (192, 46)):
        blinker(cv, x, y, 1.5, '#30ff60', '#103010', 20)
    cv.vignette(0.35)
    return cv


def galley():
    cv = Canvas()
    r = scifi_room(cv, (80, 40, 240, 120), ('#3a3e46', '#585e6a'), ('#4a4a50', '#3a3a40'), seed=11)
    port = viewport(cv, 140, 52, 180, 92, round_=True, inner=lambda m: None)
    space_m = cv.ellipse(160, 72, 20, 20)
    cv.fill(space_m, '#04040c')
    star_field(cv, 140, 52, 180, 92, 25, 4)
    planet(cv, 150, 80, 7, '#a06030', '#e0a060', seed=3)
    cv.c = cv.c
    disp = cv.rect(196, 50, 236, 118)
    cv.fill(disp, cv.lgrad((196, 0), (236, 0), '#8a90a0', '#50566a'))
    cv.bevel(disp, 2, 0.6)
    scr = cv.rect(204, 58, 228, 74)
    cv.fill(scr, '#103018')
    cv.fill(cv.rect(206, 62, 222, 64), '#40ff60')
    cv.animate(cv.rect(206, 62, 222, 64), ['#40ff60', '#108020'], speed=20)
    hatch = cv.rect(206, 86, 226, 100)
    cv.fill(hatch, '#202428')
    cv.bevel(hatch, 1, 0.6, (0.7, 0.7))
    tr = cv.rect(206, 98, 226, 102)
    cv.fill(tr, '#c0c8d0')
    table(cv, 90, 180, 140, 30, 10, '#a0a8b8', '#505864')
    cup = cylinder(cv, 120, 128, 128, 138, '#e0e0e8')
    plate = cv.ellipse(150, 136, 10, 2.5)
    cv.fill(plate, '#e8e8f0')
    blob = cv.ellipse(150, 134, 5, 2.5)
    cv.fill(blob, '#60c040')
    cv.shade_sphere(150, 134, 5, blob, spec=0.5)
    cv.vignette(0.35)
    return cv


def engine():
    cv = Canvas()
    r = scifi_room(cv, (70, 30, 250, 125), ('#2a2e36', '#40464f'), ('#2a2a2e', '#3a3a40'), seed=13, grate=True)
    core = cv.rect(130, 34, 190, 125)
    cv.fill(core, '#101820')
    glass = cv.rect(138, 40, 182, 120)
    rx = (cv.X - 160) / 22
    ph = ((cv.Y * 0.08 - np.abs(rx) * 0.3) % 1)
    cv.fill(glass, cv.hgrad([(138, '#2060ff'), (160, '#c0f0ff'), (182, '#2060ff')]))
    cv.glow(glass, '#60a0ff', 18, 0.6)
    plasma = glass * (np.abs(rx) < 0.6)
    cv.animate(plasma, ['#ffffff', '#a0e0ff', '#4080ff', '#2040c0', '#4080ff', '#a0e0ff'], speed=3, regs=5, phase=ph)
    for y in (34, 118):
        ring = cv.rect(126, y, 194, y + 7)
        cylinder(cv, 126, y, 194, y + 7, '#707a88', vertical=False)
    for i, x in enumerate((84, 100)):
        pipe(cv, [(x, 125), (x, 60), (130, 50)], 6, '#806040' if i else '#5a6270')
    pipe(cv, [(236, 125), (236, 70), (190, 60)], 7, '#5a6270')
    rack = cv.rect(205, 60, 245, 100)
    cv.fill(rack, '#3a3e46')
    cv.bevel(rack, 1, 0.6)
    for i, c in enumerate(['#c02020', '#808890', '#c0a020', '#808890']):
        t = cv.line([(212 + i * 9, 66), (212 + i * 9, 92)], 2)
        cv.fill(t, c)
        cv.bevel(t, 0.8, 0.6)
    cv.vignette(0.4)
    return cv


def cargo():
    cv = Canvas()
    r = scifi_room(cv, (60, 30, 260, 120), ('#3a3a34', '#55554a'), ('#3a3a3a', '#2a2a2a'), seed=17, pw=30, ph=20)
    rng = np.random.default_rng(4)
    for i in range(6):
        x, y = rng.uniform(40, 280), rng.uniform(30, 90)
        s = rng.uniform(14, 24)
        a = rng.uniform(-0.5, 0.5)
        pts = [(x + np.cos(a + k * np.pi / 2) * s - np.sin(a) * 0, y + np.sin(a + k * np.pi / 2) * s) for k in range(4)]
        pts = [(x + s * np.cos(a + np.pi / 4 + k * np.pi / 2), y + s * np.sin(a + np.pi / 4 + k * np.pi / 2) * 0.8) for k in range(4)]
        m = cv.poly(pts)
        cv.shadow(m, 3, 10, 4, 0.25)
        cv.fill(m, planks(cv, cv.X + x, cv.Y + y, '#6a4a28', '#9a7040', 5))
        cv.bevel(m, 2, 0.7)
    big = crate(cv, 120, 120, 210, 176, 12)
    lab = cv.rect(140, 138, 190, 152)
    cv.fill(lab, '#e0d8c0')
    cv.fill(cv.rect(146, 142, 184, 148) * (((cv.X * 1.5).astype(int) % 4) < 3), '#202020')
    cv.vignette(0.35)
    return cv


def airlock():
    cv = Canvas()
    r = Room(cv, (90, 30, 230, 130))
    for side in ('left', 'right', 'ceiling', 'floor'):
        m, a, z = r.surface(side)
        cv.fill(m, panels(cv, 1 / z * 60, a, '#3a3e46', '#5a606a', 20, 14, 21))
        r.depth_shade(m, z, 0.9, 0.5)
    back = cv.rect(90, 30, 230, 130)
    cv.fill(back, panels(cv, cv.X, cv.Y, '#3a3e46', '#5a606a', 30, 20, 22))
    cv.tint(back, 0.8)
    d = cv.ellipse(160, 82, 42, 42)
    cv.fill(d, cv.rgrad(150, 72, 50, '#8a92a0', '#3a404a'))
    cv.bevel(d, 3, 0.7)
    for a in range(0, 360, 60):
        bolt = cv.line([(160, 82), (160 + np.cos(np.radians(a)) * 36, 82 + np.sin(np.radians(a)) * 36)], 2.5)
        cv.fill(bolt, '#5a606a')
        cv.bevel(bolt, 0.8, 0.6)
    hub = cv.ellipse(160, 82, 10, 10)
    cv.fill(hub, '#c0a040')
    cv.shade_sphere(160, 82, 10, hub, spec=0.5)
    win = cv.ellipse(160, 62, 8, 5)
    cv.fill(win, '#04040a')
    star_field(cv, 152, 57, 168, 67, 4, 2, twinkle=False)
    l = cv.ellipse(160, 26, 5, 3)
    cv.fill(l, '#ff2020')
    cv.glow(l, '#ff2020', 20, 0.5)
    cv.animate(l, ['#ff3030', '#ff3030', '#400808', '#400808'], speed=12)
    rack = cv.rect(250, 70, 290, 140)
    cv.fill(rack, '#2a2e36')
    cv.bevel(rack, 1, 0.6)
    for i in range(3):
        cv.fill(cv.rect(256 + i * 11, 78, 262 + i * 11, 128), '#e0e0e8' if i == 1 else '#606878')
        cv.bevel(cv.rect(256 + i * 11, 78, 262 + i * 11, 128), 0.8, 0.6)
    cv.vignette(0.35)
    return cv


def dock():
    cv = Canvas()
    m = cv.rect(0, 0, W, H)
    cv.fill(m, panels(cv, cv.X, cv.Y, '#262a32', '#363c46', 40, 26, 31))
    bay = cv.poly([(20, 10), (300, 10), (270, 120), (50, 120)])
    cv.fill(bay, '#04040a')
    star_field(cv, 20, 10, 300, 120, 60, 7)
    planet(cv, 240, 40, 16, '#806040', '#c0a070', seed=2)
    shield = bay
    cv.add(shield * cv.noise(20, 2, 4), '#4060a0', 0.12)
    fr = cv.poly([(10, 0), (310, 0), (310, 128), (10, 128)]) * (1 - bay)
    cv.fill(fr, panels(cv, cv.X, cv.Y, '#3a404a', '#5a626e', 30, 20, 32))
    cv.bevel(fr, 3, 0.7)
    fl = cv.poly([(0, 128), (W, 128), (W, H), (0, H)])
    d = np.maximum(cv.Y - 90, 0.1)
    grating(cv, fl, (cv.X - 160) * 40 / d, 600 / d, '#3a3e44', 4)
    cv.tint(fl, 0.8)
    # the STARRAVEN lying in the bay, seen from behind
    hull = cv.ellipse(70, 150, 60, 28)
    cv.fill(hull, cv.vgrad([(122, '#e0e8f8'), (178, '#404858')]))
    cv.shade_sphere(60, 140, 60, hull, amb=0.5)
    for k in (-1, 1):
        n = cv.ellipse(70 + k * 18, 160, 10, 9)
        cv.fill(n, '#202428')
        cv.glow(n, '#4080ff', 4, 0.3)
    for x in (110, 210):
        l = cv.rect(x, 124, x + 20, 128)
        cv.fill(l, '#ffd040')
    cor = cv.rect(286, 60, 320, 128)
    cv.fill(cor, '#060608')
    cv.vignette(0.35)
    return cv


def stcorr():
    cv = Canvas()
    r = scifi_room(cv, (130, 55, 190, 110), ('#3a4250', '#56606e'), ('#34383e', '#2a2c32'), seed=41, dark=0.35, light=False)
    m, u, z = r.surface('floor')
    strip = m * (np.abs(np.abs(u) - 27) < 1.0)
    cv.fill(strip, '#ffa020')
    cv.glow(strip, '#ff8010', 6, 0.35)
    cv.animate(strip, ['#ffb030', '#ff8010', '#a04008', '#ff8010'], speed=6, regs=2, phase=(z * 3) % 1)
    cv.fill(cv.rect(130, 55, 190, 110), '#050506')
    # broken light panels and sparking wires
    for d in (0.1, 0.4):
        x0, y0 = r.wall_point('left', d, 1.0)
        l = cv.rect(160 - (160 - x0) * 0.4, y0 + 1, 160 + (160 - x0) * 0.4, y0 + 3)
        cv.fill(l, '#607080')
    wires = np.zeros((cv.h, cv.w), np.float32)
    for i, x in enumerate((120, 170, 205)):
        pts = [(x, 0), (x + 3, 12), (x - 2, 26 + i * 4)]
        wires = np.maximum(wires, cv.line(pts, 1.2))
    cv.fill(wires, '#1a1a1a')
    spark = np.zeros((cv.h, cv.w), np.float32)
    for x, y in ((118, 30), (205, 34)):
        for a in range(0, 360, 45):
            spark = np.maximum(spark, cv.line([(x, y), (x + np.cos(np.radians(a)) * 5, y + np.sin(np.radians(a)) * 5)], 0.6))
        cv.glow(cv.ellipse(x, y, 2, 2), '#80c0ff', 12, 0.6)
    cv.fill(spark, '#e0f0ff')
    cv.animate(spark, ['#ffffff', '#80c0ff', '#101820', '#101820', '#101820', '#e0f0ff', '#101820'], speed=2, regs=2,
               phase=(cv.X > 160).astype(np.float32) * 0.6)
    for side in ('left', 'right'):
        p0 = r.wall_point(side, 0.3, 0.0)
        p1 = r.wall_point(side, 0.5, 0.0)
        t0 = r.wall_point(side, 0.3, 0.75)
        t1 = r.wall_point(side, 0.5, 0.75)
        d = cv.poly([p0, p1, t1, t0])
        cv.fill(d, '#30363e')
        cv.bevel(d, 1, 0.5)
    cv.vignette(0.35)
    return cv


def quarters():
    cv = Canvas()
    r = scifi_room(cv, (60, 40, 260, 120), ('#30343a', '#454a52'), ('#3a3632', '#2a2622'), seed=51, dark=0.35)
    for y in (60, 92):
        bunk = cv.rect(64, y, 160, y + 14)
        cv.fill(bunk, '#4a5058')
        cv.bevel(bunk, 1, 0.6)
        mat = cv.rect(66, y + 2, 158, y + 8)
        cv.fill(mat, cv.texture('#5a6a4a', '#7a8a6a', 2, 2, y))
        cv.bevel(mat, 1, 0.5)
    for x in (64, 156):
        cv.fill(cv.rect(x, 52, x + 4, 120), '#3a4048')
    term = cv.rect(200, 70, 250, 120)
    cv.fill(term, '#3a404a')
    cv.bevel(term, 2, 0.6)
    s = screen(cv, 206, 76, 244, 100, '#40ff80', content='lines', seed=2)
    cv.animate(s * (cv.c[..., 1] > 0.4), ['#60ff90', '#40c060', '#60ff90', '#103018', '#60ff90'], speed=3)
    kb = cv.poly([(198, 106), (252, 106), (258, 116), (192, 116)])
    cv.fill(kb, '#2a2e36')
    for i in range(12):
        cv.fill(cv.rect(198 + i * 4.5, 109, 201 + i * 4.5, 111), '#6a707a')
    cv.vignette(0.45)
    return cv


def power():
    cv = Canvas()
    r = scifi_room(cv, (60, 30, 260, 125), ('#2e3036', '#44474f'), ('#2a2a2e', '#38383e'), seed=61, grate=True, dark=0.3)
    gen = cylinder(cv, 100, 40, 200, 125, '#5a6270')
    for y in (50, 70, 90, 110):
        band = cylinder(cv, 96, y, 204, y + 5, '#3a3e46', vertical=False)
    coil = cv.rect(130, 34, 170, 125)
    cv.fill(coil, '#2a2420')
    for y in range(36, 124, 4):
        cv.fill(cylinder(cv, 130, y, 170, y + 2.5, '#a06030', vertical=False) * 0 + cv.rect(130, y, 170, y + 2.5), '#9a5a2a')
    cylinder(cv, 130, 34, 170, 125, '#9a5a2a')
    for y in range(36, 124, 4):
        cv.tint(cv.rect(130, y + 2.5, 170, y + 4), 0.5)
    panel = cv.rect(226, 60, 256, 110)
    cv.fill(panel, '#3a3e46')
    cv.bevel(panel, 2, 0.6)
    sw = cv.line([(241, 86), (233, 102)], 4)
    cv.fill(sw, '#c02020')
    cv.bevel(sw, 1, 0.6)
    cv.fill(cv.rect(232, 66, 250, 74), '#e0e0d0')
    cv.fill(cv.rect(236, 68, 246, 72) * ((cv.X.astype(int) % 3) > 0), '#202020')
    cv.vignette(0.45)
    return cv


def maproom():
    cv = Canvas(bg='#04060a')
    r = scifi_room(cv, (70, 30, 250, 120), ('#1e2228', '#2c3038'), ('#1e2024', '#26282e'), seed=71, dark=0.3, light=False)
    tab = cv.ellipse(160, 140, 70, 16)
    cv.fill(tab, '#3a404a')
    cv.bevel(tab, 2, 0.6)
    ped = cv.rect(130, 140, 190, 180)
    cv.fill(ped, cv.hgrad([(130, '#2a2e36'), (155, '#5a606a'), (190, '#22262c')]))
    beam = cv.poly([(110, 140), (210, 140), (240, 30), (80, 30)])
    cv.add(beam, '#4080ff', 0.12)
    p = planet(cv, 160, 80, 28, '#5030a0', '#40a0c0', rings='#a0e0ff', seed=5)
    holo = np.clip(p + cv.ellipse(160, 80, 54, 13) * (1 - cv.ellipse(160, 80, 40, 9)), 0, 1)
    cv.tint(holo, 0.7)
    cv.add(holo, '#2060ff', 0.3)
    scan = holo * ((cv.Y.astype(int) % 3) == 0)
    cv.animate(scan, ['#80c0ff', '#4060c0', '#2040a0', '#4060c0'], speed=4, regs=3, phase=(cv.Y / 9) % 1)
    cv.glow(holo, '#4080ff', 10, 0.4)
    cv.vignette(0.45)
    return cv


def asteroid_sky(cv, horizon=110, seed=3):
    m = cv.rect(0, 0, W, horizon + 2)
    cv.fill(m, cv.vgrad([(0, '#0a0614'), (horizon, '#3a1a3a')]))
    cv.set_sky(m)
    star_field(cv, 0, 0, W, horizon - 10, 80, seed)
    planet(cv, 60, 30, 22, '#c06020', '#ffb060', seed=4, atmo='#ff8040')


def pad():
    cv = Canvas()
    asteroid_sky(cv, 105)
    rocks = hills(cv, 100, 22, '#5a4a40', '#2a2420', 3, rough=0.6)
    cv.fill(rocks, cv.texture('#3a302a', '#6a5a4a', 4, 4, 5), 0.5)
    fl = cv.poly([(0, 120), (W, 120), (W, H), (0, H)])
    cv.fill(fl, cv.texture('#6a6058', '#8a8070', 6, 4, 7))
    padm = cv.ellipse(150, 160, 130, 26)
    cv.fill(padm, '#5a5a60')
    cv.bevel(padm, 2, 0.6)
    t42 = cv.ellipse(150, 168, 30, 7) * (1 - cv.ellipse(150, 168, 26, 5.5))
    cv.fill(t42, '#e0e0e0')
    starraven(cv, 120, 160, 0.9)
    hatch = cv.rect(124, 92, 130, 100)
    cv.fill(hatch, '#101010')
    person(cv, 220, 172, 40, coat='#3a5a8a', skin='#e0b090', hair='#6a4a20', legs='#2a3a5a')
    mop = cv.line([(232, 140), (246, 174)], 1.2)
    cv.fill(mop, '#a07040')
    cv.fill(cv.ellipse(248, 175, 8, 2.5), '#c0c0b0')
    for x in (20, 290):
        cv.fill(cv.rect(x, 90, x + 4, 125), '#5a5a60')
        blinker(cv, x + 2, 88, 2, '#40ff40', '#103010', 16)
    cv.vignette(0.35)
    return cv


def plaza():
    cv = Canvas()
    asteroid_sky(cv, 70, seed=7)
    for x0, x1, top, c, name in [(0, 100, 30, '#4a3a5a', 'bar'), (220, 320, 34, '#3a4a6a', 'stan')]:
        b = cv.rect(x0, top, x1, 140)
        cv.fill(b, panels(cv, cv.X, cv.Y, rgb(c) * 0.8, c, 30, 20, x0))
        cv.bevel(b, 2, 0.5)
    back = cv.rect(100, 50, 220, 130)
    cv.fill(back, cv.texture('#2a2430', '#3a3440', 4, 3, 2))
    alley = cv.rect(145, 70, 175, 130)
    cv.fill(alley, '#06060a')
    # neon signs
    for x0, y0, x1, y1, c in [(16, 40, 84, 54, '#ff40c0'), (232, 44, 308, 58, '#40e0ff')]:
        s = cv.rect(x0, y0, x1, y1)
        cv.fill(s, '#101018')
        txt = s * (((cv.X - x0).astype(int) % 6 < 4) & ((cv.Y - y0).astype(int) % 7 > 1) & ((cv.Y - y0) > 2) & ((y1 - cv.Y) > 2))
        cv.fill(txt, c)
        cv.glow(txt, c, 6, 0.6)
        cv.animate(txt, [c, c, c, '#202020', c], speed=8)
    for x in (30, 260):
        d = cv.rect(x, 90, x + 30, 140)
        cv.fill(d, '#100c10')
        cv.add(d, '#ff8040' if x < 100 else '#4080ff', 0.2)
    fl = cv.poly([(0, 140), (W, 140), (W, H), (0, H)])
    cv.fill(fl, cv.texture('#4a4450', '#6a6270', 5, 3, 9))
    st = cv.rect(120, 132, 200, 166)
    cv.fill(st, cv.vgrad([(132, '#e0c040'), (166, '#a07020')]))
    cv.bevel(st, 2, 0.6)
    awn = cv.poly([(112, 120), (208, 120), (214, 134), (106, 134)])
    stripes = ((cv.X / 8).astype(int) % 2 == 0)
    cv.fill(awn * stripes, '#e02020')
    cv.fill(awn * ~stripes, '#f0f0f0')
    mono = cv.rect(152, 96, 168, 120)
    cv.fill(mono, '#08080a')
    cv.add(cv.rect(152, 96, 154, 120), '#ffffff', 0.15)
    burger = cv.ellipse(160, 128, 10, 5)
    cv.fill(burger, '#a06020')
    cv.shade_sphere(160, 126, 10, burger, spec=0.3)
    cv.vignette(0.35)
    return cv


def bar():
    cv = Canvas(bg='#100808')
    r = Room(cv, (50, 30, 270, 120))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, planks(cv, 1 / z * 50, a, '#2a1408', '#4a2a14', 8, along='v'))
        r.depth_shade(m, z, 0.8, 0.4)
    m, u, z = r.surface('floor')
    cv.fill(m, planks(cv, u, 1 / z * 30, '#2a1408', '#4a2812', 6))
    back = cv.rect(50, 30, 270, 120)
    cv.fill(back, planks(cv, cv.X, cv.Y, '#2a1408', '#4a2a14', 8, along='v'))
    cv.tint(back, 0.7)
    stage = cv.rect(90, 86, 230, 120)
    cv.fill(stage, '#3a1a10')
    cv.bevel(stage, 2, 0.5)
    spot = cv.poly([(130, 30), (190, 30), (220, 120), (100, 120)])
    cv.add(spot, '#ffe0a0', 0.15)
    person(cv, 140, 108, 34, coat='#e0e0e0', skin='#80c080', hair='#202020')
    person(cv, 180, 108, 34, coat='#2020a0', skin='#c08080', hair='#e0c040')
    kb = cv.rect(166, 92, 196, 98)
    cv.fill(kb, '#f0f0f0')
    jb = cv.rect(240, 60, 266, 118)
    cv.fill(jb, cv.hgrad([(240, '#a03020'), (253, '#ff8040'), (266, '#a03020')]))
    jbt = cv.ellipse(253, 64, 13, 8)
    cv.fill(jbt, '#ffb040')
    lights = cv.rect(244, 70, 262, 72) + cv.rect(244, 78, 262, 80)
    cv.animate(np.clip(lights, 0, 1), ['#ff4040', '#40ff40', '#4040ff', '#ffff40'], speed=6, regs=2, phase=(cv.Y > 75).astype(np.float32) * 0.6)
    ac = cv.rect(56, 60, 84, 118)
    cv.fill(ac, '#2a2a40')
    cv.bevel(ac, 1.5, 0.6)
    scr = cv.rect(60, 66, 80, 84)
    cv.fill(scr, '#102010')
    ch = cv.ellipse(70, 76, 4, 4)
    cv.fill(ch, '#ffffff')
    ph = cv.rect(110, 44, 130, 62)
    cv.fill(ph, '#c09030')
    cv.fill(cv.rect(112, 46, 128, 60), cv.texture('#605848', '#a09070', 2, 2, 5))
    cv.bevel(ph, 0.8, 0.6)
    counter = cv.poly([(0, 150), (W, 150), (W, H), (0, H)])
    cv.fill(counter, planks(cv, cv.X, cv.Y, '#3a1a08', '#6a3a1a', 12))
    top = cv.rect(0, 146, W, 152)
    cv.fill(top, '#8a5a2a')
    cv.bevel(top, 1, 0.6)
    for x in (60, 250):
        mug = cylinder(cv, x, 130, x + 14, 148, '#c0a060')
        froth = cv.ellipse(x + 7, 130, 8, 3)
        cv.fill(froth, '#60ff40')
        cv.glow(froth, '#60ff40', 4, 0.5)
        bub = cv.ellipse(x + 7, 126, 3, 3)
        cv.animate(np.clip(froth + bub, 0, 1), ['#80ff60', '#40c020', '#a0ff80'], speed=5)
    cv.vignette(0.45)
    return cv


def stan():
    cv = Canvas()
    r = Room(cv, (50, 30, 270, 120))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, panels(cv, 1 / z * 60, a, '#3a3a50', '#55557a', 30, 20, 81, False))
        r.depth_shade(m, z, 0.85, 0.5)
    m, u, z = r.surface('floor')
    cv.fill(m, checker(u * 0.4, 1 / z * 40, '#e0d040', '#303030', 10))
    r.depth_shade(m, z, 0.95, 0.6)
    back = cv.rect(50, 30, 270, 120)
    cv.fill(back, panels(cv, cv.X, cv.Y, '#3a3a50', '#55557a', 40, 30, 82, False))
    cv.tint(back, 0.8)
    bunt = np.zeros((cv.h, cv.w), np.float32)
    for i in range(12):
        x = 54 + i * 18
        tri = cv.poly([(x, 34), (x + 14, 34), (x + 7, 44)])
        cv.fill(tri, ['#e02020', '#2060e0', '#e0c020'][i % 3])
        bunt = np.maximum(bunt, tri)
    shelf = cv.rect(70, 66, 150, 70)
    cv.fill(shelf, '#808890')
    cells = np.zeros((cv.h, cv.w), np.float32)
    for i in range(5):
        c = cylinder(cv, 76 + i * 15, 50, 86 + i * 15, 66, '#30e060')
        cells = np.maximum(cells, c)
    cv.glow(cells, '#40ff80', 8, 0.5)
    cv.animate(cells * (cv.c[..., 1] > 0.6), ['#a0ffb0', '#40ff80', '#20a040', '#40ff80'], speed=6)
    person(cv, 200, 150, 80, coat='#e0e020', skin='#e0b090', hair='#202020', legs='#3a3a3a', arms_up=True)
    chk = cv.poly([(186, 82), (214, 82), (216, 112), (184, 112)]) * ((((cv.X / 4).astype(int) + (cv.Y / 4).astype(int)) % 2) == 0)
    cv.fill(chk, '#e02020', 0.8)
    bin_ = cv.rect(60, 120, 120, 160)
    cv.fill(bin_, cv.texture('#7a7a80', '#a0a0a8', 2, 3, 6))
    cv.bevel(bin_, 2, 0.6)
    sale = cv.rect(64, 108, 116, 122)
    cv.fill(sale, '#e02020')
    t = sale * (((cv.X - 64).astype(int) % 5 < 3) & (np.abs(cv.Y - 115) < 3))
    cv.fill(t, '#ffffff')
    cv.animate(t, ['#ffffff', '#ffff40', '#ffffff', '#e02020'], speed=10)
    cv.vignette(0.35)
    return cv


def alley():
    cv = Canvas(bg='#040406')
    r = Room(cv, (130, 30, 190, 110), vp=(160, 70))
    for side in ('left', 'right'):
        m, a, z = r.surface(side)
        cv.fill(m, blocks(cv, 1 / z * 50, a, '#2a2830', '#3a3842', 14, 7, '#121116'))
        r.depth_shade(m, z, 0.7, 0.2)
    m, u, z = r.surface('floor')
    cv.fill(m, cv.texture('#1a1a20', '#2a2a30', 3, 3, 4))
    puddle = m * (cv.ellipse(170, 170, 40, 8) > 0.5)
    cv.fill(puddle, '#402040')
    cv.add(puddle, '#ff40c0', 0.2)
    m, u, z = r.surface('ceiling')
    sky = cv.rect(0, 0, W, 60) * m
    cv.fill(m, '#08060c')
    door(cv, 210, 60, 250, 150, '#3a2a20', '#5a4030', '#1a1410')
    sign = cv.rect(208, 44, 252, 56)
    cv.fill(sign, '#100810')
    t = sign * (((cv.X - 208).astype(int) % 6 < 4) & (np.abs(cv.Y - 50) < 3))
    cv.fill(t, '#ff40a0')
    cv.glow(t, '#ff40a0', 8, 0.6)
    cv.animate(t, ['#ff40a0', '#ff40a0', '#ff40a0', '#300818', '#ff40a0', '#300818'], speed=5)
    person(cv, 190, 165, 70, coat='#f0f0f0', skin='#e0b090', hair='#3a2010', legs='#f0f0f0')
    cv.fill(cv.rect(184, 108, 196, 112) * 1.0, '#ffffff')
    cv.fill(cv.poly([(186, 106), (194, 106), (190, 118)]), '#3a2010')
    can = cylinder(cv, 60, 140, 90, 180, '#4a5040')
    lid = cv.ellipse(75, 140, 15, 4)
    cv.fill(lid, '#5a6050')
    cv.vignette(0.5)
    return cv


def backroom():
    cv = Canvas(bg='#000000')
    r = Room(cv, (70, 30, 250, 125))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, blocks(cv, 1 / z * 50, a, '#2a2420', '#3e3630', 16, 8, '#100e0c'))
        r.depth_shade(m, z, 0.8, 0.3)
    m, u, z = r.surface('floor')
    cv.fill(m, cv.texture('#2a2420', '#3a322a', 3, 3, 4))
    r.depth_shade(m, z, 0.9, 0.3)
    back = cv.rect(70, 30, 250, 125)
    cv.fill(back, blocks(cv, cv.X, cv.Y, '#2a2420', '#3e3630', 16, 8, '#100e0c'))
    cv.tint(back, 0.6)
    lit = cv.rgrad(160, 30, 150, '#ffffff', '#000000')[..., 0]
    cv.tint(cv.everywhere(), 0.35 + 0.9 * lit)
    cv.fill(cv.line([(160, 0), (160, 18)], 0.6), '#202020')
    bulb = cv.ellipse(160, 22, 4, 5)
    cv.fill(bulb, '#fff8d0')
    cv.glow(bulb, '#ffe0a0', 20, 0.5)
    cv.animate(bulb, ['#fff8d0', '#fff8d0', '#fff8d0', '#c0b080', '#fff8d0'], speed=5)
    sm = cv.rect(130, 60, 190, 150)
    cv.fill(sm, cv.hgrad([(130, '#802020'), (150, '#e04040'), (190, '#601010')]))
    cv.bevel(sm, 3, 0.6)
    top = cv.ellipse(160, 62, 30, 12) * (cv.Y < 62)
    cv.fill(top, '#c03030')
    win = cv.rect(138, 76, 182, 96)
    cv.fill(win, '#f0f0e0')
    for i, c in enumerate(['#202020', '#c02020', '#202020']):
        sym = cv.ellipse(146 + i * 14, 86, 4, 6)
        cv.fill(sym, c)
    cv.fill(cv.rect(140, 104, 180, 110), '#e0c040')
    arm = cv.line([(196, 70), (206, 60), (206, 80)], 2)
    cv.fill(arm, '#a0a0a8')
    knob = cv.ellipse(206, 58, 5, 5)
    cv.fill(knob, '#202020')
    cv.shade_sphere(206, 58, 5, knob, spec=0.6)
    skull = cv.ellipse(160, 126, 8, 7)
    cv.fill(skull, '#e0e0d0')
    for s in (-1, 1):
        cv.fill(cv.ellipse(160 + s * 3, 125, 2, 2), '#101010')
    sign = cv.rect(214, 50, 248, 66)
    cv.fill(sign, '#e0d8b0')
    for i in range(3):
        cv.fill(cv.rect(217, 53 + i * 4, 245, 54 + i * 4) * ((cv.X.astype(int) % 3) > 0), '#401010')
    cv.vignette(0.5)
    return cv


def pirate_ship(cv, x, y, s=1.0):
    hull = cv.poly([(x - 90 * s, y - 10 * s), (x + 90 * s, y - 14 * s), (x + 70 * s, y + 24 * s), (x - 70 * s, y + 24 * s)])
    cv.fill(hull, planks(cv, cv.X, cv.Y, '#3a2410', '#6a4420', 6 * s))
    cv.bevel(hull, 3, 0.6)
    for i in range(3):
        mx = x - 50 * s + i * 50 * s
        mast = cv.rect(mx - 2 * s, y - 80 * s, mx + 2 * s, y - 10 * s)
        cv.fill(mast, '#4a3018')
        sail = cv.poly([(mx - 28 * s, y - 74 * s), (mx + 28 * s, y - 74 * s), (mx + 22 * s, y - 24 * s), (mx - 22 * s, y - 24 * s)])
        cv.fill(sail, cv.hgrad([(mx - 28 * s, '#3a4a6a'), (mx, '#8ab0e0'), (mx + 28 * s, '#3a4a6a')]))
        cv.fill(sail * (((cv.X - mx) / (6 * s)).astype(int) % 2 == 0), '#c0d8ff', 0.15)
    skull = cv.ellipse(x, y - 50 * s, 8 * s, 7 * s)
    cv.fill(skull, '#f0f0f0')
    return hull


def pcockpit():
    cv = Canvas()
    space(cv, 0, 0, W, 120, seed=21, neb=('#103020', '#204060'))
    pirate_ship(cv, 160, 70, 0.9)
    beam = cv.poly([(140, 90), (180, 90), (230, 120), (90, 120)])
    cv.fill(beam, '#40ff60', 0.35)
    cv.glow(beam, '#40ff60', 10, 0.3)
    cv.animate(beam * ((cv.Y.astype(int) % 3) == 0), ['#80ff90', '#40c050', '#209030', '#40c050'], speed=3, regs=3, phase=(cv.Y / 9) % 1)
    cockpit_frame(cv)
    console(cv, 0, 118, W, 192, '#384050', seed=21, slope=14)
    al = np.zeros((cv.h, cv.w), np.float32)
    for x in (40, 280):
        a = cv.ellipse(x, 140, 8, 8)
        cv.fill(a, '#ff2020')
        al = np.maximum(al, a)
    cv.glow(al, '#ff2020', 12, 0.5)
    cv.animate(al, ['#ff2020', '#ff2020', '#300404', '#300404'], speed=8)
    screen(cv, 120, 140, 200, 175, '#40ff60', content='radar', seed=4)
    cv.vignette(0.3)
    return cv


def pairlock():
    cv = airlock()
    win = cv.ellipse(160, 62, 8, 5)
    cab = cv.line([(150, 70), (170, 54)], 2.5) * win
    cv.fill(cab, '#8a7050')
    return cv


def deck():
    cv = Canvas()
    m = cv.rect(0, 0, W, 120)
    cv.fill(m, '#04040c')
    cv.set_sky(m)
    star_field(cv, 0, 0, W, 120, 120, 31)
    nebula(cv, m, '#203060', '#401040', 40, 6, 0.5)
    fl = cv.poly([(0, 120), (W, 120), (W, H), (0, H)])
    d = np.maximum(cv.Y - 70, 0.1)
    cv.fill(fl, planks(cv, (cv.X - 160) * 40 / d, 800 / d, '#3a2410', '#6a4420', 4))
    rail = cv.rect(0, 112, W, 120)
    cv.fill(rail, planks(cv, cv.X, cv.Y, '#4a3018', '#7a5028', 3))
    cv.bevel(rail, 1, 0.6)
    mast = cv.rect(150, 0, 162, 160)
    cv.fill(mast, planks(cv, cv.X, cv.Y, '#3a2410', '#6a4420', 4, along='v'))
    cv.bevel(mast, 2, 0.6)
    for (x0, y0, x1, y1) in [(40, 10, 145, 90), (167, 4, 290, 80)]:
        sail = cv.poly([(x0, y0), (x1, y0 + 4), (x1 - 8, y1), (x0 + 8, y1 - 4)])
        cv.fill(sail, cv.hgrad([(x0, '#5070a0'), ((x0 + x1) / 2, '#c0d8ff'), (x1, '#405880')]))
        cv.fill(sail * ((((cv.X - x0) / 8).astype(int)) % 2 == 0), '#ffffff', 0.12)
        cv.bevel(sail, 4, 0.4)
    poster = cv.rect(140, 96, 172, 132)
    cv.fill(poster, '#e0d0a0')
    cv.bevel(poster, 1, 0.5)
    face = cv.ellipse(156, 110, 7, 8)
    cv.fill(face, '#806040')
    cv.fill(cv.rect(144, 122, 168, 126) * ((cv.X.astype(int) % 3) > 0), '#601010')
    cable = cv.line([(0, 100), (40, 112), (90, 118)], 3)
    cv.fill(cable, '#8a7050')
    cv.bevel(cable, 1, 0.6)
    hatch = cv.rect(270, 140, 310, 170)
    cv.fill(hatch, planks(cv, cv.X, cv.Y, '#2a1808', '#4a2c14', 5))
    cv.bevel(hatch, 1.5, 0.6)
    cv.vignette(0.35)
    return cv


def cabin():
    cv = Canvas(bg='#100a06')
    r = Room(cv, (60, 30, 260, 115))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, planks(cv, 1 / z * 50, a, '#2a1608', '#4a2a12', 7, along='v'))
        r.depth_shade(m, z, 0.8, 0.4)
    m, u, z = r.surface('floor')
    cv.fill(m, planks(cv, u, 1 / z * 30, '#2a1608', '#4a2a12', 5))
    back = cv.rect(60, 30, 260, 115)
    cv.fill(back, planks(cv, cv.X, cv.Y, '#2a1608', '#4a2a12', 7, along='v'))
    cv.tint(back, 0.65)
    win = viewport(cv, 140, 38, 180, 78, '#6a4420', round_=True)
    cv.fill(cv.ellipse(160, 58, 20, 20), '#04040c')
    star_field(cv, 140, 38, 180, 78, 16, 3)
    viewport(cv, 140, 38, 180, 78, '#6a4420', round_=True)
    # the captain: a green ghost
    ghost = person(cv, 160, 150, 78, coat='#3a7a5a', skin='#a0ffc0', hair='#205040', beard='#60a080', hat='#202020')
    cv.glow(ghost, '#60ff90', 10, 0.35)
    cv.fill(ghost, '#80ffb0', 0.25)
    bugs = np.zeros((cv.h, cv.w), np.float32)
    rng = np.random.default_rng(6)
    for i in range(8):
        bugs = np.maximum(bugs, cv.ellipse(160 + rng.uniform(-6, 6), 92 + rng.uniform(-3, 4), 0.8, 0.8))
    cv.animate(bugs, ['#ffff40', '#202010', '#ffff40', '#ffffff'], speed=4, regs=2, phase=cv.noise(1, 1, 3))
    desk = cv.rect(70, 130, 250, 192)
    cv.fill(desk, planks(cv, cv.X, cv.Y, '#3a1a08', '#6a3a1a', 10))
    cv.bevel(desk, 2, 0.6)
    top = cv.rect(64, 124, 256, 132)
    cv.fill(top, '#7a4a20')
    cv.bevel(top, 1, 0.6)
    coins = np.zeros((cv.h, cv.w), np.float32)
    for i in range(9):
        c = cv.ellipse(96 + (i % 3) * 7, 120 - (i // 3) * 2.5, 6, 2)
        cv.fill(c, '#e0c040')
        coins = np.maximum(coins, c)
    cv.bevel(coins, 0.6, 0.6)
    cake = cv.rect(204, 112, 230, 124)
    cv.fill(cake, '#a06030')
    cv.fill(cv.rect(204, 110, 230, 114), '#f0e0e0')
    cv.fill(cv.rect(216, 104, 218, 110), '#e0e0ff')
    fl = cv.ellipse(217, 102, 1.3, 2)
    cv.fill(fl, '#ffd040')
    cv.glow(fl, '#ffb040', 5, 0.5)
    key = cv.line([(174, 118), (178, 134)], 1.5)
    cv.fill(key, '#e0c040')
    cv.vignette(0.45)
    return cv


def pengine():
    cv = Canvas(bg='#060a06')
    r = Room(cv, (60, 30, 260, 120))
    for side in ('left', 'right', 'ceiling'):
        m, a, z = r.surface(side)
        cv.fill(m, planks(cv, 1 / z * 50, a, '#24180c', '#3e2a16', 7, along='v'))
        r.depth_shade(m, z, 0.8, 0.35)
    m, u, z = r.surface('floor')
    cv.fill(m, planks(cv, u, 1 / z * 30, '#24180c', '#3e2a16', 5))
    back = cv.rect(60, 30, 260, 120)
    cv.fill(back, planks(cv, cv.X, cv.Y, '#24180c', '#3e2a16', 7, along='v'))
    cv.tint(back, 0.6)
    gen = cylinder(cv, 120, 40, 200, 120, '#4a6050')
    orb = cv.ellipse(160, 70, 22, 22)
    cv.fill(orb, cv.rgrad(156, 66, 22, '#e0ffe0', '#20a040'))
    cv.glow(orb, '#40ff60', 25, 0.6)
    ph = (np.sqrt((cv.X - 160) ** 2 + (cv.Y - 70) ** 2) / 22) % 1
    cv.animate(orb, ['#e0ffe0', '#80ff90', '#30c050', '#108030', '#30c050', '#80ff90'], speed=4, regs=4, phase=ph)
    kh = cv.poly([(156, 98), (164, 98), (162, 112), (158, 112)]) + cv.ellipse(160, 98, 4, 4)
    cv.fill(np.clip(kh, 0, 1), '#101010')
    for x, y in ((70, 150), (90, 128), (250, 150), (238, 128)):
        crate(cv, x - 18, y - 22, x + 18, y + 10, 6)
    person(cv, 280, 180, 60, coat='#c02020', skin='#e0b090', hair='#2a2010')
    cv.vignette(0.45)
    return cv


SCENES = dict(cockpit=cockpit, shipcorr=shipcorr, galley=galley, engine=engine, cargo=cargo, airlock=airlock, dock=dock,
              stcorr=stcorr, quarters=quarters, power=power, maproom=maproom, pad=pad, plaza=plaza, bar=bar, stan=stan,
              alley=alley, backroom=backroom, pcockpit=pcockpit, pairlock=pairlock, deck=deck, cabin=cabin, pengine=pengine)
