;======================================================================
;  audio.s - Paula music and sound effects
;
;  The music data is the same as on the C64: per voice pairs of
;  (note, frames), note = MIDI-11, 0 = rest, $FE = loop start, $FF = loop.
;  The SID instruments (waveform, attack/decay, sustain/release, pulse_cols
;  width) become Paula waveforms (triangle, saw, 16 pulse_cols widths, noise)
;  with a software ADSR envelope on the volume, 50 times a second.
;  Channels 0-2 play the music, channel 3 the sound effects (the title
;  music uses all four).
;======================================================================

WAVE_SET = 504              ; one waveform in 6 lengths: 256,128,64,32,16,8
NOISE_LEN = 8192

; voice structure
VO_PTR   = 0                ; .l next (note, frames)
VO_START = 4                ; .l loop start
VO_DUR   = 8                ; .w frames left
VO_LEVEL = 10               ; .w envelope 0-$4000
VO_WAVE  = 12               ; .b SID waveform bits
VO_AD    = 13
VO_SR    = 14
VO_PW    = 15
VO_PHASE = 16               ; .b 0 off, 1 attack, 2 decay, 3 sustain, 4 release
VO_ON    = 17               ; .b voice in use
VO_SIZE  = 18

audio_init
        bsr     make_waves
        lea     CUSTOM,a5
        move.w  #$000f,DMACON(a5)
        move.w  #$00ff,$09e(a5)     ; ADKCON: no modulation
        lea     AUD0LC(a5),a0
        moveq   #3,d0
.ch     move.l  #silence,(a0)
        move.w  #2,4(a0)
        move.w  #400,6(a0)
        clr.w   8(a0)
        lea     $10(a0),a0
        dbf     d0,.ch
        move.w  #$800f,DMACON(a5)
        lea     voices,a0
        move.w  #4*VO_SIZE/2-1,d0
.cv     clr.w   (a0)+
        dbf     d0,.cv
        rts

audio_off
        lea     CUSTOM,a5
        clr.w   AUD0VOL(a5)
        clr.w   AUD0VOL+$10(a5)
        clr.w   AUD0VOL+$20(a5)
        clr.w   AUD0VOL+$30(a5)
        move.w  #$000f,DMACON(a5)
        rts

make_waves                          ; triangle, saw, 16 pulse_cols widths, noise
        lea     waves,a0
        moveq   #0,d7               ; waveform 0-17
.wv     moveq   #0,d6               ; length index 0-5 (256 ... 8)
.ln     moveq   #0,d5
        move.w  #256,d5
        lsr.w   d6,d5               ; length
        moveq   #0,d4               ; sample
.sm     move.w  d4,d0
        lsl.w   #8,d0
        divu    d5,d0               ; phase 0-255
        and.l   #$ffff,d0
        tst.w   d7
        bne   .1
        cmp.w   #128,d0             ; triangle
        bhs   .tdown
        add.w   d0,d0
        sub.w   #128,d0
        bra   .put
.tdown  add.w   d0,d0
        neg.w   d0
        add.w   #383,d0
        bra   .put
.1      cmp.w   #1,d7
        bne   .2
        sub.w   #128,d0             ; saw
        bra   .put
.2      move.w  d7,d1               ; pulse_cols: width (d7-2)/16
        subq.w  #2,d1
        lsl.w   #4,d1
        bne   .3
        moveq   #8,d1
.3      cmp.w   d1,d0
        blo   .hi
        move.w  #-100,d0
        bra   .put
.hi     moveq   #100,d0
.put    move.b  d0,(a0)+
        addq.w  #1,d4
        cmp.w   d5,d4
        bne   .sm
        addq.w  #1,d6
        cmp.w   #6,d6
        bne   .ln
        addq.w  #1,d7
        cmp.w   #18,d7
        bne   .wv
        lea     noise_wave,a0       ; noise: a 16 bit LFSR
        move.w  #NOISE_LEN-1,d0
        move.w  #$ace1,d1
.nz     move.w  d1,d2
        lsr.w   #1,d1
        btst    #0,d2
        beq   .n1
        eor.w   #$b400,d1
.n1     move.b  d1,(a0)+
        dbf     d0,.nz
        rts

;----------------------------------------------------------------------
music_start                         ; a0 = song (0 = none), a1 = file it belongs to
        tst.b   mus_user            ; music switched off with F5 / MUSIC
        bne   music_stop
music_force
        move.l  a0,d0
        beq   music_stop
        clr.b   mus_on
        move.l  a1,d6
        move.w  (a0)+,d5            ; voices
        lea     4(a0),a2
        move.w  d5,d0
        lsl.w   #2,d0
        lea     (a0,d0.w),a2        ; offsets of the voice data
        lea     voices,a1
        moveq   #0,d4
.v      move.b  (a0)+,VO_WAVE(a1)
        move.b  (a0)+,VO_AD(a1)
        move.b  (a0)+,VO_SR(a1)
        move.b  (a0)+,VO_PW(a1)
        move.l  (a2)+,d0
        add.l   d6,d0
        move.l  d0,VO_PTR(a1)
        move.l  d0,VO_START(a1)
        move.w  #1,VO_DUR(a1)
        clr.b   VO_PHASE(a1)
        move.b  #1,VO_ON(a1)
        lea     VO_SIZE(a1),a1
        addq.w  #1,d4
        cmp.w   d5,d4
        bne   .v
.off    cmp.w   #4,d4               ; the other voices off
        beq   .go
        clr.b   VO_ON(a1)
        clr.b   VO_PHASE(a1)
        lea     VO_SIZE(a1),a1
        addq.w  #1,d4
        bra   .off
.go     move.w  d5,mus_voices
        move.b  #1,mus_on
        rts

music_stop
        clr.b   mus_on
        lea     voices,a0
        moveq   #2,d0
.lp     move.b  #4,VO_PHASE(a0)     ; release
        lea     VO_SIZE(a0),a0
        dbf     d0,.lp
        tst.b   sfx_on
        bne   .x
        move.b  #4,VO_PHASE(a0)
.x      rts

;----------------------------------------------------------------------
sound_tick                          ; every frame (interrupt)
        lea     CUSTOM,a5
        tst.b   mus_on
        beq   .env
        lea     voices,a1
        lea     AUD0LC(a5),a4
        moveq   #0,d7
.mv     cmp.w   mus_voices,d7
        bhs   .env
        cmp.w   #3,d7               ; voice 4 (title music) gives way to effects
        bne   .free
        tst.b   sfx_on
        bne   .skip
.free   bsr     voice_tick
.skip   lea     VO_SIZE(a1),a1
        lea     $10(a4),a4
        addq.w  #1,d7
        bra   .mv
.env    tst.b   sfx_on              ; ---- sound effect on channel 3
        beq   .env2
        bsr     sfx_tick
.env2   lea     voices,a1           ; envelopes -> volumes
        lea     AUD0LC(a5),a4
        moveq   #3,d7
.ev     bsr     envelope
        lea     VO_SIZE(a1),a1
        lea     $10(a4),a4
        dbf     d7,.ev
        rts

voice_tick                          ; a1 = voice, a4 = Paula channel
        subq.w  #1,VO_DUR(a1)
        beq   .new
        cmp.w   #1,VO_DUR(a1)
        bne   .x
        move.b  #4,VO_PHASE(a1)     ; one frame before the next note: gate off
.x      rts
.new    move.l  VO_PTR(a1),a0
        moveq   #0,d0
        move.b  (a0)+,d0
        cmp.b   #$fe,d0             ; $FE: the loop starts after it
        bne   .nofe
        move.l  a0,VO_START(a1)
        move.b  (a0)+,d0
.nofe   cmp.b   #$ff,d0             ; end: loop
        bne   .note
        move.l  VO_START(a1),a0
        move.b  (a0)+,d0
.note   moveq   #0,d1
        move.b  (a0)+,d1
        move.w  d1,VO_DUR(a1)
        move.l  a0,VO_PTR(a1)
        tst.b   d0
        beq   .rest
        ; ---- note on: waveform and pitch, then the attack
        move.b  VO_WAVE(a1),d1
        move.b  VO_PW(a1),d2
        bsr     set_tone
        move.b  #1,VO_PHASE(a1)
        rts
.rest   move.b  #4,VO_PHASE(a1)
        rts

set_tone                            ; d0 = note 1-95, d1 = SID waveform, d2 = pulse_cols width, a4 = channel
        add.w   d0,d0
        add.w   d0,d0
        lea     note_tab-4,a0       ; per note: period, length index
        move.w  (a0,d0.w),d3
        move.w  2(a0,d0.w),d4
        btst    #7,d1
        bne   st_noise
set_wave                            ; d1 = waveform, d2 = pulse_cols, d3 = period, d4 = length index
        moveq   #0,d0
        btst    #4,d1               ; triangle
        bne   .w
        moveq   #1,d0
        btst    #5,d1               ; saw
        bne   .w
        moveq   #2,d0               ; pulse_cols
        and.w   #15,d2
        add.w   d2,d0
.w      mulu    #WAVE_SET,d0
        add.w   d4,d4
        lea     wave_off,a0
        add.w   (a0,d4.w),d0
        lea     waves,a0
        add.l   d0,a0
        move.l  a0,(a4)             ; AUDxLC
        lea     wave_len,a0
        move.w  (a0,d4.w),4(a4)     ; AUDxLEN (words)
        move.w  d3,6(a4)            ; AUDxPER
        rts
st_noise
        lea     noise_tab-2,a0
        lsr.w   #1,d0
        move.w  (a0,d0.w),d3
set_noise
        move.l  #noise_wave,(a4)
        move.w  #NOISE_LEN/2,4(a4)
        move.w  d3,6(a4)
        rts

envelope                            ; a1 = voice, a4 = channel: ADSR -> volume
        moveq   #0,d0
        move.b  VO_PHASE(a1),d0
        beq   .vol
        move.w  VO_LEVEL(a1),d1
        cmp.b   #1,d0
        bne   .d
        moveq   #0,d2               ; attack
        move.b  VO_AD(a1),d2
        lsr.w   #4,d2
        add.w   d2,d2
        lea     atk_tab,a0
        add.w   (a0,d2.w),d1
        cmp.w   #$4000,d1
        blo   .set
        move.w  #$4000,d1
        move.b  #2,VO_PHASE(a1)
        bra   .set
.d      cmp.b   #2,d0
        bne   .r
        bsr   .sus                ; decay
        moveq   #0,d2
        move.b  VO_AD(a1),d2
        and.w   #15,d2
        add.w   d2,d2
        lea     dec_tab,a0
        sub.w   (a0,d2.w),d1
        bcs   .tos
        cmp.w   d3,d1
        bhi   .set
.tos    move.w  d3,d1
        move.b  #3,VO_PHASE(a1)
        bra   .set
.r      cmp.b   #4,d0
        bne   .vol                ; sustain: no change
        moveq   #0,d2               ; release
        move.b  VO_SR(a1),d2
        and.w   #15,d2
        add.w   d2,d2
        lea     dec_tab,a0
        sub.w   (a0,d2.w),d1
        bhi   .set
        moveq   #0,d1
        clr.b   VO_PHASE(a1)
.set    move.w  d1,VO_LEVEL(a1)
.vol    move.w  VO_LEVEL(a1),d0
        lsr.w   #8,d0               ; 0-64
        tst.b   VO_PHASE(a1)
        bne   .v1
        tst.w   VO_LEVEL(a1)
        bne   .v1
        moveq   #0,d0
.v1     move.w  d0,8(a4)            ; AUDxVOL
        rts
.sus    moveq   #0,d3               ; d3 = sustain level
        move.b  VO_SR(a1),d3
        lsr.w   #4,d3
        mulu    #$4000/15,d3
        rts

;----------------------------------------------------------------------
play_sfx                            ; d0 = effect 1-13 (channel 3)
        movem.l d0-d4/a0-a1/a4-a5,-(sp)
        and.w   #$ff,d0
        subq.w  #1,d0
        add.w   d0,d0
        lea     sfx_offs,a0
        add.w   (a0,d0.w),a0
        lea     voices+3*VO_SIZE,a1
        move.b  (a0)+,VO_AD(a1)
        move.b  (a0)+,VO_SR(a1)
        move.l  a0,sfx_ptr
        clr.w   VO_LEVEL(a1)
        clr.b   VO_PHASE(a1)
        clr.b   sfx_gate
        move.b  #1,sfx_on
        movem.l (sp)+,d0-d4/a0-a1/a4-a5
        rts

sfx_tick                            ; one (frequency high, control) pair a frame
        lea     voices+3*VO_SIZE,a1
        lea     AUD0LC+$30(a5),a4
        move.l  sfx_ptr,a0
        moveq   #0,d0
        move.b  (a0)+,d0
        beq   .end
        moveq   #0,d1
        move.b  (a0)+,d1
        move.l  a0,sfx_ptr
        lsl.w   #3,d0
        btst    #7,d1
        bne   .noise
        lea     sfx_freq,a0         ; per frequency: period, length index, noise period
        move.w  (a0,d0.w),d3
        move.w  2(a0,d0.w),d4
        moveq   #8,d2
        bsr     set_wave
        bra   .gate
.noise  lea     sfx_freq,a0
        move.w  4(a0,d0.w),d3
        bsr     set_noise
.gate   btst    #0,d1
        beq   .goff
        tst.b   sfx_gate
        bne   .x
        move.b  #1,sfx_gate
        move.b  #1,VO_PHASE(a1)     ; gate on: attack
        rts
.goff   clr.b   sfx_gate
        move.b  #4,VO_PHASE(a1)
.x      rts
.end    clr.b   sfx_on              ; gate off
        move.b  #4,VO_PHASE(a1)
        rts
