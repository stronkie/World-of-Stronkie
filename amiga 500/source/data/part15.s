;======================================================================
;  THE WORLD OF STRONKIE V2.1 (Amiga) - CHAPTER 12: THE PRISON DECK
;  Created By Mark Stronks
;
;  Part file "PART15": vasm -Fbin -o part15.bin part15.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_STCORR      = $000000      ; picture "stcorr" in the blob
PIC_CELLBLOCK   = $0067dc      ; picture "cellblock" in the blob
PIC_GUARDROOM   = $00a072      ; picture "guardroom" in the blob
PIC_QUARTERS    = $00e42e      ; picture "quarters" in the blob
PIC_CONTROL     = $012d40      ; picture "control" in the blob

base
        dc.b "CHAP"
        dc.b 15,1,5,11       ; part, start room, rooms, objects
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
        dc.b 2,0
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_STCORR
        dc.b 2,0,3,4,0,0,0,0      ; plift
        dc.l d2-base,PIC_CELLBLOCK
        dc.b 0,1,0,0,0,0,0,0      ; cellblock
        dc.l d3-base,PIC_GUARDROOM
        dc.b 5,0,0,1,0,0,0,0      ; guardroom
        dc.l d4-base,PIC_QUARTERS
        dc.b 0,0,1,0,0,0,0,0      ; records
        dc.l d5-base,PIC_CONTROL
        dc.b 0,3,0,0,0,0,0,0      ; control
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,1,2,0
        dc.l t0-base,t1-base
        dc.b 2,0,1,0
        dc.l t2-base,t3-base
        dc.b 3,3,0,0
        dc.l t4-base,t5-base
        dc.b 3,0,2,0
        dc.l t0-base,t6-base
        dc.b 4,0,1,0
        dc.l t7-base,t8-base
        dc.b 5,2,2,0
        dc.l t0-base,t9-base
        dc.b 6,2,2,0
        dc.l t0-base,t10-base
        dc.b 7,2,2,0
        dc.l t0-base,t11-base
        dc.b 8,4,2,0
        dc.l t0-base,t12-base
        dc.b 9,4,2,0
        dc.l t0-base,t13-base
        dc.b 10,5,2,0
        dc.l t0-base,t14-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "ROGE",1
        dc.b "JANI",1
        dc.b "MOP ",1
        dc.b "BUCK",2
        dc.b "WATE",2
        dc.b "GUAR",3
        dc.b "KEYC",4
        dc.b "CARD",4
        dc.b "FIEL",5
        dc.b "CELL",5
        dc.b "PRIS",6
        dc.b "PIRA",6
        dc.b "STRO",6
        dc.b "EDMU",7
        dc.b "UNCL",7
        dc.b "CABI",8
        dc.b "FILE",9
        dc.b "DESK",9
        dc.b "LEVE",10
        dc.b "SCRE",10
        dc.b "SO  ",11
        dc.b "LAMP",12
        dc.b "FORC",13
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $3d,$0b,$06,$20,$01,$00
        dc.b $0c,$08,$0d,$04,$04,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $1c,$08,$0d,$04,$04,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $08,$08,$0d,$04,$04,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $20,$01,$1d,$04,$01,$01,$01,$05,$38,$06,$01,$20,$03,$23,$05,$ff,$21,$01,$23,$03,$00,$23,$04,$03,$26,$0a,$2b,$02,$00
        dc.b $20,$00,$1d,$04,$01,$01,$01,$05,$38,$06,$01,$20,$03,$23,$05,$ff,$21,$01,$23,$03,$00,$23,$04,$03,$26,$0a,$2b,$02,$00
        dc.b $20,$01,$12,$04,$01,$01,$01,$06,$38,$20,$04,$23,$01,$00,$23,$02,$01,$00
        dc.b $20,$00,$12,$04,$01,$01,$01,$06,$38,$20,$04,$23,$01,$00,$23,$02,$01,$00
        dc.b $20,$01,$08,$01,$01,$20,$05,$00
        dc.b $2a,$00,$1c,$04,$03,$02,$02,$20,$06,$23,$02,$00,$23,$05,$03,$21,$01,$23,$03,$00,$23,$04,$03,$26,$0a,$2b,$08,$00
        dc.b $0a,$02,$1c,$04,$03,$02,$02,$20,$06,$23,$02,$00,$23,$05,$03,$21,$01,$23,$03,$00,$23,$04,$03,$26,$0a,$2b,$08,$00
        dc.b $0f,$02,$1c,$04,$03,$02,$02,$20,$06,$23,$02,$00,$23,$05,$03,$21,$01,$23,$03,$00,$23,$04,$03,$26,$0a,$2b,$08,$00
        dc.b $02,$00,$0a,$04,$03,$06,$01,$20,$07,$00
        dc.b $09,$04,$0a,$04,$03,$06,$01,$20,$08,$00
        dc.b $1d,$03,$0d,$04,$03,$06,$01,$20,$09,$2d,$06,$29,$00
        dc.b $20,$03,$0a,$04,$03,$06,$01,$20,$0a,$00
        dc.b $05,$00,$0a,$04,$01,$03,$05,$20,$0b,$00
        dc.b $10,$09,$12,$04,$04,$06,$02,$20,$0c,$21,$02,$26,$0a,$2b,$07,$2d,$04,$00
        dc.b $0c,$09,$12,$04,$04,$06,$02,$20,$0c,$21,$02,$26,$0a,$2b,$07,$2d,$04,$00
        dc.b $13,$0a,$15,$04,$05,$06,$03,$20,$0d,$21,$03,$23,$06,$00,$26,$0a,$2b,$06,$2d,$02,$00
        dc.b $0f,$04,$15,$04,$05,$06,$03,$20,$0d,$21,$03,$23,$06,$00,$26,$0a,$2b,$06,$2d,$02,$00
        dc.b $36,$05,$0d,$04,$02,$06,$03,$20,$0e,$2d,$08,$29,$00
        dc.b $20,$07,$0a,$04,$02,$06,$03,$20,$0f,$00
        dc.b $20,$07,$0e,$04,$02,$06,$04,$20,$10,$21,$04,$26,$0a,$00
        dc.b $20,$00,$10,$04,$02,$05,$03,$06,$04,$20,$10,$21,$04,$26,$0a,$00
        dc.b $20,$07,$08,$05,$04,$20,$11,$00
        dc.b $06,$00,$10,$04,$01,$05,$04,$20,$12,$26,$0a,$2b,$09,$27,$10,$00
        dc.b $01,$00,$10,$04,$01,$05,$04,$20,$12,$26,$0a,$2b,$09,$27,$10,$00
        dc.b $06,$00,$08,$04,$01,$20,$13,$00
        dc.b $37,$00,$0a,$06,$01,$05,$38,$20,$14,$00
        dc.b $37,$00,$0a,$06,$01,$01,$01,$20,$15,$00
        dc.b $37,$00,$0a,$06,$01,$03,$02,$20,$16,$00
        dc.b $37,$00,$08,$06,$01,$20,$17,$00
        dc.b $37,$00,$08,$03,$05,$20,$18,$00
        dc.b $37,$00,$08,$06,$02,$20,$19,$00
        dc.b $37,$00,$08,$06,$03,$20,$1a,$00
        dc.b $37,$00,$08,$06,$04,$20,$1b,$00
        dc.b $37,$00,$06,$20,$1c,$00
        dc.b $45,$00,$06,$20,$1d,$00
        dc.b $46,$00,$06,$20,$1e,$00
        dc.b $47,$00,$06,$20,$1f,$00
        dc.b $0f,$0d,$06,$20,$20,$00
        dc.b $09,$0c,$06,$20,$21,$00
        dc.b $22,$00,$06,$20,$22,$00
        dc.b $00,$00,$10,$04,$02,$05,$03,$06,$05,$20,$23,$21,$05,$2b,$0c,$00
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
        dc.l m28-base
        dc.l m29-base
        dc.l m30-base
        dc.l m31-base
        dc.l m32-base
        dc.l m33-base
        dc.l m34-base
        dc.l m35-base
m1
        dc.b $11,"'MAKE IT SO!' YOU ORDER, IN YOUR BEST",$0d,"STARSHIP CAPTAIN VOICE. NOVA:"
        dc.b $0d,"'ENGAGING... NOTHING, PILOT. I AM NOT",$0d,"THAT KIND OF STARSHIP.' YOU SHALL BE"
        dc.b $0d,"MISSED, SIR PATRICK STEWART - OUR",$0d,"CAPTAIN JEAN-LUC PICARD OF STAR TREK."
        dc.b $0d,"1940-2026.",$0d,0
m2
        dc.b $11,"IN THE DRAWER MARKED PRIVATE SOMETHING",$0d,"GLITTERS... A TINY PIECE OF STARLIGHT!"
        dc.b $0d,0
m3
        dc.b $11,"'HEY, IT'S THE NAPKIN KID!' ROGER",$0d,"GRINS. 'I WORK HERE NOW. BETTER PAY."
        dc.b $0d,"YOU NEED THE GUARD'S KEYCARD? LEAVE IT",$0d,"TO ME.' HE MOPS THE GUARDROOM FLOOR"
        dc.b $0d,"UNTIL IT SHINES... CRASH! THE GUARD",$0d,"SLIPS AND KNOCKS HIMSELF OUT. ROGER"
        dc.b $0d,"HANDS YOU THE KEYCARD. 'NOW WE'RE EVEN,",$0d,"PAL.'",$0d,0
m4
        dc.b $11,"ROGER LOOKS AT YOU. 'DO I KNOW YOU?",$0d,"NOBODY EVER GIVES ME A NAPKIN, YOU"
        dc.b $0d,"KNOW. ANYWAY, I'M ON MY BREAK.' HE",$0d,"WANDERS OFF AND LEAVES HIS BUCKET"
        dc.b $0d,"BEHIND.",$0d,0
m5
        dc.b $11,"'GOOD LUCK, PAL!'",$0d,0
m6
        dc.b $11,"YOU POUR THE SOAPY WATER ALL OVER THE",$0d,"GUARDROOM FLOOR. THE GUARD JUMPS UP,"
        dc.b $0d,"SLIPS... CRASH! HE KNOCKS HIMSELF OUT.",$0d,"HIS KEYCARD SKIDS ACROSS THE FLOOR."
        dc.b $0d,0
m7
        dc.b $11,"THE GUARD JUMPS UP. 'NOBODY GETS INTO",$0d,"THE CONTROL ROOM!'"
        dc.b $0d,0
m8
        dc.b $11,"THE GUARD GROWLS: 'HANDS OFF MY",$0d,"KEYCARD.'",$0d,0
m9
        dc.b $11,"THE GUARD IS MUCH BIGGER THAN YOU.",$0d,"MUCH, MUCH BIGGER."
        dc.b $0d,0
m10
        dc.b $11,"'MOVE ALONG, JANITOR.'",$0d,0
m11
        dc.b $11,"THE RECORDS ROOM IS LOCKED. A CARD",$0d,"READER BLINKS RED."
        dc.b $0d,0
m12
        dc.b $11,"THE FILE READS: COMMANDER VEX. REAL",$0d,"NAME: VICTOR RAVENMOOR. YOUNGER BROTHER"
        dc.b $0d,"OF EDMUND RAVENMOOR. THROWN OUT OF THE",$0d,"FAMILY FOR STEALING THE PLANS OF THE"
        dc.b $0d,"STARRAVEN. WANTED ON SEVEN WORLDS...",$0d,"VEX IS YOUR OTHER UNCLE!"
        dc.b $0d,0
m13
        dc.b $11,"YOU SWIPE THE KEYCARD AND PULL THE BIG",$0d,"LEVER. ALL OVER THE PRISON DECK THE"
        dc.b $0d,"FORCE FIELDS FLICKER AND DIE. THE",$0d,"PRISONERS CHEER!",$0d
        dc.b 0
m14
        dc.b $11,"ZZZAP! THE FORCE FIELD THROWS YOU",$0d,"ACROSS THE CELLBLOCK. YOU DON'T GET UP"
        dc.b $0d,"AGAIN.",$0d,0
m15
        dc.b $11,"UNCLE EDMUND STOPS SINGING. 'YOU'RE",$0d,"HERE! FIND THE CONTROL ROOM AND SWITCH"
        dc.b $0d,"OFF THESE FORCE FIELDS!'",$0d,0
m16
        dc.b $11,"UNCLE EDMUND HUGS YOU. 'YOU CAME FOR",$0d,"ME! SO... YOU KNOW NOW. VICTOR IS MY"
        dc.b $0d,"LITTLE BROTHER. HE WAS ALWAYS JEALOUS",$0d,"OF THE STARRAVEN. LET'S STOP HIM,"
        dc.b $0d,"TOGETHER. THE BRIDGE IS UP THE LIFT!'",$0d,0
m17
        dc.b $11,"'TO THE BRIDGE! UP THE LIFT!'",$0d,0
m18
        dc.b $11,"YOU AND UNCLE EDMUND STEP INTO THE",$0d,"LIFT. 'BRIDGE,' SAYS EDMUND. THE DOORS"
        dc.b $0d,"SLIDE SHUT...",$0d,0
m19
        dc.b $11,"YOU WON'T LEAVE WITHOUT UNCLE EDMUND.",$0d,0
m20
        dc.b $11,"TALK TO ROGER. HE STILL OWES YOU A",$0d,"FAVOUR.",$0d,0
m21
        dc.b $11,"TALK TO ROGER THE JANITOR.",$0d,0
m22
        dc.b $11,"TAKE ROGER'S BUCKET.",$0d,0
m23
        dc.b $11,"POUR THE SOAPY WATER IN THE GUARDROOM.",$0d,0
m24
        dc.b $11,"TAKE THE GUARD'S KEYCARD.",$0d,0
m25
        dc.b $11,"READ THE FILE IN THE RECORDS ROOM, WEST",$0d,"OF THE LIFT."
        dc.b $0d,0
m26
        dc.b $11,"PULL THE LEVER IN THE CONTROL ROOM,",$0d,"NORTH OF THE GUARDROOM."
        dc.b $0d,0
m27
        dc.b $11,"TALK TO UNCLE EDMUND IN THE CELLBLOCK.",$0d,0
m28
        dc.b $11,"GO BACK TO THE LIFT AND GO UP.",$0d,0
m29
        dc.b $11,"A HOLLOW VOICE SAYS: WRONG GAME. THIS",$0d,"ISN'T COLOSSAL CAVE."
        dc.b $0d,0
m30
        dc.b $11,"GOD MODE? NICE TRY. THIS IS A COMMODORE",$0d,"64, NOT A 486."
        dc.b $0d,0
m31
        dc.b $11,"THAT'S THE ANSWER TO LIFE, THE UNIVERSE",$0d,"AND EVERYTHING. BUT WHAT WAS THE"
        dc.b $0d,"QUESTION?",$0d,0
m32
        dc.b $11,"YOU WAVE YOUR HAND. THESE AREN'T THE",$0d,"COMMANDS YOU'RE LOOKING FOR."
        dc.b $0d,0
m33
        dc.b $11,"THERE IS NO LAMP HERE. THIS ISN'T ZORK,",$0d,"YOU KNOW. BUT WATCH OUT FOR GRUES"
        dc.b $0d,"ANYWAY.",$0d,0
m34
        dc.b $11,"TYPE COMMANDS LIKE TAKE KEY, OPEN DOOR,",$0d,"EXAMINE MAT, N S E W U D, L = LOOK,"
        dc.b $0d,"I = INVENTORY, TAKE ALL, DROP ALL,",$0d,"G = AGAIN, SCORE, MAP, SAVE, LOAD, QUIT"
        dc.b $0d,"F1 LOAD  F3 SAVE  F5 MUSIC  F7 QUIT",$0d,"THREE SAVE SLOTS: PRESS 1, 2 OR 3."
        dc.b $0d,"HINT GIVES A CLUE BUT COSTS 3 POINTS.",$0d,"FIND THE 16 HIDDEN STAR FRAGMENTS!"
        dc.b $0d,0
m35
        dc.b $11,"THE PRISONERS STREAM OUT OF THEIR",$0d,"CELLS. THE STRONKIES CHEER, AND UNCLE"
        dc.b $0d,"EDMUND STEPS OUT, GRINNING.",$0d,0
t_intro
        dc.b $11,"THE LIFT DROPS INTO THE PRISON DECK.",$0d,"RED LIGHTS, COLD STEEL... AND"
        dc.b $0d,"SOMEWHERE, A PRISONER IS SINGING. IT",$0d,"SOUNDS LIKE UNCLE EDMUND. IT ALSO"
        dc.b $0d,"SOUNDS TERRIBLE.",$0d,$0d,0
t_title
        dc.b $17,$0d,"CHAPTER 12: THE PRISON DECK",$0d,$0d,0
t_short
        dc.b "CHAPTER 12",0
t_quip
        dc.b $17,"YOU ALWAYS WANTED A ROOM OF YOUR OWN.",$0d,"NOW YOU HAVE A CELL."
        dc.b $0d,0
d1
        dc.b $1d,"YOU ARE IN THE LIFT LOBBY OF THE PRISON",$0d,"DECK. RED LIGHTS BLINK. A JANITOR IS"
        dc.b $0d,"MOPPING THE FLOOR. THE CELLS ARE NORTH,",$0d,"THE GUARDROOM EAST, THE RECORDS ROOM"
        dc.b $0d,"WEST.",$0d,0
d2
        dc.b $1d,"YOU ARE IN THE CELLBLOCK. BEHIND",$0d,"HUMMING FORCE FIELDS SIT STRONKIES, A"
        dc.b $0d,"FEW PIRATES... AND UNCLE EDMUND,",$0d,"SINGING BADLY.",$0d,0
d3
        dc.b $1d,"YOU ARE IN THE GUARDROOM. A DOOR LEADS",$0d,"NORTH TO THE CONTROL ROOM."
        dc.b $0d,0
d4
        dc.b $1d,"YOU ARE IN THE RECORDS ROOM. FILING",$0d,"CABINETS LINE THE WALLS. ONE FILE LIES"
        dc.b $0d,"OPEN ON THE DESK.",$0d,0
d5
        dc.b $1d,"YOU ARE IN THE PRISON CONTROL ROOM.",$0d,"SCREENS SHOW EVERY CELL. A BIG LEVER"
        dc.b $0d,"CONTROLS THE FORCE FIELDS.",$0d,0
t0
        dc.b 0
t1
        dc.b $11,"ROGER THE JANITOR, FROM ASTEROID 42! HE",$0d,"IS MOPPING THE PRISON DECK NOW."
        dc.b $0d,0
t2
        dc.b "A BUCKET OF SOAPY WATER",0
t3
        dc.b $11,"ROGER'S BUCKET, FULL OF VERY SLIPPERY",$0d,"SOAPY WATER.",$0d
        dc.b 0
t4
        dc.b "A GUARD AT HIS DESK",0
t5
        dc.b $11,"A GUARD WITH A KEYCARD ON HIS BELT. HE",$0d,"WATCHES THE NORTH DOOR."
        dc.b $0d,0
t6
        dc.b $11,"HE IS OUT COLD, SNORING.",$0d,0
t7
        dc.b "A KEYCARD",0
t8
        dc.b $11,"A BLACK KEYCARD WITH A SILVER RAVEN.",$0d,0
t9
        dc.b $11,"HUMMING FORCE FIELDS. DON'T TOUCH THEM.",$0d,0
t10
        dc.b $11,"STRONKIES FROM THE VILLAGE, A FEW",$0d,"PIRATES, AND IN THE LAST CELL: UNCLE"
        dc.b $0d,"EDMUND!",$0d,0
t11
        dc.b $11,"UNCLE EDMUND, A BIT THIN BUT CHEERFUL.",$0d,"HE WAVES AT YOU."
        dc.b $0d,0
t12
        dc.b $11,"DRAWERS FULL OF FILES ON EVERY",$0d,"PRISONER... AND ONE DRAWER MARKED:"
        dc.b $0d,"PRIVATE.",$0d,0
t13
        dc.b $11,"A FILE WITH A RED STAMP: TOP SECRET.",$0d,"COMMANDER VEX.",$0d
        dc.b 0
t14
        dc.b $11,"A BIG LEVER WITH A CARD READER: FORCE",$0d,"FIELDS ON / OFF."
        dc.b $0d,0
t_save
        dc.b "SAVE1-PRISON",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$54,$48,$45,$20,$50,$52,$49,$53,$4f,$4e,$20,$44,$45,$43,$4b,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$20,$20,$02,$43,$45,$4c,$4c,$53,$0e,$20,$20,$20,$20,$05,$43,$4f,$4e,$54,$52,$4f,$4c,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$20,$20,$20,$20,$20,$20,$62,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$04,$52,$45,$43,$4f,$52,$44,$53,$0e,$60,$60
        dc.b $60,$60,$60,$01,$4c,$49,$46,$54,$0e,$60,$60,$60,$60,$60,$03,$47,$55,$41,$52,$44,$53,$0e,$0d,$00
        even
song
        dc.w 3                  ; voices
        dc.b $10,$0a,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$5a,$a9,$07     ; waveform, attack/decay, sustain/release, pulse
        dc.b $80,$00,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $1b,$40,$1b,$40,$16,$40,$16,$40,$17,$40,$17,$40,$16,$80,$1b,$40,$1b,$40,$16,$40,$16,$40,$17,$40,$17,$40,$16,$80,$ff
song_v2
        dc.b $33,$20,$36,$20,$3a,$30,$38,$10,$36,$40,$35,$40,$33,$20,$36,$20,$35,$20,$32,$20,$33,$80,$3a,$20,$3d,$20,$3f,$30,$3d,$10,$3b,$40
        dc.b $3a,$40,$38,$20,$36,$20,$35,$20,$33,$20,$32,$40,$35,$40,$ff
song_v3
        dc.b $49,$08,$00,$78,$49,$08,$00,$78,$49,$08,$00,$78,$49,$08,$00,$78,$49,$08,$00,$78,$49,$08,$00,$78,$49,$08,$00,$78,$49,$08,$00,$78
        dc.b $ff
        even
actors                               ; moving sprites per room
;       room, sprites, first image, images, image delay, move delay, dx, dy
;       x, y (C64 sprite coordinates), height in lines, colours 1-3
        dc.b 0
        even
frames                               ; offsets of the sprite images
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 1,0
        dc.l $018916             ; NOVA: Engaging... nothing, pilot. i am not tha
        dc.w 0
card                                 ; next part: kind, name, spoken title (in the blob)
        dc.l card_k-base,card_n-base
        dc.l $01b950             ; "Chapter 13. The Bridge"
card_k
        dc.b "CHAPTER 13",0
card_n
        dc.b "THE BRIDGE",0
        even
        even
part_end
