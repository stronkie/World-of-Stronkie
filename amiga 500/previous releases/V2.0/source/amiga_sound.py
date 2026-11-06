"""Sampled sound effects and speech for the Amiga version.

Effects are synthesised here (noise, FM, filters, envelopes) as 8-bit samples.
Speech is made with flite (CMU, BSD-style licence): NOVA, the ship computer, gets a
female voice with a little ring modulation; the title voice is male. Speech is stored
Fibonacci-delta packed (4 bits a sample, as in the Amiga's 8SVX format)."""
import os
import subprocess
import wave
import numpy as np

PAL = 3546895
FLITE = '/home/claude/amiga/tools/flite/bin/flite'
SFX_NAMES = ['click', 'take', 'drop', 'error', 'score', 'door', 'thunder', 'zap', 'launch', 'hyper', 'death', 'win', 'beep']
RATE = 7000


def env(n, a=0.005, d=None, rate=RATE):
    t = np.arange(n) / rate
    e = np.minimum(1, t / max(a, 1e-4))
    if d:
        e = e * np.exp(-t / d)
    return e


def lowpass(x, k):
    """simple one-pole low pass, k 0..1 (smaller = darker)"""
    y = np.zeros_like(x)
    kk = np.broadcast_to(np.asarray(k, float), x.shape)
    acc = 0.0
    for i, v in enumerate(x):
        acc += kk[i] * (v - acc)
        y[i] = acc
    return y


def tone(freq, n, kind='sine', rate=RATE, phase0=0.0):
    f = np.broadcast_to(np.asarray(freq, float), (n,))
    ph = np.cumsum(f / rate) + phase0
    if kind == 'sine':
        return np.sin(2 * np.pi * ph)
    if kind == 'square':
        return np.where((ph % 1) < 0.5, 1.0, -1.0)
    if kind == 'saw':
        return (ph % 1) * 2 - 1
    if kind == 'tri':
        return 1 - 4 * np.abs((ph % 1) - 0.5)


def make_sfx():
    rng = np.random.default_rng(1)
    S = {}
    n = int(RATE * 0.03)
    S['click'] = tone(1800, n, 'square') * env(n, 0.0005, 0.006) * 0.5
    n = int(RATE * 0.18)
    S['take'] = tone(np.linspace(500, 1400, n), n, 'tri') * env(n, 0.002, 0.08)
    S['drop'] = (tone(np.linspace(300, 70, n), n, 'sine') + 0.3 * lowpass(rng.uniform(-1, 1, n), 0.2)) * env(n, 0.001, 0.06)
    n = int(RATE * 0.35)
    S['error'] = tone(110, n, 'square') * 0.6 * (0.5 + 0.5 * tone(25, n, 'square')) * env(n, 0.002, 0.3)
    n = int(RATE * 0.6)
    t = np.arange(n) / RATE
    notes = np.select([t < 0.08, t < 0.16, t < 0.24], [1046, 1318, 1568], 2093)
    S['score'] = (tone(notes, n, 'sine') + 0.4 * tone(notes * 2, n, 'sine')) * env(n, 0.002, 0.3) * 0.7
    n = int(RATE * 1.1)
    t = np.arange(n) / RATE
    f = 180 + 60 * np.sin(t * 7) + 40 * np.sin(t * 23)
    creak = tone(f, n, 'saw') * (0.4 + 0.6 * (tone(28 + 10 * np.sin(t * 3), n, 'square') > 0))
    S['door'] = lowpass(creak, 0.35) * env(n, 0.05) * np.minimum(1, (1.1 - t) * 3) * 0.9
    n = int(RATE * 1.6)
    t = np.arange(n) / RATE
    noise = rng.uniform(-1, 1, n)
    crack = noise * np.exp(-t / 0.08)
    rumble = lowpass(noise, 0.03) * 6 * np.exp(-t / 0.9) * (1 + 0.5 * np.sin(t * 9))
    S['thunder'] = np.clip(crack * 0.8 + rumble, -1, 1)
    n = int(RATE * 0.45)
    t = np.arange(n) / RATE
    S['zap'] = tone(np.linspace(2600, 200, n) * (1 + 0.3 * tone(70, n, 'square')), n, 'square') * env(n, 0.001, 0.2) * 0.6
    n = int(RATE * 1.8)
    t = np.arange(n) / RATE
    roar = lowpass(rng.uniform(-1, 1, n), 0.05 + 0.15 * t / 1.8) * 5
    S['launch'] = np.clip(roar * np.minimum(1, t * 2) * np.minimum(1, (1.8 - t) * 2), -1, 1)
    n = int(RATE * 1.4)
    t = np.arange(n) / RATE
    sweep = tone(100 * 2 ** (t * 4), n, 'saw') + tone(101 * 2 ** (t * 4), n, 'saw')
    S['hyper'] = lowpass(sweep, 0.3) * env(n, 0.02) * np.minimum(1, (1.4 - t) * 4) * 0.7
    n = int(RATE * 1.6)
    t = np.arange(n) / RATE
    notes = np.select([t < 0.35, t < 0.7, t < 1.05], [392, 370, 349], 330)
    S['death'] = tone(notes * (1 + 0.01 * np.sin(t * 30)), n, 'tri') * env(n, 0.01) * np.minimum(1, (1.6 - t) * 3) * 0.8
    n = int(RATE * 1.8)
    t = np.arange(n) / RATE
    notes = np.select([t < 0.15, t < 0.3, t < 0.45], [523, 659, 784], 1046)
    S['win'] = (tone(notes, n, 'square') * 0.4 + tone(notes * 1.5, n, 'tri') * 0.4) * np.minimum(1, (1.8 - t) * 2) * env(n, 0.005)
    n = int(RATE * 0.5)
    t = np.arange(n) / RATE
    S['beep'] = tone(np.where((t * 8).astype(int) % 2, 1500, 1000), n, 'square') * 0.4 * env(n, 0.002)
    out = {}
    for k in SFX_NAMES:
        x = S[k]
        x = x / max(1e-6, np.abs(x).max()) * 0.95
        out[k] = np.round(x * 127).astype(np.int8)
    return out


# ---------------------------------------------------------------------------- speech
FIB = [-34, -21, -13, -8, -5, -3, -2, -1, 0, 1, 2, 3, 5, 8, 13, 21]


def fib_encode(s):
    """8-bit samples -> 4-bit Fibonacci delta (first byte: start value)"""
    out = bytearray([int(s[0]) & 255 if len(s) else 0])
    cur = int(s[0]) if len(s) else 0
    nib = []
    for v in s:
        best = min(range(16), key=lambda i: abs(cur + FIB[i] - int(v)) if -128 <= cur + FIB[i] <= 127 else 999)
        cur += FIB[best]
        nib.append(best)
    if len(nib) % 2:
        nib.append(8)
    for i in range(0, len(nib), 2):
        out.append(nib[i] << 4 | nib[i + 1])
    return bytes(out)


def fib_decode(b):
    cur = b[0] if b[0] < 128 else b[0] - 256
    out = []
    for x in b[1:]:
        for nib in (x >> 4, x & 15):
            cur += FIB[nib]
            out.append(cur)
    return np.array(out, np.int8)


def flite(text, voice='slt', path='/tmp/claude-0/speech.wav'):
    subprocess.run([FLITE, '-voice', voice, '-t', text, '-o', path], check=True, capture_output=True)
    w = wave.open(path)
    rate = w.getframerate()
    x = np.frombuffer(w.readframes(w.getnframes()), '<i2').astype(np.float32) / 32768
    return x, rate


def speech(text, voice='slt', rate=7000, robot=True, speed=1.0):
    x, r = flite(text, voice)
    # trim silence
    a = np.abs(x)
    idx = np.where(a > 0.02)[0]
    if len(idx):
        x = x[max(0, idx[0] - 50):idx[-1] + 200]
    if robot:
        t = np.arange(len(x)) / r
        x = x * (0.75 + 0.25 * np.sin(2 * np.pi * 50 * t))         # a little ring modulation
        x = x + 0.25 * np.concatenate([np.zeros(int(r * 0.012)), x[:-int(r * 0.012)]])   # metallic echo
    n = int(len(x) * rate / r / speed)
    xi = np.interp(np.linspace(0, len(x) - 1, n), np.arange(len(x)), x)
    xi = xi / max(1e-6, np.abs(xi).max()) * 0.9
    return np.round(xi * 120).astype(np.int8), rate


def quoted(msg):
    """the spoken part of a NOVA message: what is between the quotes"""
    msg = ''.join(ch if ch >= ' ' else ' ' for ch in msg)
    msg = ' '.join(msg.split())
    a = msg.find(": '")
    a = a + 2 if a >= 0 else msg.find("'")
    b = msg.rfind("'")
    if a < 0 or b <= a:
        return None
    s = msg[a + 1:b]
    return s.replace('PILOT', 'pilot').replace('STARRAVEN', 'Star Raven')


def period(rate):
    return round(PAL / rate)


if __name__ == '__main__':
    s = make_sfx()
    print({k: len(v) for k, v in s.items()}, sum(len(v) for v in s.values()))
    x, r = speech('All systems ready. Engage the hyperdrive in the cockpit.')
    e = fib_encode(x)
    print(len(x), len(e), np.abs(fib_decode(e).astype(int) - x.astype(int)).mean())
