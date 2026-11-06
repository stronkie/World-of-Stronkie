"""Render a harness dump (memory + custom registers) the way the Amiga would show it:
runs the copper list line by line, fetches the bitplanes, draws the sprites."""
import sys
from PIL import Image

COP1LC = 0x080


def render(path, out=None, first=0x1a, last=0x12d, scale=2):
    d = open(path, 'rb').read()
    mem = d[:0x200000]
    cr = d[0x200000:0x200200]
    reg = {i * 2: cr[i * 2] << 8 | cr[i * 2 + 1] for i in range(0x100)}
    w16 = lambda a: mem[a] << 8 | mem[a + 1]
    w32 = lambda a: w16(a) << 16 | w16(a + 2)
    cop = reg[COP1LC] << 16 | reg[COP1LC + 2]
    regs = dict(reg)
    # copper program as (line, moves) - executed up to each line
    prog = []
    pc = cop
    high = False
    cur_line = 0
    for _ in range(5000):
        a, b = w16(pc), w16(pc + 2)
        pc += 4
        if a == 0xffff and b == 0xfffe:
            break
        if a & 1:                                   # WAIT
            v = a >> 8
            if v == 0xff and (a & 0xfe) == 0xde:
                high = True
                cur_line = 255
                continue
            cur_line = v + (256 if high else 0)
            prog.append(('w', cur_line))
        else:
            prog.append(('m', a & 0x1fe, b))
    img = Image.new('RGB', (320, last - first))
    px = img.load()
    rgb = lambda c: ((c >> 8 & 15) * 17, (c >> 4 & 15) * 17, (c & 15) * 17)
    ptr = [0] * 6
    ip = 0
    lines = {}
    for line in range(0, last):
        # run the copper up to the next wait beyond this line
        while ip < len(prog):
            op = prog[ip]
            if op[0] == 'w':
                if op[1] > line:
                    break
                ip += 1
                continue
            r, v = op[1], op[2]
            regs[r] = v
            if 0xe0 <= r < 0xf8:                     # bitplane pointers
                k = (r - 0xe0) // 4
                if r & 2:
                    ptr[k] = (ptr[k] & 0xffff0000) | v
                else:
                    ptr[k] = (ptr[k] & 0xffff) | v << 16
            ip += 1
        con0 = regs.get(0x100, 0)
        bpu = con0 >> 12 & 7
        diw0 = regs.get(0x08e, 0x2c81) >> 8
        diw1 = (regs.get(0x090, 0x2cc1) >> 8) | (0 if (regs.get(0x090, 0) >> 15) & 1 else 0x100)
        pal = [regs.get(0x180 + i * 2, 0) for i in range(32)]
        if diw0 <= line < diw1 and bpu:
            row = [0] * 320
            for p in range(bpu):
                a = ptr[p]
                for bx in range(40):
                    byte = mem[(a + bx) & 0x1fffff]
                    for i in range(8):
                        if byte & (0x80 >> i):
                            row[bx * 8 + i] |= 1 << p
            for p in range(bpu):
                mod = regs.get(0x108 if p % 2 == 0 else 0x10a, 0)
                if mod & 0x8000:
                    mod -= 0x10000
                ptr[p] += 40 + mod
            lines[line] = [pal[c] for c in row]
        else:
            lines[line] = [pal[0]] * 320
        lines[line] = (lines[line], list(pal))
    # sprites (one use each)
    sprpt = [(regs.get(0x120 + i * 4, 0) << 16) | regs.get(0x122 + i * 4, 0) for i in range(8)]
    for i in range(8):
        a = sprpt[i]
        pos, ctl = w16(a), w16(a + 2)
        if pos == 0 and ctl == 0:
            continue
        vs = (pos >> 8) | ((ctl >> 2) & 1) << 8
        ve = (ctl >> 8) | ((ctl >> 1) & 1) << 8
        hs = (pos & 0xff) << 1 | (ctl & 1)
        x0 = hs - 0x80
        for y in range(vs, ve):
            da, db = w16(a + 4 + (y - vs) * 4), w16(a + 6 + (y - vs) * 4)
            if y not in lines:
                continue
            row, pal = lines[y]
            for k in range(16):
                v = (da >> (15 - k) & 1) | (db >> (15 - k) & 1) << 1
                if v and 0 <= x0 + k < 320:
                    row[x0 + k] = pal[16 + (i // 2) * 4 + v]
    for line in range(first, last):
        row, _ = lines[line]
        for x in range(320):
            px[x, line - first] = rgb(row[x])
    img = img.resize((320 * scale, (last - first) * scale), Image.NEAREST)
    if out:
        img.save(out)
    return img


if __name__ == '__main__':
    p = sys.argv[1]
    fs = len(sys.argv) > 3 and sys.argv[3] == 'fs'
    render(p, sys.argv[2], *( (0x2c, 0x12c) if fs else (0x1a, 0x12d) ))
