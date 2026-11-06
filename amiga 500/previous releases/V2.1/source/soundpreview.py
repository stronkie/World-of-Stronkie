"""Sound preview: the sampled effects and some of the speech, decoded from the game
files exactly as the Amiga does it (Fibonacci delta -> 8 bit), played at their Paula
rates. Writes sound_and_speech_preview.wav (22050 Hz, mono)."""
import os
import struct
import sys
import wave
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import amiga_sound as SND          # noqa: E402

PAL_CLOCK = 3546895
OUT_RATE = 22050


def decode(data, n):
    """the engine's fib_decode: a start value, then two 4-bit steps a byte"""
    out = np.zeros(n, np.float32)
    cur = data[0] - 256 if data[0] > 127 else data[0]
    for i in range(n // 2):
        b = data[1 + i]
        for k, nib in enumerate((b >> 4, b & 15)):
            cur = (cur + SND.FIB[nib] + 128) % 256 - 128      # 8 bit wrap, as add.b
            out[2 * i + k] = cur
    return out / 128


def resample(x, rate):
    t = np.arange(int(len(x) * OUT_RATE / rate)) * rate / OUT_RATE
    return np.interp(t, np.arange(len(x)), x)


def sounds(path):
    d = open(path, 'rb').read()
    n = struct.unpack('>H', d[:2])[0]
    out = []
    for i in range(n):
        off, per, cnt = struct.unpack('>LHH', d[2 + i * 8:10 + i * 8])
        out.append(resample(decode(d[off:], cnt), PAL_CLOCK / per))
    return out


def part_clips(path, how_many):
    """the spoken lines in a part file's blob: .w period, .w samples, data"""
    d = open(path, 'rb').read()
    blob = d[4 + struct.unpack('>L', d[:4])[0]:]
    out = []
    i = 0
    # the clips are found by scanning for a plausible header (period 590-720, samples < 28000)
    while i < len(blob) - 4 and len(out) < how_many:
        per, cnt = struct.unpack('>HH', blob[i:i + 4])
        if 560 <= per <= 720 and 3000 < cnt < 28000 and cnt % 2 == 0:
            out.append(resample(decode(blob[i + 4:], cnt), PAL_CLOCK / per))
            i += 4 + 1 + cnt // 2
        else:
            i += 2
    return out


def main(out_dir):
    gap = np.zeros(int(OUT_RATE * 0.5))
    sfx = sounds(os.path.join(out_dir, 'SOUNDS'))
    parts = [sfx[15], gap, sfx[13], gap, sfx[14], gap]            # welcome, died, congratulations
    for s in sfx[:13]:
        parts += [s, gap]
    for p in ('PART04', 'PART05'):
        for c in part_clips(os.path.join(out_dir, p), 3):
            parts += [c, gap]
    x = np.concatenate(parts)
    x = np.clip(x * 0.9, -1, 1)
    w = wave.open(os.path.join(out_dir, 'sound_and_speech_preview.wav'), 'wb')
    w.setnchannels(1)
    w.setsampwidth(2)
    w.setframerate(OUT_RATE)
    w.writeframes((x * 32000).astype('<i2').tobytes())
    w.close()
    print(f'{len(x) / OUT_RATE:.1f} seconds')


if __name__ == '__main__':
    main(sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, 'out'))
