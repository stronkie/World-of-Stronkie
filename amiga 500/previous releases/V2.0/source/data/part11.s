;======================================================================
;  THE WORLD OF STRONKIE V2.0 (Amiga) - CHAPTER 8: THE SKY TEMPLE
;  Created By Mark Stronks
;
;  Part file "PART11": vasm -Fbin -o part11.bin part11.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_TGATE       = $000000      ; picture "tgate" in the blob
PIC_STATUES     = $002852      ; picture "statues" in the blob
PIC_MIRRORS     = $00948e      ; picture "mirrors" in the blob
PIC_STARBRIDGE  = $00f7f6      ; picture "starbridge" in the blob
PIC_HEARTDOOR   = $014760      ; picture "heartdoor" in the blob

base
        dc.b "CHAP"
        dc.b 11,1,5,10       ; part, start room, rooms, objects
        dc.l rooms-base
        dc.l objects-base
        dc.l nouns-base
        dc.l actions-base
        dc.l messages-base
        dc.l t_intro-base
        dc.l song-base            ; music
        dc.l t_title-base
        dc.l t_short-base
        dc.l card-base            ; title card of the next part
        dc.l t_quip-base
        dc.l actors-base, frames-base
        dc.l map_data-base
        dc.l t_save-base
        dc.l 0            ; jingle (TUNE action)
        dc.b 7,4
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_TGATE
        dc.b 0,0,0,0,0,0,0,0      ; tgate
        dc.l d2-base,PIC_STATUES
        dc.b 0,1,3,0,0,0,0,0      ; statues
        dc.l d3-base,PIC_MIRRORS
        dc.b 0,0,0,2,0,0,0,0      ; mirrors
        dc.l d4-base,PIC_STARBRIDGE
        dc.b 0,3,0,0,0,0,0,0      ; starbridge
        dc.l d5-base,PIC_HEARTDOOR
        dc.b 0,4,0,0,0,0,0,0      ; heartdoor
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,255,1,0
        dc.l t0-base,t1-base
        dc.b 2,1,2,0
        dc.l t2-base,t3-base
        dc.b 3,2,2,0
        dc.l t2-base,t4-base
        dc.b 4,2,1,0
        dc.l t5-base,t6-base
        dc.b 5,2,2,0
        dc.l t2-base,t7-base
        dc.b 5,0,1,0
        dc.l t8-base,t9-base
        dc.b 6,3,2,0
        dc.l t2-base,t10-base
        dc.b 7,3,2,0
        dc.l t2-base,t11-base
        dc.b 8,4,2,0
        dc.l t2-base,t12-base
        dc.b 7,5,2,0
        dc.l t2-base,t13-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "AMUL",1
        dc.b "GATE",2
        dc.b "HOLL",2
        dc.b "STAT",3
        dc.b "MIRR",4
        dc.b "DUST",5
        dc.b "FLOO",5
        dc.b "STAN",6
        dc.b "BEAM",6
        dc.b "SUNL",6
        dc.b "LIGH",6
        dc.b "DOOR",7
        dc.b "EYE ",7
        dc.b "VOID",8
        dc.b "DROP",8
        dc.b "STAR",8
        dc.b "BRID",8
        dc.b "SYMB",7
        dc.b "LAMP",9
        dc.b "FORC",10
        dc.b "MARK",11
        dc.b "SPOT",11
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $16,$00,$08,$04,$02,$20,$01,$00
        dc.b $0c,$0b,$08,$04,$02,$20,$02,$00
        dc.b $0c,$03,$0d,$04,$02,$06,$00,$20,$03,$21,$00,$2c,$00
        dc.b $1c,$03,$0d,$04,$02,$06,$00,$20,$03,$21,$00,$2c,$00
        dc.b $08,$03,$0d,$04,$02,$06,$00,$20,$03,$21,$00,$2c,$00
        dc.b $02,$00,$0a,$04,$01,$06,$01,$20,$04,$00
        dc.b $0d,$02,$0a,$04,$01,$06,$01,$20,$05,$00
        dc.b $0f,$01,$18,$04,$01,$02,$01,$06,$01,$20,$06,$21,$01,$25,$01,$00,$02,$26,$0a,$2b,$06,$2d,$02,$00
        dc.b $0a,$01,$18,$04,$01,$02,$01,$06,$01,$20,$06,$21,$01,$25,$01,$00,$02,$26,$0a,$2b,$06,$2d,$02,$00
        dc.b $0a,$01,$08,$02,$01,$20,$07,$00
        dc.b $09,$04,$13,$04,$02,$06,$02,$20,$08,$23,$04,$ff,$21,$02,$26,$05,$2b,$02,$00
        dc.b $09,$05,$0f,$04,$02,$03,$06,$20,$09,$23,$06,$ff,$2b,$02,$00
        dc.b $02,$00,$0a,$04,$03,$06,$03,$20,$0a,$00
        dc.b $0a,$04,$19,$04,$03,$02,$04,$20,$0b,$23,$04,$00,$21,$03,$25,$03,$00,$04,$26,$0a,$2b,$06,$2d,$02,$00
        dc.b $0f,$04,$19,$04,$03,$02,$04,$20,$0b,$23,$04,$00,$21,$03,$25,$03,$00,$04,$26,$0a,$2b,$06,$2d,$02,$00
        dc.b $02,$00,$0a,$04,$04,$06,$04,$20,$0c,$00
        dc.b $27,$05,$17,$04,$04,$02,$06,$20,$0d,$23,$06,$00,$21,$04,$25,$04,$00,$05,$26,$0a,$2b,$0a,$00
        dc.b $0a,$05,$17,$04,$04,$02,$06,$20,$0d,$23,$06,$00,$21,$04,$25,$04,$00,$05,$26,$0a,$2b,$0a,$00
        dc.b $0f,$05,$17,$04,$04,$02,$06,$20,$0d,$23,$06,$00,$21,$04,$25,$04,$00,$05,$26,$0a,$2b,$0a,$00
        dc.b $26,$00,$09,$04,$04,$20,$0e,$29,$00
        dc.b $0d,$07,$0e,$04,$05,$20,$0f,$26,$0a,$2b,$06,$27,$0c,$00
        dc.b $25,$07,$0e,$04,$05,$20,$0f,$26,$0a,$2b,$06,$27,$0c,$00
        dc.b $0f,$01,$0e,$04,$05,$20,$0f,$26,$0a,$2b,$06,$27,$0c,$00
        dc.b $40,$01,$0e,$04,$05,$20,$0f,$26,$0a,$2b,$06,$27,$0c,$00
        dc.b $02,$00,$0e,$04,$05,$20,$0f,$26,$0a,$2b,$06,$27,$0c,$00
        dc.b $37,$00,$08,$06,$01,$20,$10,$00
        dc.b $37,$00,$0a,$06,$03,$03,$04,$20,$11,$00
        dc.b $37,$00,$08,$06,$03,$20,$12,$00
        dc.b $37,$00,$0a,$06,$04,$03,$06,$20,$13,$00
        dc.b $37,$00,$08,$06,$04,$20,$14,$00
        dc.b $37,$00,$06,$20,$15,$00
        dc.b $45,$00,$06,$20,$16,$00
        dc.b $46,$00,$06,$20,$17,$00
        dc.b $47,$00,$06,$20,$18,$00
        dc.b $0f,$0a,$06,$20,$19,$00
        dc.b $09,$09,$06,$20,$1a,$00
        dc.b $22,$00,$06,$20,$1b,$00
        dc.b $ff
        even
messages
        dc.l m1-base
        dc.l m2-base
        dc.l m3-base
        dc.l m4-base
        dc.l m5-base
        dc.l m6-base
        dc.l m7-base
        dc.l m8-base
        dc.l m9-base
        dc.l m10-base
        dc.l m11-base
        dc.l m12-base
        dc.l m13-base
        dc.l m14-base
        dc.l m15-base
        dc.l m16-base
        dc.l m17-base
        dc.l m18-base
        dc.l m19-base
        dc.l m20-base
        dc.l m21-base
        dc.l m22-base
        dc.l m23-base
        dc.l m24-base
        dc.l m25-base
        dc.l m26-base
        dc.l m27-base
m1
        dc.b $11,"YOU DIG AT THE X. NOTHING. AS EVERY",$0d,"ARCHAEOLOGIST KNOWS: X NEVER, EVER"
        dc.b $0d,"MARKS THE SPOT.",$0d,0
m2
        dc.b $11,"X NEVER, EVER MARKS THE SPOT.",$0d,0
m3
        dc.b $11,"BEHIND THE FEET OF A STONE HERO",$0d,"SOMETHING GLITTERS... A TINY PIECE OF"
        dc.b $0d,"STARLIGHT!",$0d,0
m4
        dc.b $11,"THE GATE IS CLOSED.",$0d,0
m5
        dc.b $11,"IT HAS NO HANDLE. ONLY A ROUND HOLLOW.",$0d,0
m6
        dc.b $11,"YOU PRESS THE AMULET INTO THE HOLLOW.",$0d,"THE GATE GLOWS AND SLIDES OPEN WITHOUT"
        dc.b $0d,"A SOUND. YOU TAKE THE AMULET BACK.",$0d,0
m7
        dc.b $11,"YOU HOLD ON TO IT. YOU WILL NEED IT.",$0d,0
m8
        dc.b $11,"YOU GENTLY TAKE THE MIRROR FROM THE",$0d,"STATUE'S HANDS.",$0d
        dc.b 0
m9
        dc.b $11,"YOU SCOOP UP A HANDFUL OF GLITTERING",$0d,"DUST.",$0d,0
m10
        dc.b $11,"THE DOOR WITH THE CRYSTAL EYE IS",$0d,"CLOSED.",$0d,0
m11
        dc.b $11,"YOU PLACE THE MIRROR ON THE STAND. THE",$0d,"SUNBEAM BOUNCES STRAIGHT INTO THE"
        dc.b $0d,"CRYSTAL EYE... AND THE DOOR SWINGS",$0d,"OPEN!",$0d,0
m12
        dc.b $11,"YOU STEP INTO THE VOID... AND QUICKLY",$0d,"PULL YOUR FOOT BACK. THERE IS NOTHING"
        dc.b $0d,"THERE!",$0d,0
m13
        dc.b $11,"YOU THROW THE STAR DUST INTO THE VOID.",$0d,"IT SETTLES ON SOMETHING INVISIBLE... A"
        dc.b $0d,"GLITTERING BRIDGE APPEARS!",$0d,0
m14
        dc.b $11,"YOU STEP INTO NOTHING AND FALL... AND",$0d,"FALL...",$0d,0
m15
        dc.b $11,"THE SYMBOLS LIGHT UP ONE BY ONE AS YOU",$0d,"HOLD UP THE AMULET. THE GOLDEN DOOR"
        dc.b $0d,"OPENS. THEN A COLD VOICE BEHIND YOU",$0d,"SAYS: 'THANK YOU FOR OPENING THE WAY.'"
        dc.b $0d,"COMMANDER VEX!",$0d,0
m16
        dc.b $11,"PUT THE AMULET INTO THE HOLLOW IN THE",$0d,"GATE.",$0d,0
m17
        dc.b $11,"TAKE THE MIRROR FROM THE STATUE.",$0d,0
m18
        dc.b $11,"PUT THE MIRROR ON THE STAND IN THE",$0d,"SUNBEAM.",$0d,0
m19
        dc.b $11,"THE DUST IN THE HALL OF STATUES CLINGS",$0d,"TO EVERYTHING."
        dc.b $0d,0
m20
        dc.b $11,"THROW THE STAR DUST INTO THE VOID.",$0d,0
m21
        dc.b $11,"OPEN THE GOLDEN DOOR.",$0d,0
m22
        dc.b $11,"A HOLLOW VOICE SAYS: WRONG GAME. THIS",$0d,"ISN'T COLOSSAL CAVE."
        dc.b $0d,0
m23
        dc.b $11,"GOD MODE? NICE TRY. THIS IS A COMMODORE",$0d,"64, NOT A 486."
        dc.b $0d,0
m24
        dc.b $11,"THAT'S THE ANSWER TO LIFE, THE UNIVERSE",$0d,"AND EVERYTHING. BUT WHAT WAS THE"
        dc.b $0d,"QUESTION?",$0d,0
m25
        dc.b $11,"YOU WAVE YOUR HAND. THESE AREN'T THE",$0d,"COMMANDS YOU'RE LOOKING FOR."
        dc.b $0d,0
m26
        dc.b $11,"THERE IS NO LAMP HERE. THIS ISN'T ZORK,",$0d,"YOU KNOW. BUT WATCH OUT FOR GRUES"
        dc.b $0d,"ANYWAY.",$0d,0
m27
        dc.b $11,"TYPE COMMANDS LIKE TAKE KEY, OPEN DOOR,",$0d,"EXAMINE MAT, N S E W U D, L = LOOK,"
        dc.b $0d,"I = INVENTORY, TAKE ALL, DROP ALL,",$0d,"G = AGAIN, SCORE, MAP, SAVE, LOAD, QUIT"
        dc.b $0d,"F1 LOAD  F3 SAVE  F5 MUSIC  F7 QUIT",$0d,"THREE SAVE SLOTS: PRESS 1, 2 OR 3."
        dc.b $0d,"HINT GIVES A CLUE BUT COSTS 3 POINTS.",$0d,"FIND THE 16 HIDDEN STAR FRAGMENTS!"
        dc.b $0d,0
t_intro
        dc.b $11,"AT THE TOP OF THE STAIRS STANDS THE SKY",$0d,"TEMPLE, CARVED FROM ONE GIANT CRYSTAL."
        dc.b $0d,"THE WIND HOWLS. SOMEWHERE FAR BELOW,",$0d,"BOOTS ARE MARCHING UP THE STEPS."
        dc.b $0d,$0d,0
t_title
        dc.b $17,$0d,"CHAPTER 8: THE SKY TEMPLE",$0d,$0d,0
t_short
        dc.b "CHAPTER 8",0
t_quip
        dc.b $17,"THE TEMPLE STATUES HAVE A NEW FRIEND. A",$0d,"VERY QUIET ONE."
        dc.b $0d,0
d1
        dc.b $1d,"YOU STAND BEFORE THE GATE OF THE SKY",$0d,"TEMPLE. IN THE MIDDLE OF THE GATE IS A"
        dc.b $0d,"ROUND HOLLOW, EXACTLY THE SIZE OF YOUR",$0d,"AMULET.",$0d,0
d2
        dc.b $1d,"YOU ARE IN THE HALL OF STATUES. STONE",$0d,"STRONKIES WITH CRYSTAL EYES LINE THE"
        dc.b $0d,"WALLS. ONE OF THEM HOLDS A MIRROR.",$0d,"GLITTERING DUST COVERS THE FLOOR."
        dc.b $0d,"SOMEBODY HAS DRAWN A BIG X IN IT.",$0d,0
d3
        dc.b $1d,"YOU ARE IN A ROUND ROOM. A BEAM OF",$0d,"SUNLIGHT FALLS THROUGH THE ROOF ONTO AN"
        dc.b $0d,"EMPTY STAND. IN THE NORTH WALL IS A",$0d,"DOOR WITH A CRYSTAL EYE."
        dc.b $0d,0
d4
        dc.b $1d,"YOU STAND AT THE EDGE OF AN ENDLESS",$0d,"DROP. STARS FLOAT IN THE AIR, BUT THERE"
        dc.b $0d,"IS NO BRIDGE. FAR ACROSS THE VOID GLOWS",$0d,"A GOLDEN DOOR."
        dc.b $0d,0
d5
        dc.b $1d,"YOU STAND BEFORE A GOLDEN DOOR COVERED",$0d,"IN SYMBOLS. BEHIND IT YOU HEAR A DEEP,"
        dc.b $0d,"SLOW HEARTBEAT.",$0d,0
t0
        dc.b "THE AMULET",0
t1
        dc.b $11,"IT GLOWS BRIGHTER AND BRIGHTER THE",$0d,"CLOSER YOU GET TO THE TEMPLE."
        dc.b $0d,0
t2
        dc.b 0
t3
        dc.b $11,"A GATE OF SOLID CRYSTAL WITH A ROUND",$0d,"HOLLOW IN THE MIDDLE."
        dc.b $0d,0
t4
        dc.b $11,"ANCIENT STRONKIE HEROES. THEIR CRYSTAL",$0d,"EYES SEEM TO FOLLOW YOU."
        dc.b $0d,0
t5
        dc.b "A SILVER MIRROR",0
t6
        dc.b $11,"A ROUND MIRROR OF POLISHED SILVER.",$0d,0
t7
        dc.b $11,"FINE STAR DUST. IT CLINGS TO EVERYTHING",$0d,"IT TOUCHES. SOMEBODY HAS DRAWN A BIG X"
        dc.b $0d,"IN IT. X NEVER, EVER MARKS THE SPOT.",$0d,0
t8
        dc.b "A HANDFUL OF STAR DUST",0
t9
        dc.b $11,"IT GLITTERS AND STICKS TO EVERYTHING.",$0d,0
t10
        dc.b $11,"A STAND WITH A ROUND FRAME, RIGHT IN",$0d,"THE SUNBEAM. IT LOOKS EMPTY."
        dc.b $0d,0
t11
        dc.b $11,"A DOOR WITH A BIG CRYSTAL EYE. IT LOOKS",$0d,"AT THE STAND."
        dc.b $0d,0
t12
        dc.b $11,"NOTHING BUT STARS AND DARKNESS. OR IS",$0d,"THERE SOMETHING YOU CANNOT SEE?"
        dc.b $0d,0
t13
        dc.b $11,"THE SYMBOLS LOOK LIKE THE ONES ON YOUR",$0d,"AMULET.",$0d,0
t_save
        dc.b "SAVE1-SKYTEMPLE",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$54,$48,$45,$20,$53,$4b,$59,$20,$54,$45,$4d,$50,$4c,$45,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$20,$20,$05,$44,$4f,$4f,$52,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$20,$20,$20
        dc.b $20,$20,$20,$20,$20,$20,$20,$04,$53,$54,$41,$52,$57,$41,$59,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $62,$0d,$1f,$20,$02,$53,$54,$41,$54,$55,$45,$53,$0e,$60,$60,$60,$03,$4d,$49,$52,$52,$4f,$52,$53,$0e,$0d,$1f,$20,$20,$20,$20,$62
        dc.b $0d,$1f,$20,$20,$20,$01,$47,$41,$54,$45,$0e,$0d,$00
        even
song
        dc.w 3                  ; voices
        dc.b $10,$8a,$aa,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $10,$3a,$8a,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$09,$50,$03     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $1d,$70,$1e,$70,$1d,$70,$1b,$38,$1e,$38,$1d,$70,$1e,$70,$1d,$70,$1b,$38,$1e,$38,$ff
song_v2
        dc.b $3c,$38,$3d,$38,$41,$54,$00,$1c,$3f,$38,$3d,$1c,$3c,$1c,$3a,$70,$38,$38,$3a,$38,$3c,$38,$3d,$38,$3c,$70,$00,$70,$ff
song_v3
        dc.b $41,$1c,$00,$1c,$48,$1c,$00,$1c,$42,$1c,$00,$1c,$49,$1c,$00,$1c,$41,$1c,$00,$1c,$48,$1c,$00,$1c,$3f,$1c,$00,$1c,$42,$1c,$00,$1c
        dc.b $41,$1c,$00,$1c,$48,$1c,$00,$1c,$42,$1c,$00,$1c,$49,$1c,$00,$1c,$41,$1c,$00,$1c,$48,$1c,$00,$1c,$3f,$1c,$00,$1c,$42,$1c,$00,$1c
        dc.b $ff
        even
actors                               ; moving sprites per room
;       room, sprites, first image, images, image delay, move delay, dx, dy
;       x, y (C64 sprite coordinates), height in lines, colours 1-3
        dc.b 1,3,0,1,8,5,1,0
        dc.w 144,53,12,$000,$bbd,$eef
        dc.b 4,2,1,2,6,1,-1,0
        dc.w 324,91,8,$fa4,$fe8,$fff
        dc.b 0
        even
frames                               ; offsets of the sprite images
        dc.l fr0-base
        dc.l fr1-base
        dc.l fr2-base
fr0                              ; "cloud": 3 sprite(s), 12 lines
        dc.w $0000,$0000,$0000,$0003,$0007,$007f,$007f,$03ff,$03ff,$0fff,$0fff,$1fff,$1fff,$3fff,$3fff,$7fff
        dc.w $3fff,$7fff,$0fff,$3fff,$001f,$0fff,$0000,$001f
        dc.w $0000,$1e00,$3f00,$fff0,$fff8,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff
        dc.w $ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$0000,$ffff
        dc.w $0000,$0000,$0000,$0000,$0000,$01c0,$0380,$ffc0,$ffc0,$fff0,$fff0,$fff8,$fff8,$fffc,$fffc,$fffe
        dc.w $fffc,$fffe,$fff0,$fffc,$fc00,$fff0,$0000,$f800
fr1                              ; "comet1": 2 sprite(s), 8 lines
        dc.w $0000,$0000,$0000,$0000,$0000,$001e,$001f,$07ff,$e7ff,$1fff,$001f,$07ff,$0000,$001e,$0000,$0000
        dc.w $0000,$0000,$0000,$0400,$0300,$8f00,$ef80,$ffc0,$ffe0,$fff0,$ef80,$ffc0,$0300,$8f00,$0000,$0400
fr2                              ; "comet2": 2 sprite(s), 8 lines
        dc.w $0000,$0000,$0000,$0004,$0000,$01ef,$003f,$1fff,$e3ff,$1fff,$003f,$1fff,$0000,$01ef,$0000,$0004
        dc.w $0000,$0000,$0000,$1000,$0600,$0e00,$ef80,$ff80,$fff0,$fff8,$ef80,$ff80,$0600,$0e00,$0000,$1000
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 0
card                                 ; next part: kind, name, spoken title (in the blob)
        dc.l card_k-base,card_n-base
        dc.l $019fc6             ; "Chapter 9. The Star Heart"
card_k
        dc.b "CHAPTER 9",0
card_n
        dc.b "THE STAR HEART",0
        even
        even
part_end
