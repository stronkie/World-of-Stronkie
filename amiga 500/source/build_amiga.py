"""THE WORLD OF STRONKIE - Amiga 500 version: builds the data files and the disk.

The story and the puzzles come from the C64 version (/home/claude/adv): every part is
compiled with the C64 chapter compiler, then turned into an Amiga part file with 32-bit
offsets. V2.0: the pictures are new 320x192 paintings in 32 colours (../art: scenes1-4.py,
painted with paint.py and kit.py). Every picture has its own palette, a copper sky and
colour cycling, and is stored as packed 'chunky' pixels; the engine unpacks it and converts
it to five bitplanes. Sampled sound effects and speech (flite) are Fibonacci-delta packed.

Output (out/):
    partNN.s            vasm source of every part file (assembled with vasm -Fbin)
    PARTnn              the part files on the disk (packed with zxpack)
    menu.s / MENU       title picture, menu music
    Stronkie            the program (vasm -Fhunkexe)
    The_World_of_Stronkie_Amiga_Vx.y_Disk1-3.adf (three disks)
    sound_and_speech_preview.wav (soundpreview.py)
"""
import os
import random
import subprocess
import sys

sys.path.insert(0, '/home/claude/adv')
_cwd = os.getcwd()
os.chdir('/home/claude/adv')            # the C64 modules read their files from there
import art          # noqa: E402
import anims        # noqa: E402
import asm6502      # noqa: E402
import build        # noqa: E402
import mapgen       # noqa: E402
import music        # noqa: E402
import sprites      # noqa: E402
import zxpack       # noqa: E402
from story import CHAPTERS  # noqa: E402
os.chdir(_cwd)

VERSION = 'V2.0'
HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, 'out')
VASM = '/home/claude/amiga/tools/vasm/vasmm68k_mot'

SKY_REG = 20                 # sky pixels: this colour register changes on every line (copper)
CYCLE_REG0 = 24              # colour cycling registers 24-31
SPR_COLS = (17, 21)          # sprite pairs 0/1 and 2/3


def rgb12(c):
    r, g, b = c
    return ((r * 15 + 127) // 255) << 8 | ((g * 15 + 127) // 255) << 4 | ((b * 15 + 127) // 255)


PAL12 = [rgb12(c) for c in art.PAL]


# ---------------------------------------------------------------------------
# a small source writer: vasm (Motorola syntax) data
# ---------------------------------------------------------------------------
class Src:
    def __init__(self):
        self.lines = []

    def __call__(self, s=''):
        self.lines.append(s)

    def bytes(self, data, per=32):
        data = list(data)
        for i in range(0, len(data), per):
            self('        dc.b ' + ','.join(f'${b:02x}' for b in data[i:i + per]))

    def words(self, data, per=16):
        data = list(data)
        for i in range(0, len(data), per):
            self('        dc.w ' + ','.join(f'${w & 0xffff:04x}' for w in data[i:i + per]))

    def text(self, raw):
        """C64-style text bytes (colour codes, 13 = new line, 0 = end) as dc.b."""
        items, cur = [], ''
        for b in raw:
            if 32 <= b < 127 and b != 34:
                cur += chr(b)
            else:
                if cur:
                    items.append(f'"{cur}"')
                    cur = ''
                items.append(f'${b:02x}' if b > 9 else str(b))
        if cur:
            items.append(f'"{cur}"')
        # keep the lines short
        line = []
        n = 0
        for it in items:
            line.append(it)
            n += len(it)
            if n > 60:
                self('        dc.b ' + ','.join(line))
                line, n = [], 0
        if line:
            self('        dc.b ' + ','.join(line))

    def even(self):
        self('        even')

    def source(self):
        return '\n'.join(self.lines) + '\n'


# ---------------------------------------------------------------------------
# pictures: chunky 160x96 + sky gradient + colour cycling registers
# ---------------------------------------------------------------------------
def mix(a, b, t):
    return tuple(a[i] + (b[i] - a[i]) * t for i in range(3))


def sky_lines(grad):
    """12 colours (one per C64 character row) -> 192 smooth copper colours."""
    rgb = [art.PAL[c] for c in grad]
    out = []
    for y in range(192):
        p = (y + 0.5) / 16 - 0.5            # position in rows (row centres at .5)
        r0 = max(0, min(11, int(p // 1)))
        t = max(0.0, min(1.0, p - r0))
        r1 = min(11, r0 + 1)
        if grad[r1] == 0 and grad[r0] != 0:   # the horizon: no blend into black
            t = 0
        c = mix(rgb[r0], rgb[r1], t)
        out.append(rgb12(tuple(int(round(v)) for v in c)))
    return out


def picture_data(name):
    """-> dict(chunky=bytes 160*96, sky=[192] or None, cycles=[(reg, speed, colours)])"""
    cv = art.PICTURES[name]()
    px = cv.px
    chunky = bytearray(160 * 96)
    for y in range(96):
        for x in range(160):
            v = px[x, y]
            chunky[y * 160 + x] = SKY_REG if v == art.SKY else v
    sky = sky_lines(cv.gradient) if cv.gradient else None
    cycles = []
    specs = anims.SPECS.get(name, [])
    if specs:
        regs_per = max(1, min(3, 8 // len(specs)))
        reg = CYCLE_REG0
        for (x0, y0, x1, y1), colour, seq, speed in specs:
            small = art.BLACK in seq and colour == art.WHITE
            cells = []
            for cy in range(y0, y1 + 1):
                for cx in range(x0, x1 + 1):
                    pts = [(x, y) for y in range(cy * 8, cy * 8 + 8) for x in range(cx * 4, cx * 4 + 4)
                           if chunky[y * 160 + x] == colour]
                    if not pts or (small and len(pts) > 3):
                        continue
                    cells.append(pts)
            if not cells:
                continue
            n = min(regs_per, len(cells), CYCLE_REG0 + 8 - reg)
            if n <= 0:
                break
            for k, pts in enumerate(cells):
                for x, y in pts:
                    chunky[y * 160 + x] = reg + k % n
            for k in range(n):
                rot = (k * len(seq)) // n
                s = seq[rot:] + seq[:rot]
                cycles.append((reg + k, speed, [PAL12[c] for c in s]))
            reg += n
    return dict(chunky=bytes(chunky), sky=sky, cycles=cycles)


def emit_picture(S, label, name):
    p = picture_data(name)
    S(f'{label}                              ; picture "{name}"')
    S(f'        dc.w {1 if p["sky"] else 0},{len(p["cycles"])}       ; flags (1 = sky), cycling registers')
    if p['sky']:
        S('        ; sky: 192 copper colours for register 20')
        S.words(p['sky'])
    for reg, speed, cols in p['cycles']:
        S(f'        dc.w {reg},{speed},{len(cols)}       ; colour register, speed, colours')
        S.words(cols)
    S('        ; 160x96 pixels in a frame of 162x98 (the edge pixels repeated), value*4')
    S('        ; (values: 0-15 C64 colours, 20 sky, 24-31 colour cycling)')
    c = p['chunky']
    pad = bytearray()
    for y in range(-1, 97):
        yy = min(95, max(0, y))
        row = c[yy * 160:(yy + 1) * 160]
        pad += bytes([row[0]]) + row + bytes([row[-1]])
    S.bytes(bytes(v * 4 for v in pad), 27)
    return p


# ---------------------------------------------------------------------------
# sprites
# ---------------------------------------------------------------------------
def sprite_columns(rows, wide, tall):
    """C64 multicolour image -> Amiga sprite columns: list (per 16 px column) of (plane0, plane1)
    word lists. A fat C64 pixel becomes 2 lores pixels (4 if wide), a line 2 lines (4 if tall)."""
    rows = rows.strip('\n').split('\n')
    sx = 4 if wide else 2
    sy = 4 if tall else 2
    width = 12 * sx
    ncol = (width + 15) // 16
    lines = []
    for r in rows:
        pix = []
        for ch in r:
            pix += [sprites.CODE[ch]] * sx
        pix += [0] * (ncol * 16 - len(pix))
        for _ in range(sy):
            lines.append(pix)
    cols = []
    for c in range(ncol):
        p0, p1 = [], []
        for pix in lines:
            a = b = 0
            for i in range(16):
                v = pix[c * 16 + i]
                a = a << 1 | (v & 1)
                b = b << 1 | (v >> 1)
            p0.append(a)
            p1.append(b)
        cols.append((p0, p1))
    return cols, len(lines)


def frame_rows(f):
    return sprites.mirror(sprites.FRAMES[f[:-2]]) if f.endswith('_l') else sprites.FRAMES[f]


def emit_actors(S, ch, rooms):
    n = ch['number']
    part = sprites.PARTS.get(n)
    frames = []            # (name, wide, tall)
    entries = []
    if part:
        (mc1, mc2), actors = part
        for a in actors:
            if a['room'] == 'menu':
                continue
            wide, tall = bool(a['flags'] & 2), bool(a['flags'] & 4)
            f0 = len(frames)
            for f in a['frames']:
                frames.append((f, wide, tall))
            entries.append((rooms.index(a['room']) + 1, a, f0, wide, tall, mc1, mc2))
    S('actors                               ; moving sprites per room')
    S(';       room, sprites, first image, images, image delay, move delay, dx, dy')
    S(';       x, y (C64 sprite coordinates), height in lines, colours 1-3')
    per_room = {}
    for room, a, f0, wide, tall, mc1, mc2 in entries:
        cols, h = sprite_columns(frame_rows(a['frames'][0]), wide, tall)
        per_room[room] = per_room.get(room, 0) + (len(cols) + 1) // 2 * 2
        assert per_room[room] <= 4, f'part {n}: too many sprites in room {room}'
        dx = a['dx'] if a['dx'] < 128 else a['dx'] - 256
        dy = a['dy'] if a['dy'] < 128 else a['dy'] - 256
        S(f'        dc.b {room},{len(cols)},{f0},{len(a["frames"])},{a["ad"]},{a["md"]},{dx},{dy}')
        S(f'        dc.w {a["x"]},{a["y"]},{h},${PAL12[mc1]:03x},${PAL12[a["colour"]]:03x},${PAL12[mc2]:03x}')
    S('        dc.b 0')
    S.even()
    S('frames                               ; offsets of the sprite images')
    for i in range(len(frames)):
        S(f'        dc.l fr{i}-base')
    for i, (f, wide, tall) in enumerate(frames):
        cols, h = sprite_columns(frame_rows(f), wide, tall)
        S(f'fr{i}                              ; "{f}"{" wide" if wide else ""}{" tall" if tall else ""}: {len(cols)} sprite(s), {h} lines')
        for p0, p1 in cols:
            S.words([w for pair in zip(p0, p1) for w in pair])


# ---------------------------------------------------------------------------
# music
# ---------------------------------------------------------------------------
def emit_song(S, label, inst, voices):
    """inst: (waveform, AD, SR, pulse) per voice; voices: byte lists (note, frames)... $ff."""
    S(f'{label}')
    S(f'        dc.w {len(voices)}                  ; voices')
    for w, ad, sr, pw in inst:
        S(f'        dc.b ${w:02x},${ad:02x},${sr:02x},${pw:02x}     ; waveform, attack/decay, sustain/release, pulse')
    for i in range(len(voices)):
        S(f'        dc.l {label}_v{i + 1}-base')
    for i, data in enumerate(voices):
        S(f'{label}_v{i + 1}')
        S.bytes(data + [0xff])
    S.even()


def song_voices(name):
    s = music.SONGS[name]
    return s['inst'], [music.voice(v, s['unit'])[0] for v in s['voices']]


def tune_voices(jingle, song):
    j = music.JINGLES[jingle]
    s = music.SONGS[song]
    out = []
    for i in range(3):
        jd, _ = music.voice(j['voices'][i], j['unit'])
        sd, _ = music.voice(s['voices'][i], s['unit'])
        out.append(jd + [0xFE] + sd)
    return s['inst'], out



# ---------------------------------------------------------------------------
# V1.1: new Amiga pictures (painted by the scenes in ../art), sprites, speech
# ---------------------------------------------------------------------------
ART = '/home/claude/amiga/art'
sys.path.insert(0, ART)
import amiga_sprites as AS      # noqa: E402
import amiga_sound as SND       # noqa: E402

PIC_OVERRIDE = {(17, 'garden'): 'egarden'}      # the epilogue garden: morning, the ship on the lawn
_scenes = None


def scenes():
    global _scenes
    if _scenes is None:
        import scenes1, scenes2, scenes3, scenes4
        _scenes = {}
        for m in (scenes1, scenes2, scenes3, scenes4):
            _scenes.update(m.SCENES)
    return _scenes


def sprite_pics():
    """pictures of rooms with moving sprites: they keep colours 17-19 and 21-23 free"""
    out = set()
    for ch in CHAPTERS:
        part = sprites.PARTS.get(ch['number'])
        if not part:
            continue
        for a in part[1]:
            if a['room'] != 'menu':
                out.add(PIC_OVERRIDE.get((ch['number'], a['room']), ch['rooms'][a['room']]['pic']))
    return out


_rendered = {}


def render_picture(name):
    if name not in _rendered:
        import paint
        cv = scenes()[name]()
        _rendered[name] = paint.finish(cv, sprite_regs=name in sprite_pics(), name=name)
        _rendered[name]['preview'].save(os.path.join(OUT, 'pics', name + '.png'))
    return _rendered[name]


def pic_block(name, cache):
    """.w flags (1 = sky), .w cycling registers, 32 colours, [192 sky colours],
    per cycling register (.w register, speed, n, colours), .l packed length, packed
    320x192 pixels (register*4)"""
    import struct
    r = render_picture(name)
    assert len(r['cycles']) <= 16, f'{name}: more than 16 cycling registers (cyc_tab)'
    w = [1 if r['sky'] else 0, len(r['cycles'])]
    w += list(r['palette'])
    if r['sky']:
        w += r['sky']
    for reg, speed, cols in r['cycles']:
        w += [reg, speed, len(cols)] + cols
    chunky = (r['chunky'].astype('uint8') * 4).tobytes()
    packed = pack_file(chunky, cache)
    b = struct.pack(f'>{len(w)}H', *w) + struct.pack('>L', len(packed)) + packed
    if len(b) % 2:
        b += b'\0'
    return b


def speech_clip(text, cache, voice='slt', robot=True, maxsec=4.2):
    """flite -> 6.5 kHz 8 bit -> Fibonacci delta. .w period, .w samples, data"""
    import hashlib
    import struct
    rate = 6500
    key = hashlib.sha1(f'{text}|{voice}|{robot}|{maxsec}|{rate}'.encode()).hexdigest()
    p = os.path.join(cache, key + '.spk')
    if os.path.exists(p):
        return open(p, 'rb').read()
    words = text
    x, _ = SND.speech(words, voice, rate, robot)
    while len(x) > rate * maxsec and ('.' in words.strip('. ') or ',' in words or '!' in words.strip('! ')):
        for sep in ('. ', '! ', '? ', ', '):
            if sep in words:
                words = words[:words.rfind(sep) + 1]
                break
        x, _ = SND.speech(words, voice, rate, robot)
    if len(x) > rate * maxsec:
        x = x[:int(rate * maxsec)]
    if len(x) % 2:
        x = x[:-1]
    data = SND.fib_encode(x)
    b = struct.pack('>HH', SND.period(rate), len(x)) + data
    if len(b) % 2:
        b += b'\0'
    open(p, 'wb').write(b)
    return b


def nova_text(msg):
    import re
    flat = ' '.join(''.join(c if c >= ' ' else ' ' for c in msg).split())
    m = re.search(r"NOVA(?:'S VOICE[A-Z ]*| ON [A-Z ]*)?: '(.*?)'(?:\s|$)", flat)
    if not m:
        return None
    q = m.group(1).replace('PILOT', 'pilot').replace('STARRAVEN', 'Star Raven')
    return q.capitalize() if len(q) > 3 else None


def emit_actors(S, ch, rooms):
    n = ch['number']
    part = sprites.PARTS.get(n)
    frames = []
    entries = []
    if part:
        for a in part[1]:
            if a['room'] == 'menu':
                continue
            f0 = len(frames)
            frames += a['frames']
            entries.append((rooms.index(a['room']) + 1, a, f0))
    S('actors                               ; moving sprites per room')
    S(';       room, sprites, first image, images, image delay, move delay, dx, dy')
    S(';       x, y (C64 sprite coordinates), height in lines, colours 1-3')
    per_room = {}
    for room, a, f0 in entries:
        cols, h = AS.columns(a['frames'][0])
        per_room[room] = per_room.get(room, 0) + (len(cols) + 1) // 2 * 2
        assert per_room[room] <= 4, f'part {n}: too many sprites in room {room}'
        dx = a['dx'] if a['dx'] < 128 else a['dx'] - 256
        dy = a['dy'] if a['dy'] < 128 else a['dy'] - 256
        c1, c2, c3 = AS.COLOURS[AS.family(a['frames'][0])]
        S(f'        dc.b {room},{len(cols)},{f0},{len(a["frames"])},{a["ad"]},{a["md"]},{dx},{dy}')
        S(f'        dc.w {a["x"]},{a["y"]},{h},${c1:03x},${c2:03x},${c3:03x}')
    S('        dc.b 0')
    S.even()
    S('frames                               ; offsets of the sprite images')
    for i in range(len(frames)):
        S(f'        dc.l fr{i}-base')
    for i, f in enumerate(frames):
        cols, h = AS.columns(f)
        S(f'fr{i}                              ; "{f}": {len(cols)} sprite(s), {h} lines')
        for p0, p1 in cols:
            S.words([w for pair in zip(p0, p1) for w in pair])


# ---------------------------------------------------------------------------
# part files
# ---------------------------------------------------------------------------
def cstr(mem, addr):
    out = bytearray()
    while mem[addr] != 0:
        out.append(mem[addr])
        addr += 1
    return bytes(out + b'\0')


def part_source(k, cache=None):
    ch = CHAPTERS[k]
    nxt = CHAPTERS[k + 1] if k + 1 < len(CHAPTERS) else None
    n = ch['number']
    src, _ = build.compile_chapter(ch, nxt, None)
    origin, code, syms, _ = asm6502.assemble(src, f'part{n}')
    mem = bytearray(65536)
    mem[origin:origin + len(code)] = code
    w = lambda a: mem[a] | mem[a + 1] << 8
    H = 0x4000
    assert bytes(mem[H:H + 4]) == b'CHAP'
    num, start, nroom, nobj = mem[H + 4:H + 8]
    rooms_a, objs_a, nouns_a, acts_a, msgs_a = (w(H + 8 + 2 * i) for i in range(5))
    intro_a, song_a, title_a, short_a = (w(H + 18 + 2 * i) for i in range(4))
    statc, border = mem[H + 30], mem[H + 31]
    quip_a = w(H + 32)
    pic_name = {v: k[4:] for k, v in syms.items() if k.startswith('pic_')}
    rooms = list(ch['rooms'])

    S = Src()
    S(';' + '=' * 70)
    S(f';  THE WORLD OF STRONKIE {VERSION} (Amiga) - {ch["title"]}')
    S(';  Created By Mark Stronks')
    S(';')
    S(f';  Part file "PART{n:02d}": vasm -Fbin -o part{n:02d}.bin part{n:02d}.s')
    S(';  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.')
    S(';  All pointers are offsets from the start of the file.')
    S(';' + '=' * 70)
    S('base')
    S('        dc.b "CHAP"')
    S(f'        dc.b {num},{start},{nroom},{nobj}       ; part, start room, rooms, objects')
    for lab in ['rooms', 'objects', 'nouns', 'actions', 'messages', 't_intro']:
        S(f'        dc.l {lab}-base')
    S(f'        dc.l {"song-base" if song_a else "0"}            ; music')
    for lab in ['t_title', 't_short']:
        S(f'        dc.l {lab}-base')
    S(f'        dc.l {"card-base" if nxt else "0"}            ; title card of the next part')
    S('        dc.l t_quip-base')
    S('        dc.l actors-base, frames-base')
    S('        dc.l map_data-base')
    S('        dc.l t_save-base')
    S(f'        dc.l {"tune-base" if ch.get("tune") else "0"}            ; jingle (TUNE action)')
    S(f'        dc.b {statc},{border}')
    S('        dc.w 0')
    S('        dc.l speech-base                ; speech: message number -> sample (picture blob)')
    # rooms
    S('rooms                                ; description, picture, exits N S E W U D')
    pics = []
    for i in range(nroom):
        a = rooms_a + i * 10
        d, p = w(a), w(a + 2)
        ex = list(mem[a + 4:a + 10])
        pn = PIC_OVERRIDE.get((n, rooms[i]), pic_name[p])
        if pn not in pics:
            pics.append(pn)
        S(f'        dc.l d{i + 1}-base,PIC_{pn.upper()}')
        S(f'        dc.b {",".join(map(str, ex))},0,0      ; {rooms[i]}')
    S('objects                              ; noun, place, flags, 0, name, examine text')
    texts = {}                     # C64 address -> label

    def tlabel(a, lab=None):
        if a == 0:
            return None
        if a not in texts:
            texts[a] = lab or f't{len(texts)}'
        return texts[a]

    for i in range(nobj):
        a = objs_a + i * 8
        noun, loc, fl, z = mem[a:a + 4]
        nm, ex = w(a + 4), w(a + 6)
        ln, lx = tlabel(nm), tlabel(ex)
        S(f'        dc.b {noun},{loc},{fl},0')
        S(f'        dc.l {ln}-base,{(lx + "-base") if lx else "0"}')
    # nouns
    S('nouns                                ; four letters + noun number, 0 = end')
    a = nouns_a
    while mem[a]:
        S(f'        dc.b "{bytes(mem[a:a + 4]).decode()}",{mem[a + 4]}')
        a += 5
    S('        dc.b 0')
    # actions: the same byte code as on the C64 (the TUNE argument is not used)
    S('actions                              ; verb, noun, length, conditions, actions, 0 ... $ff')
    a = acts_a
    while mem[a] != 0xFF:
        ln = mem[a + 2]
        S('        dc.b ' + ','.join(f'${b:02x}' for b in mem[a:a + ln]))
        a += ln
    S('        dc.b $ff')
    S.even()
    # messages
    # the message table runs until the first message text
    first = w(msgs_a)
    count = (first - msgs_a) // 2
    S('messages')
    for i in range(count):
        S(f'        dc.l m{i + 1}-base')
    for i in range(count):
        S(f'm{i + 1}')
        S.text(cstr(mem, w(msgs_a + 2 * i)))
    for lab, a in [('t_intro', intro_a), ('t_title', title_a), ('t_short', short_a), ('t_quip', quip_a)]:
        S(lab)
        S.text(cstr(mem, a))
    for i in range(nroom):
        S(f'd{i + 1}')
        S.text(cstr(mem, w(rooms_a + i * 10)))
    for a, lab in texts.items():
        S(lab)
        S.text(cstr(mem, a))
    S('t_save')
    S.text(build.SAVE_NAMES[n].encode() + b'\0')
    # the map (MAP command)
    mb, _ = mapgen.build_map(ch, rooms)
    S('map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines')
    S.bytes(list(mb))
    S.even()
    # music
    if song_a:
        inst, vs = song_voices(ch['song'])
        emit_song(S, 'song', inst, vs)
    if ch.get('tune'):
        inst, vs = tune_voices(ch['tune'], ch['song'])
        emit_song(S, 'tune', inst, vs)
    # sprites
    emit_actors(S, ch, rooms)
    # pictures and speech: in the blob after the packed part (offsets from its start)
    blob = bytearray()
    equ = []
    for pn in pics:
        equ.append(f'PIC_{pn.upper():<12}= ${len(blob):06x}      ; picture "{pn}" in the blob')
        blob += pic_block(pn, cache)
    S('speech                               ; message number, 0, offset of the sample in the blob')
    for i in range(count):
        t = nova_text(cstr(mem, w(msgs_a + 2 * i))[:-1].decode('latin1'))
        if t:
            S(f'        dc.w {i + 1},0')
            S(f'        dc.l ${len(blob):06x}             ; NOVA: {t[:40]}')
            blob += speech_clip(t, cache)
    S('        dc.w 0')
    if nxt:
        kind, _, name = nxt['title'].partition(':')
        say = f'{kind.strip().title()}. {name.strip().title()}'.replace("'S", "'s")
        S('card                                 ; next part: kind, name, spoken title (in the blob)')
        S('        dc.l card_k-base,card_n-base')
        S(f'        dc.l ${len(blob):06x}             ; "{say}"')
        blob += speech_clip(say, cache, voice='rms', robot=False, maxsec=4.0)
        S('card_k')
        S.text(kind.strip().upper().encode() + b'\0')
        S('card_n')
        S.text(name.strip().upper().encode() + b'\0')
        S.even()
    S.even()
    S('part_end')
    src = S.source()
    i = src.index('base\n')
    src = src[:i] + '\n'.join(equ) + '\n\n' + src[i:]
    return src, bytes(blob)


def vasm_bin(src_path, out_path):
    r = subprocess.run([VASM, '-quiet', '-Fbin', '-o', out_path, src_path], capture_output=True, text=True)
    if r.returncode:
        print(r.stdout[-3000:], r.stderr[-3000:])
        raise SystemExit('vasm failed: ' + src_path)
    return open(out_path, 'rb').read()


def pack_file(data, cache_dir):
    """zxpack with a cache (the optimal parse takes a while in Python)."""
    import hashlib
    h = hashlib.sha1(data).hexdigest()
    p = os.path.join(cache_dir, h + '.zx')
    if os.path.exists(p):
        return open(p, 'rb').read()
    packed = zxpack.pack(data)
    assert zxpack.unpack(packed) == data
    open(p, 'wb').write(packed)
    return packed


def main(only=None):
    os.makedirs(os.path.join(OUT, 'pics'), exist_ok=True)
    cache = os.path.join(HERE, '.cache')
    os.makedirs(cache, exist_ok=True)
    files = []
    for k, ch in enumerate(CHAPTERS):
        n = ch['number']
        if only and n not in only:
            continue
        src, blob = part_source(k, cache)
        sp = os.path.join(OUT, f'part{n:02d}.s')
        open(sp, 'w').write(src)
        data = vasm_bin(sp, os.path.join(OUT, f'part{n:02d}.bin'))
        packed = pack_file(data, cache)
        if len(packed) % 2:
            packed += b'\0'
        import struct
        f = struct.pack('>L', len(packed)) + packed + blob
        open(os.path.join(OUT, f'PART{n:02d}'), 'wb').write(f)
        files.append((f'PART{n:02d}', f))
        assert len(data) <= 32768, f'part {n}: more than PART_MAX'
        assert len(f) <= 196608, f'part {n}: more than FILE_MAX'
        print(f'part{n:02d}: core {len(data):6} -> {len(packed):6}, pictures+speech {len(blob):7}, file {len(f):7}', flush=True)
    return files




# ===========================================================================
# engine tables (tables.i): font, sound, verbs, credits ...
# ===========================================================================
PAL_CLOCK = 3546895
PART_DISK = {}
SPEECH_LINES = [('YOU HAVE DIED.', 'rms', False), ('CONGRATULATIONS!', 'rms', False),
                ('WELCOME TO THE WORLD OF STRONKIE!', 'rms', True)]
SID_CLOCK = 985248
WAVE_LENS = [256, 128, 64, 32, 16, 8]


def tone(f):
    """frequency -> (period, length index): the longest waveform with a period >= 124"""
    for i, L in enumerate(WAVE_LENS):
        p = round(PAL_CLOCK / (f * L))
        if p >= 124:
            return min(p, 65535), i
    return 124, len(WAVE_LENS) - 1


def noise_period(f):
    return max(124, min(65535, round(PAL_CLOCK / (16 * f))))


def font_bytes():
    import re
    src = open('/home/claude/amiga/tools/font8x8/font8x8_basic.h').read()
    rows = re.findall(r'\{\s*((?:0x[0-9A-Fa-f]{2},?\s*){8})\}', src)
    F = [[int(x, 16) for x in re.findall(r'0x[0-9A-Fa-f]{2}', r)] for r in rows]
    rev = lambda b: int(f'{b:08b}'[::-1], 2)          # bit 0 is the left pixel in font8x8
    out = []
    for c in range(128):
        g = [rev(b) for b in F[c]]
        if c == 0x60:                                  # map: horizontal line
            g = [0, 0, 0, 0xff, 0, 0, 0, 0]
        elif c == 0x62:                                # map: vertical line
            g = [0x18] * 8
        elif c == 0x7f:                                # the cursor
            g = [0xff] * 8
        elif c == ord(','):                            # keep the comma inside rows 0-6
            g = [0, 0, 0, 0, 0x0c, 0x0c, 0x18, 0]
        out += g
    return out


def engine_tables():
    S = Src()
    S('; generated by build_amiga.py - do not edit')
    S('        even')
    S('c64pal                               ; the C64 colours (12 bit)')
    S.words(PAL12)
    # verbs and noise words: exactly the C64 tables
    src = open('/home/claude/adv/engine.asm').read()
    import re
    for label in ('noise', 'verbs'):
        tbl = src.split(f'\n{label} ')[1].split('.byte 0')[0]
        S(f'{label}')
        for word, num in re.findall(r'"(.{4})",\s*(\d+)', tbl):
            S(f'        dc.b "{word}",{num}')
        S('        dc.b 0')
    S('save_names                           ; SAVEn + one of these')
    for n in sorted(build.SAVE_NAMES):
        S(f'        dc.b "{build.SAVE_NAMES[n][5:]}",0')
    S('        dc.b 0')
    S.even()
    # keyboard
    normal = {0x00: '`', 0x0b: '-', 0x0c: '=', 0x0d: '\\', 0x1a: '[', 0x1b: ']', 0x29: ';', 0x2a: "'",
              0x38: ',', 0x39: '.', 0x3a: '/', 0x40: ' ', 0x0f: '0', 0x1d: '1', 0x1e: '2', 0x1f: '3',
              0x2d: '4', 0x2e: '5', 0x2f: '6', 0x3d: '7', 0x3e: '8', 0x3f: '9', 0x3c: '.', 0x4a: '-'}
    for i, c in enumerate('1234567890'):
        normal[1 + i] = c
    for i, c in enumerate('QWERTYUIOP'):
        normal[0x10 + i] = c
    for i, c in enumerate('ASDFGHJKL'):
        normal[0x20 + i] = c
    for i, c in enumerate('ZXCVBNM'):
        normal[0x31 + i] = c
    shift = dict(normal)
    for a, b in zip('1234567890-=;\',./', '!@#$%^&*()_+:"<>?'):
        for k, v in normal.items():
            if v == a and k < 0x0f:
                shift[k] = b
    for k in (0x29, 0x2a, 0x38, 0x39, 0x3a):
        shift[k] = {';': ':', "'": '"', ',': '<', '.': '>', '/': '?'}[normal[k]]
    special = {0x41: 8, 0x46: 8, 0x43: 13, 0x44: 13, 0x45: 27, 0x5f: 0x8f}
    for i in range(10):
        special[0x50 + i] = 0x81 + i
    for name, m in (('keymap', normal), ('keymap_sh', shift)):
        tbl = [0] * 128
        for k, v in m.items():
            tbl[k] = ord(v)
        for k, v in special.items():
            tbl[k] = v
        S(f'{name}                               ; raw key code -> character')
        S.bytes(tbl)
    # font
    S('font                                 ; 8x8, public domain (font8x8 by Daniel Hepper)')
    S.bytes(font_bytes(), 16)
    S.even()
    S('dbl_tab                              ; a byte with every pixel twice')
    S.words([int(''.join(b + b for b in f'{v:08b}'), 2) for v in range(256)])
    # sound
    S('note_tab                             ; notes 1-95: Paula period, waveform length index')
    nt = []
    nz = []
    for n in range(1, 96):
        f = 440 * 2 ** ((n + 11 - 69) / 12)
        p, i = tone(f)
        nt += [p, i]
        nz.append(noise_period(f))
    S.words(nt)
    S('noise_tab                            ; notes 1-95: noise period')
    S.words(nz)
    S('sfx_freq                             ; SID frequency high byte: period, length, noise period, 0')
    sf = []
    for fh in range(256):
        f = max(1.0, fh * 256 * SID_CLOCK / 2 ** 24)
        p, i = tone(f)
        sf += [p, i, noise_period(f), 0]
    S.words(sf)
    S('wave_off  dc.w 0,256,384,448,480,496')
    S('wave_len  dc.w 128,64,32,16,8,4')
    attack = [2, 8, 16, 24, 38, 56, 68, 80, 100, 250, 500, 800, 1000, 3000, 5000, 8000]
    decay = [6, 24, 48, 72, 114, 168, 204, 240, 300, 750, 1500, 2400, 3000, 9000, 15000, 24000]
    S('atk_tab                              ; SID attack times -> volume step a frame')
    S.words([max(1, min(0x4000, round(0x4000 * 20 / t))) for t in attack])
    S('dec_tab                              ; SID decay/release times -> step a frame')
    S.words([max(1, min(0x4000, round(0x4000 * 20 / t))) for t in decay])
    S('fib_tab                              ; Fibonacci delta steps (speech, sampled effects)')
    S('        dc.b ' + ','.join(str(v & 255) for v in SND.FIB))
    S('part_disk                            ; the disk every part is on (1-3)')
    S('        dc.b ' + ','.join(str(PART_DISK.get(n, 1)) for n in range(1, 18)))
    S.even()
    # end credits
    cred = list(sprites.CREDITS)
    i = cred.index('MENU MUSIC')
    cred[i:i + 5] = ['AMIGA 500 VERSION', '', 'COPPER, BLITTER, SPRITES', 'AND PAULA AT WORK', '', 'SPEECH: FLITE', '(CARNEGIE MELLON UNIVERSITY)', '']
    S('credit_text')
    for line in cred:
        S(f'        dc.b "{line}",0')
    S('        dc.b $ff')
    S.even()
    import math
    S('sine                                 ; 256 steps, 0-44')
    S.words([round(22 + 22 * math.sin(2 * math.pi * i / 256)) for i in range(256)])
    return S.source()


# ===========================================================================
# the title screen file (MENU)
# ===========================================================================
MENU_ART = '/mnt/user-data/attachments/af600111-0128-59b3-89d6-57733582f259/780d739a-image.jpg'
SCROLL_TEXT = (
    "WELCOME TO THE WORLD OF STRONKIE!     CREATED BY MARK STRONKS AKA STRONKIE  (C) 2026     "
    "NOW ON THE AMIGA 500: 81 PAINTED PICTURES IN 32 COLOURS, COPPER SKIES, SAMPLED SOUND AND SPEECH     "
    "PRESS N FOR A NEW GAME, L TO LOAD A SAVED GAME     "
    "17 PARTS, 92 LOCATIONS AND 16 STAR FRAGMENTS...  FIND THEM ALL FOR THE TRUE ENDING!     "
    "WATCH OUT FOR WOODEN MONKEYS, GHOST PIRATES AND COMMANDER VEX...     "
    "GREETINGS TO ALL AMIGA AND C64 FANS AND TO EVERY ADVENTURER WHO EVER TYPED  GET LAMP     "
    "......     ")

# the title music: an original tune, A minor, four voices (bass, lead, arpeggio, drums)
CHORDS = 'Am F C G Am F G E F G Am Am F G E E'.split()
ARP = {'Am': 'A3 C4 E4 A4', 'F': 'F3 A3 C4 F4', 'C': 'C4 E4 G4 C5', 'G': 'G3 B3 D4 G4', 'E': 'E3 G#3 B3 E4'}
ROOT = {'Am': 'A', 'F': 'F', 'C': 'C', 'G': 'G', 'E': 'E'}
LEAD = ('E5:4 D5:2 C5:2 B4:4 C5:4  A4:6 C5:2 F5:4 E5:4  G4:4 C5:4 E5:4 G5:4  F5:4 E5:2 D5:2 D5:8 '
        'E5:4 D5:2 C5:2 B4:4 A4:4  F4:4 A4:4 C5:4 F5:4  G5:6 F5:2 E5:4 D5:4  E5:8 G#4:4 B4:4 '
        'A5:4 G5:4 F5:4 C5:4  B4:4 D5:4 G5:4 F5:4  E5:6 C5:2 A4:8  R:8 A4:2 B4:2 C5:2 E5:2 '
        'F5:4 E5:4 C5:4 A4:4  G4:4 B4:4 D5:4 G5:4  G#5:8 E5:4 B4:4  E5:12 R:4')


def menu_song():
    unit = 6
    bass = ' '.join(' '.join([f'{ROOT[c]}2:2 {ROOT[c]}3:2'] * 4) for c in CHORDS)
    arp = ' '.join(' '.join(f'{n}:1' for n in ARP[c].split()) + ' ' +
                   ' '.join(f'{n}:1' for n in ARP[c].split()) * 0 for c in CHORDS)
    arp = ' '.join(' '.join([' '.join(f'{n}:1' for n in ARP[c].split())] * 4) for c in CHORDS)
    drums = ' '.join(['C1:2 C7:2 D4:2 C7:2 C1:2 C7:2 D4:2 C7:2'] * len(CHORDS))
    inst = [(music.SAW, 0x08, 0x00, 0), (music.PULSE, 0x29, 0x99, 8), (music.PULSE, 0x04, 0x00, 4),
            (music.NOISE, 0x05, 0x00, 0)]
    vs = []
    lens = []
    for v in (bass, LEAD, arp, drums):
        data, total = music.voice(v, unit)
        vs.append(data)
        lens.append(total)
    assert len(set(lens)) == 1, lens
    return inst, vs


def menu_picture():
    from PIL import Image
    im = Image.open(MENU_ART).convert('RGB')
    im = im.crop((192, 132, 1728, 924)).resize((320, 168), Image.LANCZOS)
    q = im.quantize(colors=16, method=Image.Quantize.MEDIANCUT, dither=Image.Dither.NONE)
    pal = q.getpalette()[:48]
    cols = [tuple(pal[i * 3:i * 3 + 3]) for i in range(16)]
    order = sorted(range(16), key=lambda i: sum(cols[i]))      # the darkest colour first (border)
    remap = {old: new for new, old in enumerate(order)}
    q = q.point(lambda v: remap.get(v, v))
    pal12 = [rgb12(cols[i]) for i in order]
    px = q.load()
    planes = bytearray()
    for y in range(168):
        for p in range(4):
            for bx in range(40):
                v = 0
                for i in range(8):
                    v = v << 1 | ((px[bx * 8 + i, y] >> p) & 1)
                planes.append(v)
    prev = q.convert('RGB')
    return pal12, bytes(planes), prev


def menu_source():
    S = Src()
    S(';' + '=' * 70)
    S(f';  THE WORLD OF STRONKIE {VERSION} (Amiga) - title screen file "MENU"')
    S(';  Created By Mark Stronks')
    S(';  vasm -Fbin -o menu.bin menu.s, packed with zxpack on the disk')
    S(';' + '=' * 70)
    S('base')
    S('        dc.b "MENU"')
    S('        dc.l pic-base,pal-base,song-base')
    cols, h = AS.columns('ship1')
    c1, c2, c3 = AS.COLOURS['ship']
    S(f'        dc.w ${c1:03x},${c2:03x},${c3:03x}   ; spaceship colours')
    S(f'        dc.w {h}                     ; its height')
    S('        dc.l scroll-base,ship0-base,ship1-base')
    pal, planes, prev = menu_picture()
    prev.save(os.path.join(OUT, 'menu_preview.png'))
    S('pal')
    S.words(pal)
    inst, vs = menu_song()
    emit_song(S, 'song', inst, vs)
    for i, f in enumerate(['ship1', 'ship2']):
        cols, h = AS.columns(f)
        S(f'ship{i}                             ; "{f}": 3 sprites, {h} lines')
        for p0, p1 in cols:
            S.words([w for pair in zip(p0, p1) for w in pair])
    S('scroll')
    S.text(SCROLL_TEXT.encode() + b'\0')
    S.even()
    S('pic                                  ; 320x168, 4 bitplanes, interleaved lines')
    S.bytes(planes)
    return S.source()


# ===========================================================================
# engine, disk
# ===========================================================================
def build_engine():
    open(os.path.join(HERE, 'tables.i'), 'w').write(engine_tables())
    exe = os.path.join(OUT, 'Stronkie')
    r = subprocess.run([VASM, '-quiet', '-Fhunkexe', '-kick1hunks', '-nosym', '-I', HERE, '-o', exe,
                        os.path.join(HERE, 'stronkie.s')], capture_output=True, text=True)
    if r.returncode:
        print(r.stdout[-6000:], r.stderr[-6000:])
        raise SystemExit('engine: vasm failed')
    # a version with symbols for the test harness
    r = subprocess.run([VASM, '-quiet', '-Fhunkexe', '-kick1hunks', '-I', HERE, '-o', exe + '.sym',
                        os.path.join(HERE, 'stronkie.s')], capture_output=True, text=True)
    print(f'engine: {os.path.getsize(exe)} bytes')
    return open(exe, 'rb').read()


def build_menu(cache):
    sp = os.path.join(OUT, 'menu.s')
    open(sp, 'w').write(menu_source())
    data = vasm_bin(sp, os.path.join(OUT, 'menu.bin'))
    packed = pack_file(data, cache)
    open(os.path.join(OUT, 'MENU'), 'wb').write(packed)
    print(f'menu: {len(data)} bytes -> packed {len(packed)}')
    assert len(data) <= 40000 and len(packed) <= 32768
    return packed


def build_sounds(cache):
    """SOUNDS: the sampled effects (1-13) and speech (14 died, 15 congratulations, 16 title),
    Fibonacci delta packed. .w count, per sound .l offset .w period .w samples, data"""
    import struct
    entries = []
    for name, x in SND.make_sfx().items():
        if len(x) % 2:
            x = x[:-1]
        entries.append((SND.period(SND.RATE), len(x), SND.fib_encode(x)))
    for text, voice, robot in SPEECH_LINES:
        b = speech_clip(text.capitalize(), cache, voice=voice, robot=robot)
        per, n = struct.unpack('>HH', b[:4])
        entries.append((per, n, b[4:4 + 1 + n // 2]))
    head = struct.pack('>H', len(entries))
    off = 2 + len(entries) * 8
    body = b''
    for per, n, data in entries:
        head += struct.pack('>LHH', off + len(body), per, n)
        body += data + (b'\0' if len(data) % 2 else b'')
    f = head + body
    open(os.path.join(OUT, 'SOUNDS'), 'wb').write(f)
    print(f'sounds: {len(f)} bytes, {sum(n for _, n, _ in entries)} samples when unpacked')
    return f


def make_adf(files, label, path):
    if os.path.exists(path):
        os.remove(path)
    env = dict(os.environ, PYTHONPATH='/home/claude/amiga/tools/amitools')
    xdf = ['python3', '/home/claude/amiga/tools/amitools/bin/xdftool', path]
    cmds = ['create', '+', 'format', label, 'ofs']
    if any(n == 'Stronkie' for n, _ in files):
        cmds += ['+', 'boot', 'install', '+', 'makedir', 's']
    for name, src in files:
        cmds += ['+', 'write', src, name]
    r = subprocess.run(xdf + cmds, capture_output=True, text=True, env=env)
    if r.returncode:
        print(r.stdout, r.stderr)
        raise SystemExit('xdftool failed')
    r = subprocess.run(xdf + ['info'], capture_output=True, text=True, env=env)
    print(path, r.stdout.strip().splitlines()[-3:])
    return path


DISK_BLOCKS = 1756 - 2          # 1760 minus boot blocks, root, bitmap; a little spare


def build_all():
    cache = os.path.join(HERE, '.cache')
    os.makedirs(cache, exist_ok=True)
    main()
    build_menu(cache)
    build_sounds(cache)
    ss = os.path.join(OUT, 'startup-sequence')
    open(ss, 'w').write('Stronkie\n')
    # disk 1: the program, title screen, sounds and the first parts; then disks 2 and 3
    def blocks(path):                    # OFS: 488 data bytes a block, a header per 72
        n = (os.path.getsize(path) + 487) // 488
        return n + 1 + (max(n - 1, 0)) // 72
    disks = [[('MENU', os.path.join(OUT, 'MENU')), ('SOUNDS', os.path.join(OUT, 'SOUNDS'))]]
    used = sum(blocks(f) for _, f in disks[0]) + 60 + 6     # the program, s/, startup-sequence
    for ch in CHAPTERS:
        n = ch['number']
        f = os.path.join(OUT, f'PART{n:02d}')
        if used + blocks(f) > DISK_BLOCKS:
            disks.append([])
            used = 0
        disks[-1].append((f'PART{n:02d}', f))
        used += blocks(f)
        PART_DISK[n] = len(disks)
    assert len(disks) <= 3, 'more than three disks'
    build_engine()
    disks[0] = [('Stronkie', os.path.join(OUT, 'Stronkie')), ('s/startup-sequence', ss)] + disks[0]
    out = []
    for i, files in enumerate(disks):
        label = 'Stronkie' if i == 0 else f'Stronkie{i + 1}'
        out.append(make_adf(files, label, os.path.join(OUT, f'The_World_of_Stronkie_Amiga_{VERSION}_Disk{i + 1}.adf')))
    print('parts per disk:', PART_DISK)
    return out


if __name__ == '__main__':
    if sys.argv[1:] == ['engine']:
        build_engine()
    elif sys.argv[1:] == ['menu']:
        build_menu(os.path.join(HERE, '.cache'))
    elif sys.argv[1:] == ['all']:
        build_all()
    else:
        main([int(a) for a in sys.argv[1:]] or None)
