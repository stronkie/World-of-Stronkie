;======================================================================
;  video.s - display, copper lists, text window, pictures, sprites,
;            title screen, title cards, end credits, keyboard
;======================================================================

PIC_TOP   = $24             ; first line of the room picture
TEXT_TOP  = $e5             ; first line of the text window
PIC_BYTES = 40*5*192        ; a picture: 5 bitplanes, interleaved lines
CACHE_SLOTS = 8
PART_MAX  = 32768             ; an unpacked part (texts, puzzles, music, sprites)
FILE_MAX  = 196608          ; a part file: packed part + pictures + speech
SPEECH_MAX = 28000         ; the longest spoken line (samples)
SAVE_MAX  = 512
FS_LINES  = 1500            ; full screen bitmap (title screen, cards, credits)
NACT      = 4
SPR_LINES = 84
SPR_BUF   = 4+SPR_LINES*4+4

; actor structure (run time)
AC_SLOT  = 0                ; first sprite
AC_NCOL  = 1                ; sprites (16 pixel columns)
AC_F0    = 2
AC_FN    = 3
AC_FC    = 4
AC_AD    = 5
AC_AC    = 6
AC_MD    = 7
AC_MC    = 8
AC_DX    = 9
AC_DY    = 10
AC_X     = 12               ; .w C64 sprite coordinates
AC_Y     = 14
AC_Y0    = 16
AC_H     = 18
AC_SIZE  = 20

;======================================================================
;  start-up and shut-down of the display
;======================================================================
video_on
        move.l  gfxbase,a6
        move.l  34(a6),old_view     ; gb_ActiView
        sub.l   a1,a1
        jsr     _LVOLoadView(a6)
        jsr     _LVOWaitTOF(a6)
        jsr     _LVOWaitTOF(a6)
        jsr     _LVOOwnBlitter(a6)
        jsr     _LVOWaitBlit(a6)
        move.l  mytask,a0
        move.l  184(a0),old_winptr  ; pr_WindowPtr: no DOS requesters
        move.l  #-1,184(a0)
        bsr     make_fadetab
        bsr     make_c2ptab
        bsr     make_game_copper
        lea     CUSTOM,a5
        move.w  DMACONR(a5),old_dma
        move.w  #$8000|$0200|$0100|$0080|$0040|$0020,DMACON(a5)   ; bitplanes, copper, blitter, sprites
        bsr     clear_sprites
        move.l  p_cop_game,a0
        bra     set_copper

video_off
        lea     CUSTOM,a5
        move.w  #$0020,DMACON(a5)   ; sprites off
        move.l  mytask,a0
        move.l  old_winptr,184(a0)
        move.l  gfxbase,a6
        move.l  38(a6),COP1LC(a5)   ; gb_copinit
        move.w  d0,COPJMP1(a5)
        move.w  old_dma,d0
        or.w    #$8000,d0
        move.w  d0,DMACON(a5)
        move.l  old_view,a1
        jsr     _LVOLoadView(a6)
        jsr     _LVOWaitTOF(a6)
        jsr     _LVOWaitBlit(a6)
        jsr     _LVODisownBlitter(a6)
        rts

set_copper                          ; a0 = copper list (from the next frame on)
        move.l  a0,cop_active
        lea     CUSTOM,a5
        move.l  a0,COP1LC(a5)
        rts

blit_wait
        tst.w   CUSTOM+DMACONR      ; (first read for old Agnus chips)
.w      btst    #6,CUSTOM+DMACONR
        bne   .w
        rts

idle_frame                          ; wait for the next frame, doing background work
        bsr     bg_step
wait_frame                          ; until the next vertical blank
        move.l  frames,d0
.w      cmp.l   frames,d0
        beq   .w
        rts

wait_frames                         ; d0 = frames
        subq.w  #1,d0
        bmi   .x
.lp     move.w  d0,-(sp)
        bsr     wait_frame
        move.w  (sp)+,d0
        dbf     d0,.lp
.x      rts

;======================================================================
;  vertical blank interrupt: music, sprites, colour cycling, fades
;======================================================================
vbl_on
        move.l  execbase,a6
        lea     vbl_int,a1
        move.b  #2,8(a1)            ; NT_INTERRUPT
        move.b  #10,9(a1)           ; priority
        move.l  #vbl_name,10(a1)
        move.l  #vbl_server,18(a1)
        moveq   #INTB_VERTB,d0
        jsr     _LVOAddIntServer(a6)
        rts

vbl_off
        move.l  execbase,a6
        lea     vbl_int,a1
        moveq   #INTB_VERTB,d0
        jsr     _LVORemIntServer(a6)
        rts

vbl_server
        movem.l d2-d7/a2-a6,-(sp)
        addq.l  #1,frames
        bsr     sound_tick
        tst.b   cop_mode
        bne   .fs
        tst.b   vbl_lock
        bne   .done
        bsr     cycle_tick
        bsr     flash_tick
        bsr     actors_tick
        tst.b   pal_dirty
        beq   .done
        clr.b   pal_dirty
        bsr     pic_copper          ; picture palette + sky -> copper list
        bra   .done
.fs     cmp.b   #2,cop_mode
        bne   .done
        bsr     menu_tick           ; title screen: bars, scroller, spaceship
.done   movem.l (sp)+,d2-d7/a2-a6
        lea     CUSTOM,a0           ; (Kickstart 1.x wants a0 = custom chips here)
        moveq   #0,d0               ; Z=1: the next server runs too
        rts

;======================================================================
;  keyboard: an input handler in front of Intuition takes all events
;======================================================================
input_on                            ; -> d0 = 0 on failure
        move.l  execbase,a6
        moveq   #-1,d0
        jsr     _LVOAllocSignal(a6)
        move.b  d0,in_port+15       ; mp_SigBit
        bmi   .fail
        lea     in_port,a0
        move.b  #4,8(a0)            ; NT_MSGPORT
        clr.b   14(a0)              ; PA_SIGNAL
        move.l  mytask,16(a0)
        lea     20(a0),a1           ; NewList
        move.l  a1,28(a0)
        addq.l  #4,a1
        clr.l   (a1)
        move.l  a1,20(a0)
        lea     in_req,a1
        move.b  #5,8(a1)            ; NT_MESSAGE
        move.l  #in_port,14(a1)     ; mn_ReplyPort
        move.w  #48,18(a1)
        lea     inputname,a0
        moveq   #0,d0
        moveq   #0,d1
        jsr     _LVOOpenDevice(a6)
        tst.l   d0
        bne   .fail
        lea     in_int,a0
        move.b  #2,8(a0)
        move.b  #100,9(a0)          ; before Intuition (50)
        move.l  #vbl_name,10(a0)
        move.l  #input_handler,18(a0)
        lea     in_req,a1
        move.w  #9,28(a1)           ; IND_ADDHANDLER
        move.l  #in_int,40(a1)
        jsr     _LVODoIO(a6)
        moveq   #1,d0
        rts
.fail   moveq   #0,d0
        rts

input_off
        move.l  execbase,a6
        lea     in_req,a1
        move.w  #10,28(a1)          ; IND_REMHANDLER
        move.l  #in_int,40(a1)
        jsr     _LVODoIO(a6)
        lea     in_req,a1
        jsr     _LVOCloseDevice(a6)
        moveq   #0,d0
        move.b  in_port+15,d0
        jsr     _LVOFreeSignal(a6)
        rts

input_handler                       ; a0 = event list -> d0 = events left (none)
        move.l  a0,d1
.lp     beq   .done
        move.l  d1,a0
        cmp.b   #1,4(a0)            ; IECLASS_RAWKEY
        bne   .nx
        move.w  6(a0),d0
        cmp.w   #$80,d0             ; key released
        bhs   .nx
        lea     keymap,a1
        move.w  8(a0),d1            ; qualifier: shift
        and.w   #3,d1
        beq   .ns
        lea     keymap_sh,a1
.ns     move.b  (a1,d0.w),d0
        beq   .nx
        bsr   push_key
.nx     move.l  (a0),d1
        bra   .lp
.done   moveq   #0,d0
        rts

push_key                            ; d0 = key into the ring buffer
        move.w  d1,-(sp)
        move.w  key_w,d1
        lea     key_buf,a1
        move.b  d0,(a1,d1.w)
        addq.w  #1,d1
        and.w   #31,d1
        cmp.w   key_r,d1
        beq   .full
        move.w  d1,key_w
.full   move.w  (sp)+,d1
        rts

get_key                             ; -> d0 = key, Z=1 if none
        moveq   #0,d0
        move.w  key_r,d1
        cmp.w   key_w,d1
        beq   .none
        lea     key_buf,a0
        move.b  (a0,d1.w),d0
        addq.w  #1,d1
        and.w   #31,d1
        move.w  d1,key_r
        tst.b   d0
.none   rts

flush_keys
        move.w  key_w,key_r
        rts

;======================================================================
;  the game screen copper list
;     $1a-$22 status bar (raster bar)   $24-$e3 room picture (sky per line)
;     $e5-$12c text window and input line
;======================================================================
CMOVE   macro                       ; register, value
        move.w  #\1,(a0)+
        move.w  \2,(a0)+
        endm
CWAIT   macro                       ; line (0-255)
        move.w  #((\1)<<8)|$07,(a0)+
        move.w  #$fffe,(a0)+
        endm

make_game_copper
        move.l  p_cop_game,a0
        CMOVE   DIWSTRT,#$1a81
        CMOVE   DIWSTOP,#$2dc1
        CMOVE   DDFSTRT,#$0038
        CMOVE   DDFSTOP,#$00d0
        CMOVE   BPLCON0,#$0200
        CMOVE   BPLCON1,#0
        CMOVE   BPLCON2,#$0024
        CMOVE   BPL1MOD,#120
        CMOVE   BPL2MOD,#120
        move.l  a0,cop_g_spr
        bsr     cop_sprites
        move.l  p_status_bm,d0       ; status bar: 4 bitplanes
        moveq   #4,d1
        move.l  #40,d2
        bsr     cop_planes
        bsr     cop_textpal
        lea     bar_cols,a1
        CMOVE   COLOR00,(a1)
        CWAIT   $1a
        CMOVE   BPLCON0,#$4200
        moveq   #1,d0
.bar    move.w  d0,d1
        add.w   #$1a,d1
        lsl.w   #8,d1
        or.w    #$07,d1
        move.w  d1,(a0)+
        move.w  #$fffe,(a0)+
        move.w  #COLOR00,(a0)+
        move.w  d0,d1
        add.w   d1,d1
        move.w  (a1,d1.w),(a0)+
        addq.w  #1,d0
        cmp.w   #9,d0
        bne   .bar
        CWAIT   $23
        CMOVE   BPLCON0,#$0200
        CMOVE   COLOR00,#$000
        CMOVE   BPL1MOD,#160
        CMOVE   BPL2MOD,#160
        move.l  p_pic_bm,d0          ; the picture: 5 bitplanes
        moveq   #5,d1
        moveq   #40,d2
        bsr     cop_planes
        move.l  a0,cop_g_pal        ; colour registers 1-31 of the picture
        moveq   #1,d0
.pal    move.w  d0,d1
        add.w   d1,d1
        add.w   #COLOR00,d1
        move.w  d1,(a0)+
        clr.w   (a0)+
        addq.w  #1,d0
        cmp.w   #32,d0
        bne   .pal
        CWAIT   PIC_TOP
        CMOVE   BPLCON0,#$5200
        move.l  a0,cop_g_c0         ; colour 0 of the picture
        CMOVE   COLOR00,#$000
        move.l  a0,cop_g_sky        ; colour 20 (the sky) on every line
        moveq   #0,d0
.sky    move.w  d0,d1
        add.w   #PIC_TOP,d1
        lsl.w   #8,d1
        or.w    #$07,d1
        move.w  d1,(a0)+
        move.w  #$fffe,(a0)+
        move.w  #COLOR00+40,(a0)+
        clr.w   (a0)+
        addq.w  #1,d0
        cmp.w   #192,d0
        bne   .sky
        CWAIT   $e4
        CMOVE   BPLCON0,#$0200
        move.l  a0,cop_g_flash
        CMOVE   COLOR00,#$000
        CMOVE   BPL1MOD,#120
        CMOVE   BPL2MOD,#120
        move.l  p_text_bm,d0
        moveq   #4,d1
        moveq   #40,d2
        bsr     cop_planes
        bsr     cop_textpal
        CWAIT   TEXT_TOP
        CMOVE   BPLCON0,#$4200
        move.l  #$fffffffe,(a0)+
        rts

cop_sprites                         ; a0 = copper: pointers of the 8 sprites
        move.l  p_spr_bufs,d0
        move.w  #SPR0PT,d1
        moveq   #7,d3
.lp     move.w  d1,(a0)+
        swap    d0
        move.w  d0,(a0)+
        swap    d0
        addq.w  #2,d1
        move.w  d1,(a0)+
        move.w  d0,(a0)+
        addq.w  #2,d1
        add.l   #SPR_BUF,d0
        dbf     d3,.lp
        rts

cop_planes                          ; d0 = bitmap, d1 = planes, d2 = bytes to the next plane
        move.w  #BPL1PT,d3
        subq.w  #1,d1
.lp     move.w  d3,(a0)+
        swap    d0
        move.w  d0,(a0)+
        swap    d0
        addq.w  #2,d3
        move.w  d3,(a0)+
        move.w  d0,(a0)+
        addq.w  #2,d3
        add.l   d2,d0
        dbf     d1,.lp
        rts

cop_textpal                         ; colours 1-15: the C64 colours
        lea     c64pal+2,a1
        move.w  #COLOR00+2,d0
        moveq   #14,d1
.lp     move.w  d0,(a0)+
        move.w  (a1)+,(a0)+
        addq.w  #2,d0
        dbf     d1,.lp
        rts

clear_sprites
        move.l  p_spr_bufs,a0
        move.w  #8*SPR_BUF/4-1,d0
.c      clr.l   (a0)+
        dbf     d0,.c
        rts

;======================================================================
;  the game screen
;======================================================================
game_screen
        clr.b   flash_n
        clr.b   menu_on
        bsr     actors_off
        bsr     clear_pic_area
        bsr     clear_text
        clr.b   cop_mode
        move.l  p_cop_game,a0
        bra     set_copper

clear_pic_area
        clr.l   pic_cur
        clr.w   ncyc
        clr.w   fade
        move.b  #1,pal_dirty
        move.l  p_pic_bm,a0
        move.w  #PIC_BYTES/16-1,d0
.c      clr.l   (a0)+
        clr.l   (a0)+
        clr.l   (a0)+
        clr.l   (a0)+
        dbf     d0,.c
        rts

clear_text
        move.l  p_text_bm,a0
        move.w  #72*160/4-1,d0
.c      clr.l   (a0)+
        dbf     d0,.c
        clr.b   out_col
        clr.b   more_cnt
        rts

;======================================================================
;  text output (always on the last line of the window, which scrolls up)
;======================================================================
print                               ; a0 = zero terminated text ($10-$1F = colour codes)
        move.l  a2,-(sp)
        move.l  a0,a2
        move.b  #DEFCOL,cur_col
.lp     move.b  (a2)+,d0
        beq   .done
        bsr   putchar
        bra   .lp
.done   move.l  (sp)+,a2
        rts

putchar                             ; d0 = character (preserves everything but d0/d1/a0/a1)
        cmp.b   #13,d0
        beq   newline
        cmp.b   #$20,d0
        bhs   .chr
        cmp.b   #$10,d0
        blo   .ret
        and.b   #$0f,d0             ; $10-$1F: change the text colour
        move.b  d0,cur_col
.ret    rts
.chr    movem.l d2-d4,-(sp)
        moveq   #0,d1
        move.b  out_col,d1
        move.l  p_text_bm,a0  ; the last text row
        add.l   #7*8*160,a0
        add.w   d1,a0
        moveq   #0,d2
        move.b  cur_col,d2
        moveq   #4,d3
        move.w  #160,d4
        bsr     glyph
        movem.l (sp)+,d2-d4
        addq.b  #1,out_col
        cmp.b   #40,out_col
        bhs   newline
        rts

newline
        clr.b   out_col
        bsr     scroll_text
        addq.b  #1,more_cnt
        cmp.b   #MORE_LINES,more_cnt
        blo   .done
        clr.b   more_cnt
        bsr     more_prompt
.done   rts

scroll_text                         ; the window moves_cnt up 8 lines, smoothly
        movem.l d2-d3,-(sp)
        moveq   #3,d3
        tst.b   fast_text
        beq   .lp
        moveq   #0,d3
.lp     moveq   #2,d2               ; lines per step
        tst.b   fast_text
        beq   .1
        moveq   #8,d2
        bra   .2
.1      bsr     wait_frame
.2      bsr     blit_wait
        lea     CUSTOM,a1
        move.l  #$09f00000,BLTCON0(a1)
        move.l  #-1,BLTAFWM(a1)
        move.w  d2,d0
        mulu    #160,d0
        move.l  p_text_bm,a0
        add.l   d0,a0
        move.l  a0,BLTAPT(a1)
        move.l  p_text_bm,BLTDPT(a1)
        clr.l   BLTAMOD(a1)         ; A and D modulo 0
        move.w  #64,d0
        sub.w   d2,d0
        lsl.w   #2,d0               ; 4 planes a line
        lsl.w   #6,d0
        or.w    #20,d0
        move.w  d0,BLTSIZE(a1)
        bsr     blit_wait
        move.l  #$01000000,BLTCON0(a1)   ; clear the new lines
        move.w  #64,d0
        sub.w   d2,d0
        mulu    #160,d0
        move.l  p_text_bm,a0
        add.l   d0,a0
        move.l  a0,BLTDPT(a1)
        move.w  d2,d0
        lsl.w   #2,d0
        lsl.w   #6,d0
        or.w    #20,d0
        move.w  d0,BLTSIZE(a1)
        bsr     blit_wait
        dbf     d3,.lp
        movem.l (sp)+,d2-d3
        rts

glyph                               ; a0 = destination, d0 = char, d2 = colour,
        movem.l d0-d7/a0-a1,-(sp)   ; d3 = bitplanes, d4 = bytes a line
        and.w   #$7f,d0
        lsl.w   #3,d0
        lea     font,a1
        add.w   d0,a1
        moveq   #7,d7
.ln     move.b  (a1)+,d0
        move.w  d2,d5
        moveq   #0,d6               ; plane offset
        move.w  d3,d1
        subq.w  #1,d1
.pl     lsr.w   #1,d5
        bcc   .zero
        move.b  d0,(a0,d6.w)
        bra   .np
.zero   clr.b   (a0,d6.w)
.np     add.w   #40,d6
        dbf     d1,.pl
        add.w   d4,a0
        dbf     d7,.ln
        movem.l (sp)+,d0-d7/a0-a1
        rts

glyph2                              ; the same, twice the size (16x16)
        movem.l d0-d7/a0-a2,-(sp)
        and.w   #$7f,d0
        lsl.w   #3,d0
        lea     font,a1
        add.w   d0,a1
        lea     dbl_tab,a2
        moveq   #7,d7
.ln     moveq   #0,d0
        move.b  (a1)+,d0
        add.w   d0,d0
        move.w  (a2,d0.w),d0        ; every pixel twice
        moveq   #1,d1               ; every line twice
.twice  move.w  d2,d5
        moveq   #0,d6
        move.w  d3,-(sp)
        subq.w  #1,d3
.pl     lsr.w   #1,d5
        bcc   .zero
        move.b  d0,1(a0,d6.w)
        ror.w   #8,d0
        move.b  d0,(a0,d6.w)
        ror.w   #8,d0
        bra   .np
.zero   clr.b   (a0,d6.w)
        clr.b   1(a0,d6.w)
.np     add.w   #40,d6
        dbf     d3,.pl
        move.w  (sp)+,d3
        add.w   d4,a0
        dbf     d1,.twice
        dbf     d7,.ln
        movem.l (sp)+,d0-d7/a0-a2
        rts

text_at                             ; a0 = bitmap position, a1 = text, d2 = colour,
        movem.l d0/a0-a2,-(sp)      ; d3 = planes, d4 = bytes a line, d5 = 1: double size
        move.l  a1,a2
.lp     move.b  (a2)+,d0
        beq   .done
        tst.b   d5
        bne   .big
        bsr     glyph
        addq.l  #1,a0
        bra   .lp
.big    bsr     glyph2
        addq.l  #2,a0
        bra   .lp
.done   movem.l (sp)+,d0/a0-a2
        rts

input_char                          ; d0 = character, d1 = column, d2 = colour (input line)
        movem.l d2-d4,-(sp)
        move.l  p_text_bm,a0
        add.l   #64*160,a0
        add.w   d1,a0
        moveq   #4,d3
        move.w  #160,d4
        bsr     glyph
        movem.l (sp)+,d2-d4
        rts

clear_input_row
        move.l  p_text_bm,a0
        add.l   #64*160,a0
        move.w  #8*160/4-1,d0
.c      clr.l   (a0)+
        dbf     d0,.c
        rts

more_prompt
        bsr     clear_input_row
        movem.l d2-d5,-(sp)
        move.l  p_text_bm,a0
        add.l   #64*160,a0
        lea     m_more,a1
        moveq   #INCOL,d2
        moveq   #4,d3
        move.w  #160,d4
        moveq   #0,d5
        bsr     text_at
        movem.l (sp)+,d2-d5
        bsr     wait_key
        bra     clear_input_row

; ---- status bar: part, star fragments, score, moves_cnt ---------------------
draw_status
        movem.l d2-d7/a2,-(sp)
        move.l  p_status_bm,a0
        move.w  #9*160/4-1,d0
.c      clr.l   (a0)+
        dbf     d0,.c
        lea     st_line,a2          ; build the 40 characters
        moveq   #39,d0
.sp     move.b  #' ',(a2,d0.w)
        dbf     d0,.sp
        GETP    H_SHORT,a0
        lea     1(a2),a1
        moveq   #9,d0
.nm     move.b  (a0)+,d1
        beq   .fr
        move.b  d1,(a1)+
        dbf     d0,.nm
.fr     move.b  #'*',12(a2)
        moveq   #0,d0
        move.b  frags,d0
        divu    #10,d0
        add.b   #'0',d0
        move.b  d0,13(a2)
        swap    d0
        add.b   #'0',d0
        move.b  d0,14(a2)
        move.b  #'/',15(a2)
        move.b  #'1',16(a2)
        move.b  #'6',17(a2)
        lea     19(a2),a1
        lea     m_st_score,a0
.s1     move.b  (a0)+,d0
        beq   .s2
        move.b  d0,(a1)+
        bra   .s1
.s2     move.w  score,d0
        bsr     to_digits
        lea     dig+1,a0
        move.b  (a0)+,(a1)+
        move.b  (a0)+,(a1)+
        move.b  (a0)+,(a1)+
        move.b  (a0)+,(a1)+
        lea     30(a2),a1
        lea     m_st_moves,a0
.m1     move.b  (a0)+,d0
        beq   .m2
        move.b  d0,(a1)+
        bra   .m1
.m2     move.w  moves_cnt,d0
        bsr     to_digits
        lea     dig+1,a0
        move.b  (a0)+,(a1)+
        move.b  (a0)+,(a1)+
        move.b  (a0)+,(a1)+
        move.b  (a0)+,(a1)+
        move.l  p_status_bm,a0        ; draw them, white
        moveq   #39,d7
        moveq   #1,d2
        moveq   #4,d3
        move.w  #160,d4
.dr     move.b  (a2)+,d0
        bsr     glyph
        addq.l  #1,a0
        dbf     d7,.dr
        movem.l (sp)+,d2-d7/a2
        rts

;======================================================================
;  pictures
;  a picture block (in the blob after the part): .w flags (1 = sky),
;  .w cycling registers, 32 colours, [192 sky colours], per cycling
;  register (.w register, speed, n, colours), .l packed length, then
;  320x192 pixels (register*4), packed
;======================================================================
pic_info                            ; a0 = picture block -> a1 = packed pixels, d0 = flags
        move.w  (a0),d0
        lea     4+64(a0),a1
        btst    #0,d0
        beq   .ns
        lea     192*2(a1),a1
.ns     move.w  2(a0),d1
        bra   .cf
.cl     move.w  4(a1),d2            ; register, speed, n, colours
        add.w   d2,d2
        lea     6(a1,d2.w),a1
.cf     dbf     d1,.cl
        addq.l  #4,a1
        rts

cache_reset                         ; a new part: the cache is empty
        lea     cache_key,a0
        moveq   #CACHE_SLOTS-1,d0
.cl     clr.l   (a0)+
        dbf     d0,.cl
        lea     cache_done,a0
        moveq   #CACHE_SLOTS-1,d0
.cd     clr.b   (a0)+
        dbf     d0,.cd
        clr.l   job_pic
        clr.w   cache_next
        rts

;----------------------------------------------------------------------
;  pictures are decoded a few lines at a time: in the background while
;  the game waits for a key, or at once when a picture is needed now
;----------------------------------------------------------------------
JOB_ROWS = 6                ; lines of bitplanes per slice

bg_step                             ; a little background work (keeps all registers)
        movem.l d0-d7/a0-a6,-(sp)
        tst.b   part_ok
        beq     .x
        tst.l   job_pic
        bne     .work
        lea     cache_key,a1        ; a free slot?
        moveq   #0,d1
.fs     tst.l   (a1)+
        beq     .free
        addq.w  #1,d1
        cmp.w   ncache,d1
        blo     .fs
        bra     .x
.free   moveq   #1,d7               ; a room picture that is not there yet
.rm     move.l  part,a0
        cmp.b   H_NROOM(a0),d7
        bhi     .x
        move.w  d1,-(sp)
        move.w  d7,d1
        bsr     room_ptr_d1
        move.w  (sp)+,d1
        move.l  4(a0),a0
        add.l   pic_blob,a0
        bsr     cache_slot_of
        bmi     .new
        addq.w  #1,d7
        bra     .rm
.new    bsr     job_start
.work   bsr     job_slice
.x      movem.l (sp)+,d0-d7/a0-a6
        rts

cache_slot_of                       ; a0 = picture -> d0 = slot, N=1 if not in the cache
        lea     cache_key,a1
        moveq   #0,d0
.lp     cmp.l   (a1)+,a0
        beq     .yes
        addq.w  #1,d0
        cmp.w   ncache,d0
        blo     .lp
        moveq   #-1,d0
        rts
.yes    tst.w   d0
        rts

job_start                           ; a0 = picture, d1 = slot: unpack the pixels
        movem.l d2-d7/a2-a6,-(sp)
        move.w  d1,d0
        lsl.w   #2,d0
        lea     cache_key,a1
        move.l  a0,(a1,d0.w)
        lea     cache_done,a1
        clr.b   (a1,d1.w)
        move.l  a0,job_pic
        move.w  d1,job_slot
        clr.w   job_row
        bsr     pic_info
        move.l  a1,a0
        move.l  chunky,a1
        bsr     unzx
        movem.l (sp)+,d2-d7/a2-a6
        rts

job_slice                           ; bitplanes for JOB_ROWS lines
        movem.l d2-d7/a2-a6,-(sp)
        move.w  job_row,d5
        moveq   #JOB_ROWS,d6
        move.w  #192,d0
        sub.w   d5,d0
        cmp.w   d0,d6
        bls     .1
        move.w  d0,d6
.1      move.w  d6,-(sp)
        move.w  d5,d0
        mulu    #320,d0
        move.l  chunky,a0
        add.l   d0,a0
        move.w  job_slot,d1
        lsl.w   #2,d1
        lea     cache_mem,a1
        move.l  (a1,d1.w),a1
        move.w  d5,d0
        mulu    #200,d0
        add.l   d0,a1
        move.w  d6,d7
        subq.w  #1,d7
        bsr     c2p_conv
        move.w  (sp)+,d6
        add.w   d6,job_row
        cmp.w   #192,job_row
        blo     .x
        move.w  job_slot,d1         ; finished
        lea     cache_done,a1
        move.b  #1,(a1,d1.w)
        clr.l   job_pic
.x      movem.l (sp)+,d2-d7/a2-a6
        rts

job_finish
.lp     tst.l   job_pic
        beq     .x
        bsr     job_slice
        bra     .lp
.x      rts

find_pic                            ; a0 = picture block -> a0 = bitplanes (decoded now if needed)
        movem.l d2-d7/a2-a4,-(sp)
        move.l  a0,a4
        bsr     job_finish          ; (the background job first)
        move.l  a4,a0
        bsr     cache_slot_of
        bpl     .have
        lea     cache_key,a1        ; a free slot, or the next one in turn
        moveq   #0,d1
.fs     tst.l   (a1)+
        beq     .use
        addq.w  #1,d1
        cmp.w   ncache,d1
        blo     .fs
        move.w  cache_next,d1
        move.w  d1,d0
        addq.w  #1,d0
        cmp.w   ncache,d0
        blo     .nx
        moveq   #0,d0
.nx     move.w  d0,cache_next
.use    move.l  a4,a0
        bsr     job_start
        bsr     job_finish
        move.l  a4,a0
        bsr     cache_slot_of
.have   lsl.w   #2,d0
        lea     cache_mem,a1
        move.l  (a1,d0.w),a0
        movem.l (sp)+,d2-d7/a2-a4
        rts

c2p_conv                            ; a0 = 320 wide pixels (value*4) -> a1 = 5 interleaved planes,
        lea     c2p_tab,a2          ; d7 = lines-1. planes 0-3: one bit in every byte of a long
        lea     c2p_tab4,a3         ; plane 4
        moveq   #0,d0
.y      moveq   #39,d6
.bx     moveq   #0,d1
        moveq   #0,d2
        rept    8
        move.b  (a0)+,d0
        add.l   d1,d1
        or.l    (a2,d0.w),d1
        add.b   d2,d2
        or.b    (a3,d0.w),d2
        endr
        move.b  d2,160(a1)
        move.b  d1,120(a1)
        lsr.l   #8,d1
        move.b  d1,80(a1)
        lsr.w   #8,d1
        move.b  d1,40(a1)
        swap    d1
        move.b  d1,(a1)+
        dbf     d6,.bx
        lea     160(a1),a1
        dbf     d7,.y
        rts

make_c2ptab                         ; value*4 -> plane bits
        lea     c2p_tab,a0
        lea     c2p_tab4,a1
        moveq   #0,d0
.lp     moveq   #0,d1
        btst    #0,d0
        beq   .1
        or.l    #$01000000,d1       ; plane 0 -> the top byte
.1      btst    #1,d0
        beq   .2
        or.l    #$00010000,d1
.2      btst    #2,d0
        beq   .3
        or.l    #$00000100,d1
.3      btst    #3,d0
        beq   .4
        or.l    #$00000001,d1
.4      move.w  d0,d2
        lsl.w   #2,d2
        move.l  d1,(a0,d2.w)
        moveq   #0,d1
        btst    #4,d0
        beq   .5
        moveq   #1,d1
.5      move.b  d1,(a1,d2.w)
        addq.w  #1,d0
        cmp.w   #32,d0
        bne   .lp
        rts

; ---- show a picture: fade out, copy, new colours, fade in ---------------
draw_picture                        ; a0 = picture block
        cmp.l   pic_cur,a0
        beq     .same
        movem.l d2-d7/a2-a4,-(sp)
        move.l  a0,a4
        bsr     find_pic
        move.l  a0,a3               ; the bitplanes
        tst.l   pic_cur
        beq   .nofade
        moveq   #-2,d0
        bsr     fade_to             ; old picture out
.nofade move.l  a4,pic_cur
        bsr     blit_wait
        lea     CUSTOM,a1
        move.l  #$09f00000,BLTCON0(a1)
        move.l  #-1,BLTAFWM(a1)
        move.l  a3,BLTAPT(a1)
        move.l  p_pic_bm,BLTDPT(a1)
        clr.l   BLTAMOD(a1)
        move.w  #(960<<6)|20,BLTSIZE(a1)
        move.l  a4,a0
        bsr     set_pic_colours
        bsr     gfx_room            ; sprites, visited
        bsr     blit_wait
        moveq   #2,d0
        bsr     fade_to             ; new picture in
        movem.l (sp)+,d2-d7/a2-a4
        rts
.same   bra     gfx_room_vis

fade_to                             ; d0 = -2: to black, 2: to full colour
        move.w  d0,d2
.lp     bsr     wait_frame
        move.w  fade,d1
        add.w   d2,d1
        bpl   .1
        moveq   #0,d1
.1      cmp.w   #16,d1
        bls   .2
        moveq   #16,d1
.2      move.w  d1,fade
        move.b  #1,pal_dirty
        tst.w   d1
        beq   .end
        cmp.w   #16,d1
        bne   .lp
.end    bra     wait_frame

set_pic_colours                     ; a0 = picture block: colours, sky, cycling registers
        movem.l d2/a2-a3,-(sp)
        move.b  #1,vbl_lock         ; (the interrupt reads these)
        lea     pic_pal,a1          ; the picture's own 32 colours
        lea     4(a0),a2
        moveq   #31,d0
.c      move.w  (a2)+,(a1)+
        dbf     d0,.c
        lea     sky,a1              ; the sky
        move.w  #191,d0
        btst    #0,1(a0)
        beq   .nosky
.s      move.w  (a2)+,(a1)+
        dbf     d0,.s
        bra   .cyc
.nosky  clr.w   (a1)+
        dbf     d0,.nosky
.cyc    move.w  2(a0),d0            ; colour cycling
        move.w  d0,ncyc
        lea     cyc_tab,a1
        lea     pic_pal,a3
        bra   .cf
.cl     move.w  (a2)+,d1            ; register
        move.w  d1,CY_REG(a1)
        move.w  (a2)+,d2            ; speed
        move.w  d2,CY_SPEED(a1)
        move.w  d2,CY_CNT(a1)
        move.w  (a2)+,d2            ; colours
        move.w  d2,CY_N(a1)
        clr.w   CY_IDX(a1)
        move.l  a2,CY_COLS(a1)
        add.w   d1,d1
        move.w  (a2),(a3,d1.w)      ; the first colour
        add.w   d2,d2
        add.w   d2,a2
        lea     CY_SIZE(a1),a1
.cf     dbf     d0,.cl
        clr.b   vbl_lock
        move.b  #1,pal_dirty
        movem.l (sp)+,d2/a2-a3
        rts

;----------------------------------------------------------------------
;  palette -> copper (from the interrupt when something changed)
;----------------------------------------------------------------------
pic_copper
        lea     fade_tab,a2         ; 16 levels x 16 values
        move.w  fade,d0
        lsl.w   #4,d0
        add.w   d0,a2
        tst.b   flash_on
        beq   .nf
        lea     fade_tab+17*16,a2   ; a flash: everything bright
.nf     move.w  pic_pal,d0          ; colour 0 (in the picture only)
        bsr   .fadec
        move.l  cop_g_c0,a1
        move.w  d0,2(a1)
        lea     pic_pal+2,a0
        move.l  cop_g_pal,a1
        addq.l  #2,a1
        moveq   #30,d7
.pal    move.w  (a0)+,d0
        bsr   .fadec
        move.w  d0,(a1)
        addq.l  #4,a1
        dbf     d7,.pal
        lea     sky,a0
        move.l  cop_g_sky,a1
        lea     6(a1),a1
        move.w  #191,d7
.sky    move.w  (a0)+,d0
        bsr   .fadec
        move.w  d0,(a1)
        addq.l  #8,a1
        dbf     d7,.sky
        rts
.fadec  move.w  d0,d1               ; d0 = $0RGB -> faded
        moveq   #0,d3
        and.w   #$f,d1
        move.b  (a2,d1.w),d3
        move.w  d0,d1
        lsr.w   #4,d1
        and.w   #$f,d1
        move.b  (a2,d1.w),d1
        lsl.w   #4,d1
        or.w    d1,d3
        lsr.w   #8,d0
        and.w   #$f,d0
        move.b  (a2,d0.w),d0
        lsl.w   #8,d0
        or.w    d3,d0
        rts

make_fadetab                        ; 17 levels (0-16) x 16 values; level 17 = flash
        lea     fade_tab,a0
        moveq   #0,d0               ; level
.lv     moveq   #0,d1               ; value
.vl     move.w  d1,d2
        mulu    d0,d2
        addq.w  #8,d2
        lsr.w   #4,d2
        move.b  d2,(a0)+
        addq.w  #1,d1
        cmp.w   #16,d1
        bne   .vl
        addq.w  #1,d0
        cmp.w   #17,d0
        bne   .lv
        moveq   #15,d1              ; the flash level: bright
.fl     move.b  #15,(a0)+
        dbf     d1,.fl
        rts

;----------------------------------------------------------------------
;  colour cycling and flashes (interrupt)
;----------------------------------------------------------------------
cycle_tick
        move.w  ncyc,d7
        beq   .x
        subq.w  #1,d7
        lea     cyc_tab,a0
        lea     pic_pal,a1
.lp     subq.w  #1,CY_CNT(a0)
        bgt   .nx
        move.w  CY_SPEED(a0),CY_CNT(a0)
        move.w  CY_IDX(a0),d0
        addq.w  #1,d0
        cmp.w   CY_N(a0),d0
        blo   .1
        moveq   #0,d0
.1      move.w  d0,CY_IDX(a0)
        add.w   d0,d0
        move.l  CY_COLS(a0),a2
        move.w  (a2,d0.w),d0
        move.w  CY_REG(a0),d1
        add.w   d1,d1
        move.w  d0,(a1,d1.w)
        move.b  #1,pal_dirty
.nx     lea     CY_SIZE(a0),a0
        dbf     d7,.lp
.x      rts

flash_tick
        tst.b   flash_n
        beq   .off
        subq.b  #1,flash_n
        move.b  flash_n,d0
        and.b   #2,d0
        sne     d0
        move.b  d0,flash_on
        move.b  #1,pal_dirty
        rts
.off    tst.b   flash_on
        beq   .x
        clr.b   flash_on
        move.b  #1,pal_dirty
.x      rts

;----------------------------------------------------------------------
;  sprites: the creatures and ships of the room
;----------------------------------------------------------------------
gfx_room                            ; after a new picture: visited, actors of this room
        bsr     gfx_room_vis
        bra     actors_setup
gfx_room_vis
        moveq   #0,d0
        move.b  room,d0
        subq.w  #1,d0
        bset    d0,visited
        rts

actors_off
        clr.w   act_n
        bra     clear_sprites

actors_setup                        ; from the part's actor list, for this room
        movem.l d2-d6/a2-a3,-(sp)
        move.b  #1,vbl_lock
        bsr     clear_sprites
        clr.w   act_n
        moveq   #0,d6               ; next free sprite
        GETP    H_ACTORS,a0
        lea     actors,a1
.lp     move.b  (a0),d0
        beq     .done
        cmp.b   room,d0
        bne     .nx
        cmp.w   #NACT,act_n
        bhs     .done
        moveq   #0,d1
        move.b  1(a0),d1            ; sprites
        move.w  d6,d2
        add.w   d1,d2
        cmp.w   #8,d2
        bhi     .done
        move.b  d6,AC_SLOT(a1)
        move.b  d1,AC_NCOL(a1)
        move.b  2(a0),AC_F0(a1)
        move.b  3(a0),AC_FN(a1)
        clr.b   AC_FC(a1)
        move.b  4(a0),AC_AD(a1)
        move.b  4(a0),AC_AC(a1)
        move.b  5(a0),AC_MD(a1)
        move.b  5(a0),AC_MC(a1)
        move.b  6(a0),AC_DX(a1)
        move.b  7(a0),AC_DY(a1)
        move.w  8(a0),AC_X(a1)
        move.w  10(a0),AC_Y(a1)
        move.w  10(a0),AC_Y0(a1)
        move.w  12(a0),AC_H(a1)
        ; colours for every sprite pair it uses
        move.w  d6,d3
        lsr.w   #1,d3               ; first pair
        move.w  d6,d4
        add.w   d1,d4
        subq.w  #1,d4
        lsr.w   #1,d4               ; last pair
        lea     pic_pal,a2
.cp     move.w  d3,d5
        lsl.w   #3,d5               ; pair * 4 registers * 2 bytes
        lea     34(a2,d5.w),a3      ; register 17 + 4*pair
        move.w  14(a0),(a3)+
        move.w  16(a0),(a3)+
        move.w  18(a0),(a3)+
        addq.w  #1,d3
        cmp.w   d4,d3
        bls   .cp
        addq.w  #1,d2               ; next actor starts on an even sprite
        and.w   #$fe,d2
        move.w  d2,d6
        lea     AC_SIZE(a1),a1
        addq.w  #1,act_n
.nx     lea     20(a0),a0
        bra     .lp
.done   clr.b   vbl_lock
        move.b  #1,pal_dirty
        movem.l (sp)+,d2-d6/a2-a3
        rts

actors_tick                         ; every frame: move, animate, build the sprites
        move.w  act_n,d7
        beq     .x
        tst.b   menu_on
        bne     .x
        subq.w  #1,d7
        lea     actors,a2
.lp     subq.b  #1,AC_AC(a2)        ; next image
        bne   .mv
        move.b  AC_AD(a2),AC_AC(a2)
        addq.b  #1,AC_FC(a2)
        move.b  AC_FC(a2),d0
        cmp.b   AC_FN(a2),d0
        blo   .mv
        clr.b   AC_FC(a2)
.mv     subq.b  #1,AC_MC(a2)        ; move
        bne   .put
        move.b  AC_MD(a2),AC_MC(a2)
        move.b  AC_DX(a2),d0
        ext.w   d0
        add.w   AC_X(a2),d0
        cmp.w   #352,d0             ; past the right border: back in on the left
        blt   .r1
        moveq   #0,d0
.r1     tst.w   d0
        bpl   .r2
        move.w  #352,d0             ; past the left border: back in on the right
.r2     move.w  d0,AC_X(a2)
        move.b  AC_DY(a2),d0        ; bob up and down
        beq   .put
        ext.w   d0
        add.w   AC_Y(a2),d0
        move.w  d0,AC_Y(a2)
        sub.w   AC_Y0(a2),d0
        bpl   .pos
        neg.w   d0
.pos    cmp.w   #5,d0
        blo   .put
        neg.b   AC_DY(a2)
.put    bsr     actor_sprites
        lea     AC_SIZE(a2),a2
        dbf     d7,.lp
.x      rts

actor_sprites                       ; a2 = actor: image -> its sprite buffers
        moveq   #0,d0
        move.b  AC_F0(a2),d0
        add.b   AC_FC(a2),d0
        lsl.w   #2,d0
        GETP    H_FRAMES,a0
        move.l  (a0,d0.w),a0
        add.l   part,a0             ; the image: per sprite column h x 2 words
        move.w  AC_X(a2),d2
        add.w   #$80-24,d2          ; sprite x
        move.w  AC_Y(a2),d3
        sub.w   #51,d3
        add.w   d3,d3
        add.w   #PIC_TOP,d3         ; first line
        move.w  d3,d4
        add.w   AC_H(a2),d4         ; last line + 1
        moveq   #0,d5
        move.b  AC_SLOT(a2),d5
        mulu    #SPR_BUF,d5
        move.l  p_spr_bufs,a1
        add.l   d5,a1
        moveq   #0,d6
        move.b  AC_NCOL(a2),d6
        subq.w  #1,d6
.col    move.l  a1,a3
        bsr     spr_ctl
        move.w  AC_H(a2),d0
        subq.w  #1,d0
.ln     move.l  (a0)+,(a3)+
        dbf     d0,.ln
        clr.l   (a3)
        add.w   #16,d2
        lea     SPR_BUF(a1),a1
        dbf     d6,.col
        rts

spr_ctl                             ; a3 = sprite, d2 = x, d3 = first line, d4 = last line+1
        move.w  d3,d0               ; -> two control words, a3 past them
        lsl.w   #8,d0
        move.w  d2,d1
        lsr.w   #1,d1
        move.b  d1,d0
        move.w  d0,(a3)+
        move.w  d4,d0
        lsl.w   #8,d0
        btst    #8,d3
        beq   .1
        bset    #2,d0
.1      btst    #8,d4
        beq   .2
        bset    #1,d0
.2      btst    #0,d2
        beq   .3
        bset    #0,d0
.3      move.w  d0,(a3)+
        rts

;======================================================================
;  full screen copper lists (title screen, title cards, credits):
;  per line a WAIT and two MOVEs whose values the program can change
;======================================================================
FS_TOP  = $2c

make_fs_copper                      ; a0 = list, d0 = bitmap, d1 = planes, d2 = line bytes,
        movem.l d2-d7/a2-a3,-(sp)   ; a1 = 32 colours, d3 = register A, d4 = register B
        move.l  a0,a3
        CMOVE   DIWSTRT,#$2c81
        CMOVE   DIWSTOP,#$2cc1
        CMOVE   DDFSTRT,#$0038
        CMOVE   DDFSTOP,#$00d0
        move.w  d1,d5
        ror.w   #4,d5
        or.w    #$0200,d5
        CMOVE   BPLCON0,d5
        CMOVE   BPLCON1,#0
        CMOVE   BPLCON2,#$0024
        move.w  d2,d5
        sub.w   #40,d5
        CMOVE   BPL1MOD,d5
        CMOVE   BPL2MOD,d5
        move.l  a0,fs_planes
        move.w  d3,-(sp)
        moveq   #40,d2
        bsr     cop_planes
        move.l  a0,fs_sprites
        bsr     cop_sprites
        move.w  (sp)+,d3
        move.w  #COLOR00,d5
        moveq   #31,d6
.pal    move.w  d5,(a0)+
        move.w  (a1)+,(a0)+
        addq.w  #2,d5
        dbf     d6,.pal
        move.l  a0,fs_lines
        moveq   #0,d6
.ln     move.w  d6,d5
        add.w   #FS_TOP,d5
        cmp.w   #$100,d5
        bne   .w
        move.l  #$ffdffffe,(a0)+    ; past line 255
.w      lsl.w   #8,d5
        or.w    #$07,d5
        move.w  d5,(a0)+
        move.w  #$fffe,(a0)+
        move.w  d3,(a0)+
        clr.w   (a0)+
        move.w  d4,(a0)+
        clr.w   (a0)+
        addq.w  #1,d6
        cmp.w   #256,d6
        bne   .ln
        move.l  #$fffffffe,(a0)+
        movem.l (sp)+,d2-d7/a2-a3
        rts

fs_line                             ; d0 = line 0-255 -> a0 = its copper entry (WAIT)
        move.l  fs_lines,a0
        move.w  d0,d1
        mulu    #12,d1
        add.l   d1,a0
        cmp.w   #$100-FS_TOP,d0
        blo   .x
        addq.l  #4,a0
.x      rts

fs_clear                            ; clear the full screen bitmap
        move.l  p_fs_bm,a0
        move.w  #FS_LINES*40/16-1,d0
.c      clr.l   (a0)+
        clr.l   (a0)+
        clr.l   (a0)+
        clr.l   (a0)+
        dbf     d0,.c
        rts

;======================================================================
;  title screen
;======================================================================
MENU_PIC_LINES = 168

show_menu
        bsr     actors_off
        clr.b   cop_mode
        tst.l   menu_data           ; loaded once, then kept in memory
        bne   .have
        bsr     blank_screen
        lea     menuname,a0
        move.l  filebuf,a1
        move.l  #FILE_MAX,d0
        bsr     disk_load
        tst.l   d0
        bmi     .fail
        move.l  filebuf,a0
        lea     menu_buf,a1
        bsr     unzx
        move.l  #menu_buf,menu_data
.have   bsr     fs_clear
        move.l  menu_data,a2
        ; the picture: 4 bitplanes into planes 0-3 of the 5 plane bitmap
        move.l  4(a2),a0
        add.l   a2,a0
        move.l  p_fs_bm,a1
        move.w  #MENU_PIC_LINES-1,d0
.pl     moveq   #160/4-1,d1
.pc     move.l  (a0)+,(a1)+
        dbf     d1,.pc
        lea     40(a1),a1
        dbf     d0,.pl
        ; menu texts in plane 4
        lea     menu_texts,a2
.tx     move.w  (a2)+,d0            ; line
        bmi   .txd
        move.w  (a2)+,d1            ; column
        mulu    #200,d0
        move.l  p_fs_bm,a0
        add.l   #160,a0
        add.l   d0,a0
        add.w   d1,a0
        move.l  a2,a1
        moveq   #1,d2
        moveq   #1,d3
        move.w  #200,d4
        moveq   #0,d5
        bsr     text_at
.skip   tst.b   (a2)+
        bne   .skip
        move.l  a2,d0
        addq.l  #1,d0
        and.w   #$fffe,d0
        move.l  d0,a2
        bra   .tx
.txd    ; colours: picture 0-15, text 16, spaceship 17-23
        move.l  menu_data,a2
        move.l  8(a2),a0
        add.l   a2,a0
        lea     fs_pal,a1
        moveq   #15,d0
.mp     move.w  (a0)+,(a1)+
        dbf     d0,.mp
        move.w  #$fff,(a1)+         ; 16 text
        move.w  16(a2),d0           ; 17-19 / 21-23 spaceship
        move.w  18(a2),d1
        move.w  20(a2),d2
        movem.w d0-d2,(a1)
        clr.w   6(a1)
        movem.w d0-d2,8(a1)
        lea     fs_pal+48,a1
        moveq   #7,d0
.z      clr.w   (a1)+
        dbf     d0,.z
        move.l  p_cop_fs,a0
        move.l  p_fs_bm,d0
        moveq   #5,d1
        move.w  #200,d2
        lea     fs_pal,a1
        move.w  #COLOR00,d3
        move.w  #COLOR00+32,d4      ; colour 16: the menu texts
        bsr     make_fs_copper
        ; the scroller: 1 bitplane from line SCR_Y on
        bsr     scroller_init
        move.l  p_cop_fs,a0
        bsr     set_copper
        move.b  #1,menu_on
        move.b  #2,cop_mode
        move.l  menu_data,a2
        move.l  12(a2),a0
        add.l   a2,a0
        move.l  a2,a1
        bsr     music_force         ; the title music (always)
        moveq   #SND_TITLE,d0       ; "Welcome to the World of Stronkie!"
        bra     speak_sound
.fail   clr.b   menu_on
        rts

blank_screen                        ; an empty display while loading
        bsr     fs_clear
        move.l  p_cop_fs,a0
        move.l  p_fs_bm,d0
        moveq   #1,d1
        moveq   #40,d2
        lea     zero_pal,a1
        move.w  #COLOR00,d3
        move.w  #COLOR00,d4
        bsr     make_fs_copper
        move.l  p_cop_fs,a0
        bra     set_copper

menu_wait                           ; -> d0 = 'N', 'L' or ESC
        bsr     flush_keys
.lp     bsr     idle_frame
        bsr     get_key
        beq   .lp
        cmp.b   #'L',d0
        beq   .key
        cmp.b   #'N',d0
        beq   .key
        cmp.b   #KEY_ESC,d0
        beq   .key
        cmp.b   #13,d0
        beq   .new
        cmp.b   #' ',d0
        bne   .lp
.new    moveq   #'N',d0
.key    move.b  d0,-(sp)
        clr.b   menu_on
        clr.b   cop_mode
        bsr     music_stop
        bsr     clear_sprites
        move.b  (sp)+,d0
        rts

SCR_Y   = 230                       ; scroller line

scroller_init
        move.l  p_scroll_bm,a0
        move.w  #16*48/4-1,d0
.c      clr.l   (a0)+
        dbf     d0,.c
        move.l  menu_data,a2
        move.l  24(a2),a0
        add.l   a2,a0
        move.l  a0,scroll_ptr
        move.l  a0,scroll_start
        clr.w   scroll_cnt
        clr.w   bar_phase
        clr.w   ship_x
        clr.w   ship_f
        ; split the screen: 1 bitplane for the scroller
        move.w  #SCR_Y-1,d0         ; blank line: modulo for the scroller
        bsr     fs_line
        move.w  #BPLCON0,4(a0)
        move.w  #$0200,6(a0)
        move.w  #BPL1MOD,8(a0)
        move.w  #8,10(a0)
        move.w  #SCR_Y,d0           ; its bitmap
        bsr     fs_line
        move.l  p_scroll_bm,d0
        move.w  #BPL1PT,4(a0)
        swap    d0
        move.w  d0,6(a0)
        swap    d0
        move.w  #BPL1PT+2,8(a0)
        move.w  d0,10(a0)
        move.w  #SCR_Y+1,d0         ; on
        bsr     fs_line
        move.w  #BPLCON0,4(a0)
        move.w  #$1200,6(a0)
        move.w  #COLOR00+2,8(a0)
        move.w  #SCR_Y+2,d7         ; register B = COLOR01 (the scroller colour)
.r      move.w  d7,d0
        bsr     fs_line
        move.w  #COLOR00+2,8(a0)
        addq.w  #1,d7
        cmp.w   #SCR_Y+17,d7
        bne   .r
        move.w  #SCR_Y+17,d0        ; off
        bsr     fs_line
        move.w  #BPLCON0,4(a0)
        move.w  #$0200,6(a0)
        moveq   #0,d7               ; the picture lines: colour 0 of the picture
.p      move.w  d7,d0
        bsr     fs_line
        move.w  fs_pal,6(a0)
        addq.w  #1,d7
        cmp.w   #MENU_PIC_LINES,d7
        bne   .p
        rts

menu_tick                           ; interrupt: bars, scroller, spaceship
        ; ---- three copper bars behind the menu texts
        addq.w  #3,bar_phase
        move.w  #MENU_PIC_LINES+2,d7
.cl     move.w  d7,d0
        bsr     fs_line
        clr.w   6(a0)
        addq.w  #1,d7
        cmp.w   #SCR_Y-1,d7
        bne   .cl
        lea     bar_grad,a3
        moveq   #2,d6
.bar    move.w  bar_phase,d0
        move.w  d6,d1
        mulu    #85,d1
        add.w   d1,d0
        and.w   #255,d0
        add.w   d0,d0
        lea     sine,a1
        move.w  (a1,d0.w),d0        ; 0-44
        add.w   #MENU_PIC_LINES+3,d0
        move.w  d6,d1
        mulu    #15*2,d1
        lea     (a3,d1.w),a4
        moveq   #14,d5
.bl     movem.w d0/d5,-(sp)
        bsr     fs_line
        move.w  (a4)+,6(a0)
        movem.w (sp)+,d0/d5
        addq.w  #1,d0
        dbf     d5,.bl
        dbf     d6,.bar
        ; ---- text colour pulse_cols
        move.w  frames+2,d0
        lsr.w   #2,d0
        and.w   #15,d0
        lea     pulse_cols,a1
        add.w   d0,d0
        move.w  (a1,d0.w),d2
        move.w  #MENU_PIC_LINES+2,d7
.tc     move.w  d7,d0
        bsr     fs_line
        move.w  d2,10(a0)
        addq.w  #1,d7
        cmp.w   #SCR_Y-1,d7
        bne   .tc
        ; ---- the scroller: 2 pixels a frame (by the CPU: the disk
        ;      driver may own the blitter while part 1 loads)
        move.l  p_scroll_bm,a0
        add.l   #16*48,a0
        moveq   #15,d6
.srow   moveq   #0,d1
        moveq   #23,d5
.sw     move.w  -(a0),d0
        move.w  d0,d2
        lsl.w   #2,d0
        or.w    d1,d0
        move.w  d0,(a0)
        rol.w   #2,d2
        and.w   #3,d2
        move.w  d2,d1
        dbf     d5,.sw
        dbf     d6,.srow
        addq.w  #1,scroll_cnt
        cmp.w   #8,scroll_cnt
        blo   .noch
        clr.w   scroll_cnt
        move.l  scroll_ptr,a0       ; a new letter at the right (off screen)
        move.b  (a0)+,d0
        bne   .ch
        move.l  scroll_start,a0
        move.b  (a0)+,d0
.ch     move.l  a0,scroll_ptr
        move.l  p_scroll_bm,a0
        add.l   #42,a0
        moveq   #1,d2
        moveq   #1,d3
        moveq   #48,d4
        bsr     glyph2
.noch   ; scroller colours: a gradient
        move.w  #SCR_Y+1,d7
        lea     scroll_grad,a3
.sc     move.w  d7,d0
        bsr     fs_line
        move.w  (a3)+,10(a0)
        addq.w  #1,d7
        cmp.w   #SCR_Y+17,d7
        bne   .sc
        ; ---- the spaceship flies past
        bsr     ship_tick
        rts

ship_tick
        move.l  menu_data,a2
        addq.w  #1,ship_x
        cmp.w   #480,ship_x
        blo   .1
        clr.w   ship_x
.1      move.w  frames+2,d0
        lsr.w   #2,d0
        and.w   #1,d0               ; two images
        lsl.w   #2,d0
        move.l  28(a2,d0.w),a0
        add.l   a2,a0
        move.w  ship_x,d2
        add.w   #$80-96,d2
        move.w  #FS_TOP+142,d3
        move.w  d3,d4
        add.w   22(a2),d4           ; height
        move.l  p_spr_bufs,a1
        moveq   #2,d6               ; three sprites wide
.col    move.l  a1,a3
        bsr     spr_ctl
        move.w  22(a2),d0
        subq.w  #1,d0
.ln     move.l  (a0)+,(a3)+
        dbf     d0,.ln
        clr.l   (a3)
        add.w   #16,d2
        lea     SPR_BUF(a1),a1
        dbf     d6,.col
        rts

;======================================================================
;  title card of the next part (shown while it loads)
;======================================================================
;  a copper gradient, the title twice the size, and a voice speaks it
show_card
        bsr     actors_off
        move.l  part,a2
        move.l  H_CARD(a2),d0
        beq     .none
        add.l   d0,a2               ; kind, name, spoken title
        bsr     fs_clear
        ; the texts, centred, twice the size
        move.l  (a2),a1
        add.l   part,a1
        moveq   #90,d0
        moveq   #7,d2               ; yellow
        bsr     .centre
        move.l  4(a2),a1
        add.l   part,a1
        moveq   #112,d0
        moveq   #1,d2               ; white
        bsr     .centre
        lea     m_cardload,a1
        move.l  p_fs_bm,a0
        add.l   #242*200+15,a0
        moveq   #15,d2
        moveq   #5,d3
        move.w  #200,d4
        moveq   #0,d5
        bsr     text_at
        ; colours: the C64 colours for the texts, no cycling
        move.b  #1,vbl_lock
        clr.w   ncyc
        lea     pic_pal,a1
        lea     c64pal,a0
        moveq   #15,d0
.c      move.w  (a0)+,(a1)+
        dbf     d0,.c
        moveq   #15,d0
.z      clr.w   (a1)+
        dbf     d0,.z
        clr.b   vbl_lock
        move.l  p_cop_fs,a0
        move.l  p_fs_bm,d0
        moveq   #5,d1
        move.w  #200,d2
        lea     pic_pal,a1
        move.w  #COLOR00,d3
        move.w  #COLOR00+40,d4
        bsr     make_fs_copper
        moveq   #0,d7               ; background: night blue -> purple -> black
.bg     move.w  d7,d0
        bsr     fs_line
        move.w  d7,d1
        sub.w   #110,d1
        bpl     .p
        neg.w   d1
.p      lsr.w   #4,d1               ; 0 in the middle .. 8 at the edges
        moveq   #8,d0
        sub.w   d1,d0
        bpl     .q
        moveq   #0,d0
.q      move.w  d0,d1               ; blue = d0, red = d0/2, a line of light behind the title
        lsr.w   #1,d1
        lsl.w   #8,d1
        or.w    d0,d1
        cmp.w   #110,d7
        bne     .r
        move.w  #$a8f,d1
.r      move.w  d1,6(a0)
        clr.w   10(a0)
        addq.w  #1,d7
        cmp.w   #256,d7
        bne   .bg
        move.b  #1,cop_mode
        move.l  p_cop_fs,a0
        bsr     set_copper
        move.b  #1,menu_on
        move.l  frames,card_t0
        move.l  8(a2),a0            ; "Chapter 2. The Derelict Station"
        add.l   pic_blob,a0
        bsr     speak_clip
.none   rts
.centre                             ; a1 = text, d0 = line, d2 = colour
        move.l  a1,a0
        moveq   #-1,d1
.len    addq.w  #1,d1
        tst.b   (a0)+
        bne   .len
        cmp.w   #20,d1
        bhi   .small
        neg.w   d1
        add.w   #20,d1              ; (20-len) bytes from the left
        mulu    #200,d0
        move.l  p_fs_bm,a0
        add.l   d0,a0
        add.w   d1,a0
        moveq   #5,d3
        move.w  #200,d4
        moveq   #1,d5
        bra     text_at
.small  neg.w   d1
        add.w   #40,d1
        lsr.w   #1,d1
        addq.w  #4,d0
        mulu    #200,d0
        move.l  p_fs_bm,a0
        add.l   d0,a0
        add.w   d1,a0
        moveq   #5,d3
        move.w  #200,d4
        moveq   #0,d5
        bra     text_at

card_hold                           ; keep the card up for at least 3 seconds
        tst.b   menu_on
        beq   .x
.lp     bsr     idle_frame
        move.l  frames,d0
        sub.l   card_t0,d0
        cmp.l   #150,d0
        blo   .lp
        clr.b   menu_on
.x      rts

loading_screen                      ; LOADING PART nn in the text window
        bsr     game_screen
        move.l  p_text_bm,a0
        add.l   #3*8*160+13,a0
        lea     m_loading,a1
        moveq   #1,d2
        moveq   #4,d3
        move.w  #160,d4
        moveq   #0,d5
        bra     text_at

disk_error_screen
        move.b  want_disk,d0        ; PLEASE INSERT DISK n
        add.b   #'0',d0
        move.b  d0,m_disknum
        bsr     game_screen
        move.l  p_text_bm,a0
        add.l   #2*8*160+1,a0
        lea     m_diskerr,a1
        moveq   #10,d2
        moveq   #4,d3
        move.w  #160,d4
        moveq   #0,d5
        bsr     text_at
        move.l  p_text_bm,a0
        add.l   #4*8*160+1,a0
        lea     m_diskerr2,a1
        moveq   #1,d2
        bra     text_at

;======================================================================
;  the end credits (after the very end of the game)
;======================================================================
CRED_PITCH = 18

credits
        move.l  part,a0
        tst.l   H_CARD(a0)          ; only after the last part
        bne     .x
        lea     m_credits,a0
        bsr     print
        bsr     wait_key
        bsr     actors_off
        bsr     fs_clear
        lea     credit_text,a2      ; the lines, twice the size, centred
        move.w  #256+8,d6           ; first line
.ln     tst.b   (a2)
        bmi   .done
        move.l  a2,a0
        moveq   #-1,d1
.len    addq.w  #1,d1
        tst.b   (a0)+
        bne   .len
        neg.w   d1
        add.w   #20,d1
        move.w  d6,d0
        mulu    #40,d0
        move.l  p_fs_bm,a0
        add.l   d0,a0
        add.w   d1,a0
        move.l  a2,a1
        moveq   #1,d2
        moveq   #1,d3
        moveq   #40,d4
        moveq   #1,d5
        bsr     text_at
.sk     tst.b   (a2)+
        bne   .sk
        add.w   #CRED_PITCH,d6
        bra   .ln
.done   move.w  d6,cred_end
        move.l  p_cop_fs,a0
        move.l  p_fs_bm,d0
        moveq   #1,d1
        moveq   #40,d2
        lea     zero_pal,a1
        move.w  #COLOR00,d3
        move.w  #COLOR00+2,d4
        bsr     make_fs_copper
        moveq   #0,d7               ; colour 1: fades in at the bottom, out at the top
.cl     move.w  d7,d0
        bsr     fs_line
        move.w  d7,d1
        cmp.w   #32,d1
        blo   .c1
        move.w  #255,d1
        sub.w   d7,d1
        cmp.w   #32,d1
        blo   .c1
        moveq   #31,d1
.c1     lsr.w   #1,d1
        lea     cred_grad,a1
        add.w   d1,d1
        move.w  (a1,d1.w),10(a0)
        move.w  d7,d1               ; a little blue at the bottom of the sky
        lsr.w   #5,d1
        move.w  d1,6(a0)
        addq.w  #1,d7
        cmp.w   #256,d7
        bne   .cl
        move.b  #1,cop_mode
        move.l  p_cop_fs,a0
        bsr     set_copper
        bsr     flush_keys
        moveq   #0,d7               ; scroll: one line a frame
.sc     bsr     wait_frame
        move.w  d7,d0
        mulu    #40,d0
        add.l  p_fs_bm,d0
        move.l  fs_planes,a0
        swap    d0
        move.w  d0,2(a0)
        swap    d0
        move.w  d0,6(a0)
        bsr     get_key
        bne   .end
        move.w  cred_end,d0
        sub.w   #13*CRED_PITCH+120,d0
        cmp.w   d0,d7
        bhs   .sc                 ; stopped: the last line in the middle
        addq.w  #1,d7
        bra   .sc
.end    clr.b   cop_mode
        bsr     game_screen
        bsr     draw_status
.x      rts

;======================================================================
;  the map of this part (MAP): your room yellow, rooms you know white
;======================================================================
do_map
        move.l  part,a0
        move.l  H_MAP(a0),d0
        bne   .start
        lea     m_nomap,a0
        bra     print
.start  movem.l d2-d7/a2,-(sp)
        lea     (a0,d0.l),a2
        moveq   #0,d6               ; label of a room (0 = none)
        moveq   #0,d5               ; its colour
.lp     moveq   #0,d0
        move.b  (a2)+,d0
        beq     .end
        cmp.b   #$0e,d0             ; end of a label
        bne   .2
        moveq   #0,d6
        moveq   #$1f,d0
        bra   .out
.2      cmp.b   #13,d0
        beq   .out
        cmp.b   #9,d0
        blo   .room
        cmp.b   #$81,d0
        blo   .chr
        cmp.b   #$89,d0
        bhs   .chr
.room   move.b  d0,d6               ; a label starts: room number (+$80: a secret room)
        and.w   #$0f,d0
        moveq   #$17,d5             ; yellow: you are here
        cmp.b   room,d0
        beq   .col
        subq.w  #1,d0
        moveq   #$11,d5             ; white: been there
        btst    d0,visited
        bne   .col
        moveq   #$1b,d5             ; dark grey: not yet
.col    move.b  d5,d0
        bsr     putchar
        bra   .lp
.chr    tst.b   d6                  ; inside the label of a room you don't know yet?
        beq   .out
        cmp.b   #$1b,d5
        bne   .out
        tst.b   d6
        bmi   .spc                ; a secret room: nothing at all
        cmp.b   #'A',d0
        blo   .out
        moveq   #'?',d0
        bra   .out
.spc    moveq   #' ',d0
.out    bsr     putchar
        bra   .lp
.end    moveq   #$1d,d0             ; back to the normal text colour
        bsr     putchar
        movem.l (sp)+,d2-d7/a2
        rts
