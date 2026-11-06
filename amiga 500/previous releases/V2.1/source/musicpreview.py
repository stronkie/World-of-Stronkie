"""Render the title music (and a part's song) to a WAV, mimicking the engine's Paula player."""
import sys, wave, struct, math
import numpy as np
sys.argv += []
import build_amiga as B
sys.path.insert(0, '/home/claude/adv')
import music

RATE = 28000
ATK = [2, 8, 16, 24, 38, 56, 68, 80, 100, 250, 500, 800, 1000, 3000, 5000, 8000]
DEC = [6, 24, 48, 72, 114, 168, 204, 240, 300, 750, 1500, 2400, 3000, 9000, 15000, 24000]


def render(inst, voices, seconds=32):
    frames = seconds * 50
    out = np.zeros(frames * RATE // 50)
    rng = np.random.default_rng(1)
    noise = rng.uniform(-1, 1, 8192)
    for (wave_, ad, sr, pw), data in zip(inst, voices):
        data = list(data) + [0xff]
        ptr, start, dur = 0, 0, 1
        level, phase, freq = 0.0, 0, 0.0
        acc = 0.0
        sustain = (sr >> 4) / 15
        for f in range(frames):
            dur -= 1
            if dur == 0:
                n = data[ptr]
                if n == 0xfe:
                    ptr += 1; start = ptr; n = data[ptr]
                if n == 0xff:
                    ptr = start; n = data[ptr]
                dur = data[ptr + 1]; ptr += 2
                if n:
                    freq = 440 * 2 ** ((n + 11 - 69) / 12); phase = 1
                else:
                    phase = 4
            elif dur == 1:
                phase = 4
            # envelope
            if phase == 1:
                level += 20 / ATK[ad >> 4]
                if level >= 1: level = 1; phase = 2
            elif phase == 2:
                level -= 20 / DEC[ad & 15]
                if level <= sustain: level = sustain; phase = 3
            elif phase == 4:
                level -= 20 / DEC[sr & 15]
                if level <= 0: level = 0; phase = 0
            n0 = f * RATE // 50; n1 = (f + 1) * RATE // 50
            t = acc + np.arange(n1 - n0) * freq / RATE
            acc = (acc + (n1 - n0) * freq / RATE) % 1.0
            ph = t % 1.0
            if wave_ & 0x80:
                idx = (t * 16).astype(int) % 8192
                s = noise[idx]
            elif wave_ & 0x10:
                s = np.where(ph < .5, ph * 4 - 1, 3 - ph * 4)
            elif wave_ & 0x20:
                s = ph * 2 - 1
            else:
                duty = (pw or 0.5) / 16
                s = np.where(ph < duty, .8, -.8)
            out[n0:n1] += s * level * 0.25
    return out


def save(path, out):
    out = np.clip(out, -1, 1)
    with wave.open(path, 'wb') as w:
        w.setnchannels(1); w.setsampwidth(2); w.setframerate(RATE)
        w.writeframes((out * 32000).astype('<i2').tobytes())


if __name__ == '__main__':
    inst, vs = B.menu_song()
    save('out/title_music_preview.wav', render(inst, vs, 34))
    print('ok')
