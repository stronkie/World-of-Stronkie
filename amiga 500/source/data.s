;======================================================================
;  data.s - texts, tables, variables and chip memory buffers
;======================================================================

; ---- cycling register table (video.s) ----
CY_REG   = 0
CY_SPEED = 2
CY_CNT   = 4
CY_N     = 6
CY_IDX   = 8
CY_COLS  = 10
CY_SIZE  = 14

        section data,data

dosname   dc.b "dos.library",0
gfxname   dc.b "graphics.library",0
inputname dc.b "input.device",0
vbl_name  dc.b "Stronkie",0
menuname  dc.b "MENU",0
soundsname dc.b "SOUNDS",0
vol1      dc.b "Stronkie:",0
vol2      dc.b "Stronkie2:",0
vol3      dc.b "Stronkie3:",0
dirnames  dc.b "NSEWUD"
        even

; ---- messages (as on the C64; $10-$1F = colour, 13 = new line) ---------
m_banner  dc.b $17,"THE WORLD OF STRONKIE  V2.0",13
          dc.b $1f,"AMIGA 500 VERSION",13
          dc.b "CREATED BY MARK STRONKS",13
          dc.b "TYPE HELP FOR INSTRUCTIONS.",13,13,0
m_loading dc.b "LOADING... PLEASE WAIT",0
m_cardload dc.b "LOADING...",0
m_diskerr dc.b "CANNOT FIND THE NEXT PART OF THE GAME.",0
m_diskerr2 dc.b "PLEASE INSERT DISK "
m_disknum dc.b "1 AND PRESS A KEY.",0
m_more    dc.b "        -- PRESS A KEY FOR MORE --",0
m_huh     dc.b "I DON'T KNOW HOW TO ",0
m_word    dc.b "I DON'T KNOW THE WORD ",0
m_where   dc.b "WHICH WAY?",13,0
m_noway   dc.b "YOU CAN'T GO THAT WAY.",13,0
m_what    dc.b "PLEASE BE MORE SPECIFIC.",13,0
m_cant    dc.b "NOTHING HAPPENS.",13,0
m_notsee  dc.b "I DON'T SEE THAT HERE.",13,0
m_have    dc.b "YOU ALREADY HAVE IT.",13,0
m_cant_take dc.b "YOU CAN'T TAKE THAT.",13,0
m_taken   dc.b "TAKEN.",13,0
m_dropped dc.b "DROPPED.",13,0
m_donthave dc.b "YOU DON'T HAVE THAT.",13,0
m_carry   dc.b "YOU ARE CARRYING:",13,0
m_nothing2 dc.b "  NOTHING AT ALL.",13,0
m_nothing dc.b "YOU SEE NOTHING SPECIAL.",13,0
m_there   dc.b "THERE IS ",0
m_here    dc.b " HERE.",13,0
m_exits   dc.b "EXITS: ",0
m_none    dc.b "NONE",0
m_wait    dc.b "TIME PASSES...",13,0
m_score   dc.b $17,"YOUR SCORE IS ",0
m_sure    dc.b "QUIT THIS GAME (Y/N)?",13,0
m_ok      dc.b "OK.",13,0
m_dead    dc.b 13,$1a,"      *** YOU HAVE DIED ***",13,0
m_end     dc.b 13,$17,"      *** CONGRATULATIONS! ***",13,0
m_again   dc.b "PRESS A KEY TO PLAY AGAIN.",13,0
m_credits dc.b "PRESS A KEY FOR THE CREDITS.",0
m_quote_end dc.b "'.",13,0
m_nomap   dc.b "THERE IS NO MAP OF THIS PLACE.",13,0
m_again_w dc.b "AGAIN",0
m_norepeat dc.b "THERE IS NOTHING TO REPEAT.",13,0
m_colon   dc.b ": ",0
m_nothing_take dc.b "THERE IS NOTHING HERE TO TAKE.",13,0
m_hintcost dc.b $17,"(THAT HINT COST YOU 3 POINTS.)",13,0
m_nohint  dc.b "NO HINT FOR THIS. LOOK AROUND AND",13
          dc.b "EXAMINE EVERYTHING.",13,0
m_frag    dc.b $17,"YOU FOUND A STAR FRAGMENT! (",0
m_frag2   dc.b " OF 16)",13,0
m_frags   dc.b $17,"STAR FRAGMENTS FOUND: ",0
m_frag3   dc.b " OF 16.",13,0
m_saving  dc.b "SAVING THE GAME...",13,0
m_saved   dc.b $17,"GAME SAVED AS '",0
m_savefail dc.b "SAVE FAILED. IS THE DISK FULL OR",13
          dc.b "WRITE PROTECTED?",13,0
m_loadsave dc.b "LOADING THE SAVED GAME...",13,0
m_restored dc.b $17,"SAVED GAME RESTORED.",13,0
m_nosave  dc.b "THERE IS NO SAVED GAME ON THIS DISK.",13,0
m_retry   dc.b $11,"TRY THIS PART AGAIN (Y/N)?",13,0
m_slot    dc.b $17,"WHICH SLOT? PRESS 1, 2 OR 3: ",0
m_loadsure dc.b $11,"LOAD THE SAVED GAME? ALL PROGRESS IN",13
          dc.b "THIS GAME WILL BE LOST.",13
          dc.b "ARE YOU SURE (Y/N)?",13,0
m_musoff  dc.b "MUSIC OFF. (F5 TURNS IT BACK ON.)",13,0
m_muson   dc.b "MUSIC ON.",13,0
m_skip    dc.b "TEST KEY: ON TO THE NEXT PART!",13,0
m_st_score dc.b "SCORE ",0
m_st_moves dc.b "MOVES ",0

; ---- function keys: key, command, 0 ... 0 ------------------------------
fk_tab    dc.b KEY_F1,"LOAD",0
          dc.b KEY_F1+2,"SAVE",0
          dc.b KEY_F1+4,"MUSIC",0
          dc.b KEY_F1+6,"QUIT",0
          dc.b KEY_F1+7,"[SKIP",0
          dc.b KEY_HELP,"HELP",0
          dc.b 0

; ---- title screen texts: line, column, text ------------------------------
        even
menu_texts
          dc.w 178,8
          dc.b "PRESS  N  FOR A NEW GAME",0
          even
          dc.w 192,8
          dc.b "PRESS  L  TO LOAD A GAME",0
          even
          dc.w 206,4
          dc.b "PRESS ESC TO RETURN TO WORKBENCH",0
          even
          dc.w 220,11
          dc.b "AMIGA 500  V2.0",0
          even
          dc.w -1

; ---- colours -------------------------------------------------------------
bar_cols  dc.w $113,$225,$337,$449,$55b,$449,$337,$225,$113
bar_grad  dc.w $102,$204,$306,$408,$60a,$80c,$a2e,$c6f,$a2e,$80c,$60a,$408,$306,$204,$102
          dc.w $010,$020,$031,$042,$063,$084,$0a5,$2d7,$0a5,$084,$063,$042,$031,$020,$010
          dc.w $001,$002,$013,$024,$036,$048,$05a,$27d,$05a,$048,$036,$024,$013,$002,$001
pulse_cols     dc.w $fff,$eef,$ddf,$ccf,$bbf,$aaf,$99f,$88f,$88f,$99f,$aaf,$bbf,$ccf,$ddf,$eef,$fff
scroll_grad dc.w $f80,$f90,$fa0,$fb0,$fc1,$fd3,$fe5,$ff8,$ffb,$eff,$cef,$adf,$8cf,$6bf,$4af,$29f
cred_grad dc.w $000,$111,$222,$333,$444,$555,$666,$777,$888,$999,$aaa,$bbb,$ccc,$ddd,$eee,$fff
zero_pal  dcb.w 32,0

        include "tables.i"          ; generated: font, sound tables, verbs, credits ...

;======================================================================
        section vars,bss
;======================================================================
execbase  ds.l 1
dosbase   ds.l 1
gfxbase   ds.l 1
mytask    ds.l 1
wbmsg     ds.l 1
stack_save ds.l 1
part      ds.l 1
filebuf   ds.l 1
chunky    ds.l 1
packed_len ds.l 1
cache_mem ds.l CACHE_SLOTS
cache_key ds.l CACHE_SLOTS
ncache    ds.w 1
cache_next ds.w 1
old_view  ds.l 1
old_winptr ds.l 1
old_dma   ds.w 1
cop_active ds.l 1
cop_g_spr ds.l 1
cop_g_pal ds.l 1
cop_g_sky ds.l 1
cop_g_flash ds.l 1
fs_planes ds.l 1
fs_sprites ds.l 1
fs_lines  ds.l 1
frames    ds.l 1
pic_cur   ds.l 1
menu_data ds.l 1
scroll_ptr ds.l 1
scroll_start ds.l 1
card_t0   ds.l 1
sfx_ptr   ds.l 1
wordbuf   ds.l 1
score     ds.w 1
moves_cnt     ds.w 1
cp_score  ds.w 1
cp_moves  ds.w 1
all_i     ds.w 1
fade      ds.w 1
ncyc      ds.w 1
act_n     ds.w 1
key_r     ds.w 1
key_w     ds.w 1
mus_voices ds.w 1
scroll_cnt ds.w 1
bar_phase ds.w 1
ship_x    ds.w 1
ship_f    ds.w 1
cred_end  ds.w 1
pic_pal   ds.w 32
fs_pal    ds.w 32
sky       ds.w 192
cyc_tab   ds.b 16*CY_SIZE          ; up to 16 cycling registers a picture
actors    ds.b NACT*AC_SIZE
voices    ds.b 4*VO_SIZE
vbl_int   ds.b 22
in_int    ds.b 22
in_port   ds.b 34
in_req    ds.b 48
c2p_tab   ds.l 32
c2p_tab4  ds.b 128
fade_tab  ds.b 18*16
flags     ds.b 64
cp_flags  ds.b 64
inbuf     ds.b 40
lastbuf   ds.b 40
st_line   ds.b 40
key_buf   ds.b 32
dig       ds.b 6
savename  ds.b 40
fname     ds.b 32
savebuf   ds.b SAVE_MAX
cp_frags  ds.b 1
frags     ds.b 1
room      ds.b 1
verb      ds.b 1
noun      ds.b 1
nwords    ds.b 1
perr      ds.b 1
inpos     ds.b 1
wstart    ds.b 1
game_state ds.b 1
next_chap ds.b 1
cur_chap  ds.b 1
menu_on   ds.b 1
quit_game ds.b 1
choice    ds.b 1
more_cnt  ds.b 1
in_len    ds.b 1
out_col   ds.b 1
cur_col   ds.b 1
handled   ds.b 1
match_v   ds.b 1
need_look ds.b 1
cnt       ds.b 1
all_cnt   ds.b 1
slot      ds.b 1
mus_user  ds.b 1
mus_on    ds.b 1
sfx_on    ds.b 1
sfx_gate  ds.b 1
in_dos    ds.b 1
visited   ds.b 1
fast_text ds.b 1
cop_mode  ds.b 1
pal_dirty ds.b 1
vbl_lock  ds.b 1
flash_n   ds.b 1
flash_on  ds.b 1
packed_part ds.b 1
part_ok   ds.b 1
cache_done ds.b CACHE_SLOTS
        even
job_pic   ds.l 1
job_src   ds.l 1
job_slot  ds.w 1
job_row   ds.w 1
        even
cop_g_c0  ds.l 1
pic_blob  ds.l 1
fname_plain ds.l 1
save_short ds.l 1
speech_buf ds.l 1
snd_mem   ds.l 1
snd_mem_len ds.l 1
snd_tab   ds.b SND_COUNT*10
snd_count ds.w 1
smp_frames ds.w 1
smp_state ds.b 1
speech_on ds.b 1
want_disk ds.b 1
floppy    ds.b 1
        even
menu_buf  ds.b 40000

;======================================================================
        section chip,bss_c
;======================================================================
cop_game  ds.b 4096
cop_fs    ds.b 4096
pic_bm    ds.b PIC_BYTES
status_bm ds.b 9*160
text_bm   ds.b 72*160
fs_bm     ds.b FS_LINES*40
spr_bufs  ds.b 8*SPR_BUF
scroll_bm ds.b 16*48
waves     ds.b 18*WAVE_SET
noise_wave ds.b NOISE_LEN
silence   ds.l 1
