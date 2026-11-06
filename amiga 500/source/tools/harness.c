/*
 * Test harness for the Amiga version of THE WORLD OF STRONKIE.
 *
 * Runs the real game executable on the Musashi 68000 core with a tiny
 * stand-in for the Amiga OS (exec, dos and graphics calls are caught at
 * their jump table entries) and a simple blitter. Keys are typed into
 * the game's key buffer from a command file; everything the game prints
 * (putchar) is written to stdout. "#SHOT name" dumps memory + custom
 * registers for the screenshot renderer (render.py).
 *
 *   harness <Stronkie.sym> <data dir> <commands>
 *
 * Command file: a line = a command typed + RETURN; "!X" = the single key X
 * (menus, Y/N questions, save slots); "#SHOT name"; "#FRAMES n" = let n
 * frames pass; lines starting with "//" are comments.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "m68k.h"

#define MEMSIZE (16 * 1024 * 1024)
static uint8_t *mem;
static uint16_t custom[0x100];
static char datadir[512];

#define EXEC_BASE 0xF00000
#define DOS_BASE  0xF10000
#define GFX_BASE  0xF20000
#define EXIT_ADDR 0xEE0000
#define TASK_ADDR 0x000800
#define VBL_STUB  0x000400

/* ---------------------------------------------------------------- memory */
unsigned custom_read(unsigned r);
static unsigned rd8(unsigned a) { a &= 0xFFFFFF; if (a >= 0xDFF000 && a < 0xDFF200) { unsigned r = a & 0x1FE; unsigned v = custom_read(r); return (a & 1) ? v & 0xFF : v >> 8; } return mem[a]; }
static unsigned rd16(unsigned a) { a &= 0xFFFFFF; if (a >= 0xDFF000 && a < 0xDFF200) return custom_read(a & 0x1FE); return mem[a] << 8 | mem[a + 1]; }
static unsigned rd32(unsigned a) { return rd16(a) << 16 | rd16(a + 2); }
static void custom_write(unsigned r, unsigned v);
static void wr8(unsigned a, unsigned v) { a &= 0xFFFFFF; if (a >= 0xDFF000 && a < 0xDFF200) { custom_write(a & 0x1FE, (v & 0xFF) * 0x101); return; } mem[a] = v; }
static void wr16(unsigned a, unsigned v) { a &= 0xFFFFFF; if (a >= 0xDFF000 && a < 0xDFF200) { custom_write(a & 0x1FE, v & 0xFFFF); return; } mem[a] = v >> 8; mem[a + 1] = v; }
static void wr32(unsigned a, unsigned v) { wr16(a, v >> 16); wr16(a + 2, v & 0xFFFF); }

unsigned int m68k_read_memory_8(unsigned int a) { return rd8(a); }
unsigned int m68k_read_memory_16(unsigned int a) { return rd16(a); }
unsigned int m68k_read_memory_32(unsigned int a) { return rd32(a); }
unsigned int m68k_read_disassembler_8(unsigned int a) { return rd8(a); }
unsigned int m68k_read_disassembler_16(unsigned int a) { return rd16(a); }
unsigned int m68k_read_disassembler_32(unsigned int a) { return rd32(a); }
void m68k_write_memory_8(unsigned int a, unsigned int v) { wr8(a, v); }
void m68k_write_memory_16(unsigned int a, unsigned int v) { wr16(a, v); }
void m68k_write_memory_32(unsigned int a, unsigned int v) { wr32(a, v); }

/* ---------------------------------------------------------------- custom chips + blitter */
static long blits;
unsigned custom_read(unsigned r)
{
    switch (r) {
    case 0x002: return custom[0x096 / 2] & 0x03FF;      /* DMACONR: the blitter is never busy */
    case 0x004: return 0x8000;
    case 0x006: { static unsigned beam; beam += 0x100; return beam & 0xFF00; }   /* VHPOSR: the beam moves */
    default: return 0;
    }
}

static void do_blit(unsigned size)
{
    unsigned con0 = custom[0x040 / 2], con1 = custom[0x042 / 2];
    unsigned h = size >> 6, w = size & 63;
    if (!h) h = 1024;
    if (!w) w = 64;
    unsigned apt = custom[0x050 / 2] << 16 | custom[0x052 / 2];
    unsigned dpt = custom[0x054 / 2] << 16 | custom[0x056 / 2];
    int amod = (int16_t)custom[0x064 / 2], dmod = (int16_t)custom[0x066 / 2];
    unsigned minterm = con0 & 0xFF, usea = con0 & 0x0800;
    if (con1 & 2) { fprintf(stderr, "blitter: descending mode not emulated\n"); return; }
    if (con0 >> 12) { fprintf(stderr, "blitter: shift not emulated\n"); return; }
    for (unsigned y = 0; y < h; y++) {
        for (unsigned x = 0; x < w; x++) {
            unsigned a = usea ? rd16(apt) : custom[0x074 / 2];
            unsigned d = minterm == 0xF0 ? a : minterm == 0x00 ? 0 : minterm == 0xFF ? 0xFFFF : a;
            wr16(dpt, d);
            if (usea) apt += 2;
            dpt += 2;
        }
        if (usea) apt += amod;
        dpt += dmod;
    }
    blits++;
}

static void custom_write(unsigned r, unsigned v)
{
    if (r == 0x096) {               /* DMACON: set/clear */
        if (v & 0x8000) custom[r / 2] |= v & 0x7FFF; else custom[r / 2] &= ~v;
        return;
    }
    custom[r / 2] = v;
    if (r == 0x058) do_blit(v);
}

/* ---------------------------------------------------------------- program loading (hunks) */
static unsigned bump = 0x20000;
static unsigned alloc(unsigned n)
{
    unsigned a = (bump + 7) & ~7u;
    bump = a + n;
    if (bump > 0xC00000) { fprintf(stderr, "out of memory\n"); exit(1); }
    memset(mem + a, 0, n);
    return a;
}

typedef struct { char name[64]; unsigned addr; } Sym;
static Sym syms[4000];
static int nsyms;
static unsigned sym(const char *n)
{
    for (int i = 0; i < nsyms; i++) if (!strcmp(syms[i].name, n)) return syms[i].addr;
    fprintf(stderr, "no symbol %s\n", n);
    exit(1);
}

static unsigned load_hunks(const char *path)
{
    FILE *f = fopen(path, "rb");
    if (!f) { perror(path); exit(1); }
    fseek(f, 0, SEEK_END);
    long n = ftell(f);
    fseek(f, 0, SEEK_SET);
    uint8_t *b = malloc(n);
    fread(b, 1, n, f);
    fclose(f);
    long p = 0;
#define L() (p += 4, (unsigned)(b[p - 4] << 24 | b[p - 3] << 16 | b[p - 2] << 8 | b[p - 1]))
    if (L() != 0x3F3) { fprintf(stderr, "not a hunk file\n"); exit(1); }
    while (L()) ;
    unsigned nh = L(), first = L(), last = L();
    unsigned base[64];
    for (unsigned i = first; i <= last; i++) base[i] = alloc((L() & 0x3FFFFFFF) * 4 + 8);
    (void)nh;
    int h = first - 1;
    while (p < n) {
        unsigned t = L() & 0x3FFFFFFF;
        if (t == 0x3E9 || t == 0x3EA) { h++; unsigned sz = L() * 4; memcpy(mem + base[h], b + p, sz); p += sz; }
        else if (t == 0x3EB) { h++; L(); }
        else if (t == 0x3EC) {
            for (;;) {
                unsigned cnt = L(); if (!cnt) break;
                unsigned th = L();
                for (unsigned k = 0; k < cnt; k++) { unsigned off = L(); wr32(base[h] + off, rd32(base[h] + off) + base[th]); }
            }
        } else if (t == 0x3F0) {
            for (;;) {
                unsigned nl = L(); if (!nl) break;
                char nm[256] = {0};
                memcpy(nm, b + p, nl * 4); p += nl * 4;
                unsigned v = L();
                if (nsyms < 4000) { strncpy(syms[nsyms].name, nm, 63); syms[nsyms].addr = base[h] + v; nsyms++; }
            }
        } else if (t == 0x3F1) { unsigned sz = L(); p += sz * 4; }
        else if (t == 0x3F2) { }
        else { fprintf(stderr, "unknown hunk %x\n", t); exit(1); }
    }
    return base[first];
}

/* ---------------------------------------------------------------- the OS */
static unsigned vbl_code, vbl_data;
static FILE *files[16];
static long frames, instr;
static int in_irq;

static void readstr(unsigned a, char *out, int max)
{
    int i = 0;
    while (i < max - 1 && mem[a]) out[i++] = mem[a++];
    out[i] = 0;
}

static unsigned R(int r) { return m68k_get_reg(NULL, r); }
static void setD0(unsigned v) { m68k_set_reg(M68K_REG_D0, v); }

static void os_call(unsigned lib, int lvo)
{
    char name[300], path[900];
    if (lib == EXEC_BASE) {
        switch (lvo) {
        case -408: case -552:
            readstr(R(M68K_REG_A1), name, 100);
            setD0(!strcmp(name, "dos.library") ? DOS_BASE : !strcmp(name, "graphics.library") ? GFX_BASE : 0); return;
        case -294: setD0(TASK_ADDR); return;                    /* FindTask */
        case -198: setD0(alloc(R(M68K_REG_D0))); return;        /* AllocMem */
        case -216: setD0(0xC00000 - bump); return;              /* AvailMem */
        case -168: { unsigned is = R(M68K_REG_A1); vbl_code = rd32(is + 18); vbl_data = rd32(is + 14); setD0(0); return; }
        case -174: vbl_code = 0; return;
        case -330: setD0(16); return;                           /* AllocSignal */
        case -444: setD0(0); return;                            /* OpenDevice */
        case -456: setD0(0); return;                            /* DoIO */
        default: setD0(0); return;
        }
    }
    if (lib == DOS_BASE) {
        switch (lvo) {
        case -30: {                                             /* Open */
            readstr(R(M68K_REG_D1), name, 200);
            snprintf(path, sizeof path, "%s/%s", datadir, name);
            FILE *f = fopen(path, R(M68K_REG_D2) == 1006 ? "wb" : "rb");
            if (!f) { setD0(0); return; }
            for (int i = 1; i < 16; i++) if (!files[i]) { files[i] = f; setD0(i); fprintf(stderr, "  [dos] open %s\n", name); return; }
            fclose(f); setD0(0); return;
        }
        case -36: { unsigned h = R(M68K_REG_D1); if (h < 16 && files[h]) { fclose(files[h]); files[h] = 0; } setD0(1); return; }
        case -42: { unsigned h = R(M68K_REG_D1), buf = R(M68K_REG_D2), len = R(M68K_REG_D3);
            setD0(fread(mem + buf, 1, len, files[h])); return; }
        case -48: { unsigned h = R(M68K_REG_D1), buf = R(M68K_REG_D2), len = R(M68K_REG_D3);
            setD0(fwrite(mem + buf, 1, len, files[h])); return; }
        case -72: readstr(R(M68K_REG_D1), name, 200); snprintf(path, sizeof path, "%s/%s", datadir, name);
            setD0(remove(path) == 0 ? 1 : 0); return;
        default: setD0(0); return;
        }
    }
    setD0(0);                                                   /* graphics: nothing to do */
}

/* ---------------------------------------------------------------- keys and text */
static FILE *cmdf;
static long wait_until;
static char pending[256];
static int pending_pos = -1;
static int finished;
static unsigned a_get_key, a_input_line, a_input_end, a_putchar, a_more, a_key_buf, a_key_r, a_key_w;
static unsigned a_score, a_moves, a_room, a_chap;
static int col;

static void dump_shot(const char *name)
{
    char path[600];
    snprintf(path, sizeof path, "%s.bin", name);
    FILE *f = fopen(path, "wb");
    fwrite(mem, 1, 0x200000, f);
    uint8_t c[0x200];
    for (int i = 0; i < 0x100; i++) { c[i * 2] = custom[i] >> 8; c[i * 2 + 1] = custom[i]; }
    fwrite(c, 1, 0x200, f);
    fclose(f);
    printf("\n[shot %s]\n", name);
}

static void push_key(int k)
{
    unsigned w = rd16(a_key_w);
    mem[a_key_buf + w] = k;
    wr16(a_key_w, (w + 1) & 31);
}

static int next_line(void)
{
    for (;;) {
        if (!fgets(pending, sizeof pending, cmdf)) return 0;
        pending[strcspn(pending, "\r\n")] = 0;
        if (!strncmp(pending, "//", 2)) continue;
        if (!strncmp(pending, "#SHOT ", 6)) { dump_shot(pending + 6); continue; }
        if (!strncmp(pending, "#FRAMES ", 8)) { wait_until = frames + atol(pending + 8); return 2; }
        if (!strncmp(pending, "#FAST", 5)) { wr8(sym("fast_text"), 1); continue; }
        return 1;
    }
}

static int peek_ready, typing = -1, extra, cred_state;
static unsigned a_credits, a_do_map, a_card_hold;
static long card_at; static int card_shots;
static int keycode(const char *p)       /* "!X", "!F8" */
{
    if (p[1] == 'F' && p[2] >= '0' && p[2] <= '9') return 0x80 + atoi(p + 2);
    if (!strcmp(p + 1, "ESC")) return 27;
    return p[1];
}
static void feed_keys(unsigned ret)
{
    if (frames < wait_until) return;     /* #FRAMES: let time pass */
    if (ret >= a_credits && ret < a_do_map) {      /* the credits: let them roll, take a picture */
        if (cred_state == 0) { cred_state = 1; wait_until = frames + 700; return; }
        if (cred_state == 1) { cred_state = 2; dump_shot("shots/credits"); }
    }
    int input = ret >= a_input_line && ret < a_input_end;
    if (typing >= 0) {                     /* the rest of a long line, a few keys at a time */
        int n = 0;
        while (pending[typing] && n < 20) { push_key(pending[typing++]); n++; }
        if (!pending[typing]) { push_key(13); typing = -1; peek_ready = 0; }
        return;
    }
    if (!peek_ready) {
        int r = next_line();
        if (r == 2) return;
        if (!r) { if (++extra > 30) finished = 1; else push_key(' '); return; }
        peek_ready = 1;
    }
    if (input) {
        if (pending[0] == '!') { push_key(keycode(pending)); peek_ready = 0; return; }
        typing = 0;
        feed_keys(ret);
        return;
    }
    if (pending[0] == '!') { push_key(keycode(pending)); peek_ready = 0; return; }
    push_key(' ');                  /* -- MORE -- and other "press a key" */
}

static void out_char(int c)
{
    if (c == 13) { putchar('\n'); col = 0; return; }
    if (c < 0x20) return;
    if (c == 0x60) c = '-';
    if (c == 0x62) c = '|';
    putchar(c);
    if (++col >= 40) { putchar('\n'); col = 0; }
}

void hook(unsigned pc)
{
    instr++;
    if (pc >= 0xEF0000 && pc < 0xF30000) {
        unsigned lib = pc >= GFX_BASE - 0x8000 ? GFX_BASE : pc >= DOS_BASE - 0x8000 ? DOS_BASE : EXEC_BASE;
        os_call(lib, (int)pc - (int)lib);
        unsigned sp = R(M68K_REG_A7);
        m68k_set_reg(M68K_REG_PC, rd32(sp));
        m68k_set_reg(M68K_REG_A7, sp + 4);
        return;
    }
    if (pc == EXIT_ADDR) { finished = 2; m68k_end_timeslice(); return; }
    if (pc == VBL_STUB) { m68k_set_irq(0); in_irq = 1; }
    if (pc == VBL_STUB + 22) in_irq = 0;
    if (pc == a_putchar) out_char(R(M68K_REG_D0) & 0xFF);
    if (pc == a_card_hold && card_shots < 3) card_at = frames;
    if (card_at && frames >= card_at) { char nm[64]; sprintf(nm, "shots/card%d", ++card_shots); dump_shot(nm); card_at = 0; }
    if (pc == a_more) { printf("[MORE]"); }
    if (pc == a_get_key && rd16(a_key_r) == rd16(a_key_w)) {
        unsigned ret = rd32(R(M68K_REG_A7));
        if (!finished) feed_keys(ret);
        if (finished) m68k_end_timeslice();
    }
    if (vbl_code && !in_irq && instr % 20000 == 0) {
        frames++;
        wr32(VBL_STUB + 6, vbl_data);
        wr32(VBL_STUB + 12, vbl_code);
        m68k_set_irq(3);
    }
}

int main(int argc, char **argv)
{
    if (argc < 4) { fprintf(stderr, "harness exe datadir commands\n"); return 1; }
    mem = calloc(MEMSIZE, 1);
    strncpy(datadir, argv[2], sizeof datadir - 1);
    cmdf = fopen(argv[3], "r");
    unsigned entry = load_hunks(argv[1]);
    { FILE *sf = fopen("syms.txt", "w"); for (int i = 0; i < nsyms; i++) fprintf(sf, "%s %x\n", syms[i].name, syms[i].addr); fclose(sf); }
    a_get_key = sym("get_key"); a_input_line = sym("input_line"); a_input_end = sym("fkey");
    a_card_hold = sym("card_hold");
    a_credits = sym("credits"); a_do_map = sym("do_map");
    a_putchar = sym("putchar"); a_more = sym("more_prompt");
    a_key_buf = sym("key_buf"); a_key_r = sym("key_r"); a_key_w = sym("key_w");
    a_score = sym("score"); a_moves = sym("moves_cnt"); a_room = sym("room"); a_chap = sym("cur_chap");
    /* exec base at 4, the task, jump tables (rts), the VBL stub */
    wr32(4, EXEC_BASE);
    wr32(TASK_ADDR + 172, 1);       /* pr_CLI: started from the CLI */
    for (unsigned a = 0xEF0000; a < 0xF30000; a += 2) wr16(a, 0x4E75);
    static const uint16_t stub[] = { 0x48E7, 0xFFFE, 0x227C, 0, 0, 0x2A7C, 0, 0, 0x4E95, 0x4CDF, 0x7FFF, 0x4E73 };
    for (int i = 0; i < 12; i++) wr16(VBL_STUB + i * 2, stub[i]);
    wr32(0x6C, VBL_STUB);
    unsigned sp = 0xE00000;
    sp -= 4; wr32(sp, EXIT_ADDR);
    wr32(0, sp); wr32(4, EXEC_BASE);
    m68k_init();
    m68k_set_cpu_type(M68K_CPU_TYPE_68000);
    m68k_set_instr_hook_callback(hook);
    m68k_pulse_reset();
    m68k_set_reg(M68K_REG_SR, 0x2000);
    m68k_set_reg(M68K_REG_A7, sp);
    m68k_set_reg(M68K_REG_PC, entry);
    wr32(4, EXEC_BASE);
    long guard = 0;
    while (!finished) {
        m68k_execute(100000);
        if (++guard > 400000) { fprintf(stderr, "\n*** too long, PC=%06x\n", R(M68K_REG_PC)); break; }
    }
    fprintf(stderr, "\n[end: %s, frames %ld, blits %ld, score %d, moves %d, part %d, room %d]\n",
            finished == 2 ? "program exit" : "commands done", frames, blits, rd16(a_score), rd16(a_moves),
            mem[a_chap], mem[a_room]);
    return 0;
}
