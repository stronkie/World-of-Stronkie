;======================================================================
;  THE WORLD OF STRONKIE V2.1 (Amiga) - PROLOGUE, PART 3: THE LAUNCH PAD
;  Created By Mark Stronks
;
;  Part file "PART03": vasm -Fbin -o part03.bin part03.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_STAIRS      = $000000      ; picture "stairs" in the blob
PIC_BUNKER      = $005ec0      ; picture "bunker" in the blob
PIC_LOCKERS     = $00c6fc      ; picture "lockers" in the blob
PIC_HANGAR      = $010820      ; picture "hangar" in the blob
PIC_CONTROL     = $015996      ; picture "control" in the blob
PIC_SHIPIN      = $01b56c      ; picture "shipin" in the blob

base
        dc.b "CHAP"
        dc.b 3,1,6,14       ; part, start room, rooms, objects
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
        dc.b 10,2
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_STAIRS
        dc.b 0,0,0,0,0,2,0,0      ; stairs
        dc.l d2-base,PIC_BUNKER
        dc.b 0,0,0,3,1,0,0,0      ; bunker
        dc.l d3-base,PIC_LOCKERS
        dc.b 0,0,2,0,0,0,0,0      ; lockers
        dc.l d4-base,PIC_HANGAR
        dc.b 5,0,0,2,0,0,0,0      ; hangar
        dc.l d5-base,PIC_CONTROL
        dc.b 0,4,0,0,0,0,0,0      ; control
        dc.l d6-base,PIC_SHIPIN
        dc.b 0,0,0,0,0,4,0,0      ; ship
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,255,1,0
        dc.l t0-base,t1-base
        dc.b 2,1,2,0
        dc.l t2-base,t3-base
        dc.b 3,2,2,0
        dc.l t2-base,t4-base
        dc.b 4,3,2,0
        dc.l t2-base,t5-base
        dc.b 5,0,1,0
        dc.l t6-base,t7-base
        dc.b 6,0,1,0
        dc.l t8-base,t9-base
        dc.b 6,0,1,0
        dc.l t10-base,t11-base
        dc.b 7,4,2,0
        dc.l t2-base,t12-base
        dc.b 8,4,2,0
        dc.l t2-base,t13-base
        dc.b 9,5,2,0
        dc.l t2-base,t14-base
        dc.b 10,5,2,0
        dc.l t2-base,t15-base
        dc.b 11,5,2,0
        dc.l t2-base,t16-base
        dc.b 12,6,2,0
        dc.l t2-base,t17-base
        dc.b 13,6,2,0
        dc.l t2-base,t18-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "AMUL",1
        dc.b "STAI",2
        dc.b "DOOR",3
        dc.b "SLOT",3
        dc.b "LOCK",4
        dc.b "KEYC",5
        dc.b "CARD",5
        dc.b "SPAC",6
        dc.b "SUIT",6
        dc.b "HELM",6
        dc.b "SHIP",7
        dc.b "STAR",7
        dc.b "ROCK",7
        dc.b "HATC",8
        dc.b "RAMP",8
        dc.b "CONS",9
        dc.b "SCRE",9
        dc.b "HOLE",9
        dc.b "LEVE",10
        dc.b "UNCL",11
        dc.b "EDMU",11
        dc.b "SEAT",12
        dc.b "CHAI",12
        dc.b "BUTT",13
        dc.b "HANG",14
        dc.b "LAMP",15
        dc.b "FORC",16
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $0c,$02,$0d,$04,$01,$06,$00,$20,$01,$21,$00,$2c,$00
        dc.b $1c,$02,$0d,$04,$01,$06,$00,$20,$01,$21,$00,$2c,$00
        dc.b $08,$02,$0d,$04,$01,$06,$00,$20,$01,$21,$00,$2c,$00
        dc.b $06,$00,$08,$04,$01,$20,$02,$00
        dc.b $0d,$04,$0a,$04,$03,$05,$01,$20,$03,$00
        dc.b $0d,$04,$10,$04,$03,$20,$04,$23,$06,$03,$23,$05,$03,$21,$01,$00
        dc.b $0c,$04,$0a,$04,$03,$06,$01,$20,$05,$00
        dc.b $2b,$06,$08,$02,$07,$20,$06,$00
        dc.b $2b,$06,$10,$02,$06,$20,$07,$23,$06,$00,$23,$07,$ff,$26,$05,$00
        dc.b $2b,$06,$08,$01,$06,$20,$08,$00
        dc.b $0a,$06,$08,$02,$07,$20,$09,$00
        dc.b $04,$00,$0a,$04,$02,$06,$02,$20,$0a,$00
        dc.b $11,$03,$0a,$04,$02,$05,$02,$20,$03,$00
        dc.b $0d,$03,$0a,$04,$02,$05,$02,$20,$03,$00
        dc.b $11,$03,$14,$04,$02,$02,$05,$20,$0b,$21,$02,$25,$02,$02,$04,$26,$0a,$2b,$06,$00
        dc.b $0d,$03,$14,$04,$02,$02,$05,$20,$0b,$21,$02,$25,$02,$02,$04,$26,$0a,$2b,$06,$00
        dc.b $0f,$05,$16,$04,$02,$02,$05,$06,$02,$20,$0b,$21,$02,$25,$02,$02,$04,$26,$0a,$2b,$06,$00
        dc.b $0a,$05,$16,$04,$02,$02,$05,$06,$02,$20,$0b,$21,$02,$25,$02,$02,$04,$26,$0a,$2b,$06,$00
        dc.b $0d,$03,$08,$04,$02,$20,$0c,$00
        dc.b $11,$03,$08,$04,$02,$20,$0c,$00
        dc.b $0f,$01,$13,$04,$05,$02,$01,$20,$0d,$23,$01,$00,$21,$03,$26,$0a,$2b,$0d,$00
        dc.b $0a,$01,$13,$04,$05,$02,$01,$20,$0d,$23,$01,$00,$21,$03,$26,$0a,$2b,$0d,$00
        dc.b $0f,$01,$08,$02,$01,$20,$0e,$00
        dc.b $0a,$01,$08,$02,$01,$20,$0f,$00
        dc.b $13,$0a,$0a,$04,$05,$06,$03,$20,$10,$00
        dc.b $13,$0a,$0a,$04,$05,$05,$04,$20,$11,$00
        dc.b $13,$0a,$12,$04,$05,$20,$12,$21,$04,$25,$04,$04,$06,$26,$05,$2b,$06,$00
        dc.b $14,$0a,$08,$04,$05,$20,$13,$00
        dc.b $20,$00,$0a,$04,$05,$06,$03,$20,$14,$00
        dc.b $20,$00,$0a,$04,$05,$06,$04,$20,$15,$00
        dc.b $20,$00,$08,$04,$05,$20,$16,$00
        dc.b $06,$00,$0a,$04,$04,$06,$04,$20,$17,$00
        dc.b $01,$07,$0a,$04,$04,$05,$04,$24,$06,$00
        dc.b $01,$07,$08,$04,$04,$20,$17,$00
        dc.b $0d,$08,$08,$04,$04,$20,$18,$00
        dc.b $14,$0d,$12,$04,$06,$02,$07,$20,$19,$26,$0a,$2b,$09,$2d,$10,$27,$04,$00
        dc.b $34,$00,$12,$04,$06,$02,$07,$20,$19,$26,$0a,$2b,$09,$2d,$10,$27,$04,$00
        dc.b $14,$0d,$0a,$04,$06,$20,$1a,$2b,$04,$00
        dc.b $34,$00,$0a,$04,$06,$20,$1a,$2b,$04,$00
        dc.b $34,$00,$06,$20,$1b,$00
        dc.b $35,$00,$08,$04,$06,$20,$1c,$00
        dc.b $37,$00,$08,$06,$01,$20,$1d,$00
        dc.b $37,$00,$0a,$03,$05,$06,$02,$20,$1e,$00
        dc.b $37,$00,$08,$06,$02,$20,$1f,$00
        dc.b $37,$00,$08,$06,$03,$20,$20,$00
        dc.b $37,$00,$08,$06,$04,$20,$21,$00
        dc.b $37,$00,$08,$03,$07,$20,$22,$00
        dc.b $37,$00,$06,$20,$23,$00
        dc.b $45,$00,$06,$20,$24,$00
        dc.b $46,$00,$06,$20,$25,$00
        dc.b $47,$00,$06,$20,$26,$00
        dc.b $0f,$10,$06,$20,$27,$00
        dc.b $09,$0f,$06,$20,$28,$00
        dc.b $22,$00,$06,$20,$29,$00
        dc.b $00,$00,$10,$04,$04,$06,$05,$20,$2a,$21,$05,$2b,$07,$2d,$04,$00
        dc.b $00,$00,$0c,$04,$05,$06,$06,$20,$2b,$21,$06,$00
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
        dc.l m36-base
        dc.l m37-base
        dc.l m38-base
        dc.l m39-base
        dc.l m40-base
        dc.l m41-base
        dc.l m42-base
        dc.l m43-base
m1
        dc.b $11,"IN A CRACK IN ONE OF THE STEPS",$0d,"SOMETHING GLITTERS... A TINY PIECE OF"
        dc.b $0d,"STARLIGHT!",$0d,0
m2
        dc.b $11,"SOLDIERS IN BLACK ARE COMING DOWN THE",$0d,"STAIRS! YOU BETTER NOT GO BACK UP."
        dc.b $0d,0
m3
        dc.b $11,"IT IS ALREADY OPEN.",$0d,0
m4
        dc.b $11,"YOU OPEN THE PILOT LOCKER. INSIDE HANGS",$0d,"A SPACESUIT, AND ON THE SHELF LIES A"
        dc.b $0d,"KEYCARD.",$0d,0
m5
        dc.b $11,"THE LOCKER MARKED PILOT IS CLOSED.",$0d,0
m6
        dc.b $11,"YOU ARE ALREADY WEARING IT.",$0d,0
m7
        dc.b $11,"YOU PULL ON THE SPACESUIT AND CLICK THE",$0d,"HELMET INTO PLACE."
        dc.b $0d,0
m8
        dc.b $11,"PICK IT UP FIRST.",$0d,0
m9
        dc.b $11,"YOU WILL NEED IT FOR THE FLIGHT. BETTER",$0d,"KEEP IT ON.",$0d
        dc.b 0
m10
        dc.b $11,"THE BLAST DOOR IS CLOSED.",$0d,0
m11
        dc.b $11,"YOU SLIDE THE KEYCARD INTO THE SLOT.",$0d,"WITH A HISS THE BLAST DOOR ROLLS OPEN."
        dc.b $0d,0
m12
        dc.b $11,"THE BLAST DOOR WON'T BUDGE. IT NEEDS A",$0d,"KEYCARD.",$0d,0
m13
        dc.b $11,"YOU PRESS THE AMULET INTO THE ROUND",$0d,"SLOT. IT FITS PERFECTLY! THE SCREENS"
        dc.b $0d,"FLASH: STARRAVEN POWER ONLINE. HIGH",$0d,"ABOVE, THE HANGAR ROOF SLIDES OPEN."
        dc.b $0d,0
m14
        dc.b $11,"NOT HERE. MAYBE IN THE CONTROL ROOM?",$0d,0
m15
        dc.b $11,"UNCLE EDMUND WOULD NEVER FORGIVE YOU.",$0d,0
m16
        dc.b $11,"THE LEVER WON'T MOVE. THERE IS NO",$0d,"POWER.",$0d,0
m17
        dc.b $11,"THE HATCH IS ALREADY OPEN.",$0d,0
m18
        dc.b $11,"WITH A DEEP RUMBLE THE STARRAVEN'S",$0d,"HATCH OPENS AND A RAMP LOWERS TO THE"
        dc.b $0d,"PAD.",$0d,0
m19
        dc.b $11,"IT ONLY MOVES ONE WAY. TRY PULLING IT.",$0d,0
m20
        dc.b $17,"UNCLE EDMUND: 'THE LAUNCH SYSTEMS NEED",$0d,"POWER. PUT THE AMULET IN THE CONSOLE!'"
        dc.b $0d,0
m21
        dc.b $17,"UNCLE EDMUND: 'PULL THE LEVER TO OPEN",$0d,"THE HATCH. AND WEAR A FLIGHT SUIT!'"
        dc.b $0d,0
m22
        dc.b $17,"UNCLE EDMUND: 'GO! I WILL HOLD THEM",$0d,"OFF. FIND THE WORLD OF STRONKIE!'"
        dc.b $0d,0
m23
        dc.b $11,"THE SHIP'S HATCH IS CLOSED.",$0d,0
m24
        dc.b $11,"IT IS CONTROLLED FROM THE CONTROL ROOM.",$0d,0
m25
        dc.b $11,"YOU STRAP INTO THE PILOT SEAT AND SLAM",$0d,"THE BUTTON. THE ENGINES ROAR! THROUGH"
        dc.b $0d,"THE OPEN ROOF THE STARRAVEN BLASTS INTO",$0d,"THE NIGHT SKY... AND OUT INTO SPACE!"
        dc.b $0d,0
m26
        dc.b $11,"A VOICE SAYS: 'PILOT NOT IN A FLIGHT",$0d,"SUIT. LAUNCH DENIED.'"
        dc.b $0d,0
m27
        dc.b $11,"YOU HAVE TO BE INSIDE THE SHIP FOR",$0d,"THAT.",$0d,0
m28
        dc.b $11,"A PERFECT FIT. NOW ALL YOU NEED IS THAT",$0d,"LAUNCH BUTTON."
        dc.b $0d,0
m29
        dc.b $11,"OPEN THE LOCKER MARKED PILOT IN THE",$0d,"LOCKER ROOM.",$0d,0
m30
        dc.b $11,"TAKE THE KEYCARD FROM THE PILOT LOCKER.",$0d,0
m31
        dc.b $11,"INSERT THE KEYCARD INTO THE SLOT OF THE",$0d,"BLAST DOOR.",$0d
        dc.b 0
m32
        dc.b $11,"PUT THE AMULET INTO THE CONSOLE IN THE",$0d,"CONTROL ROOM."
        dc.b $0d,0
m33
        dc.b $11,"PULL THE LEVER IN THE CONTROL ROOM.",$0d,0
m34
        dc.b $11,"YOU MUST WEAR THE SPACESUIT FROM THE",$0d,"PILOT LOCKER.",$0d
        dc.b 0
m35
        dc.b $11,"BOARD THE SHIP AND PRESS THE LAUNCH",$0d,"BUTTON.",$0d,0
m36
        dc.b $11,"A HOLLOW VOICE SAYS: WRONG GAME. THIS",$0d,"ISN'T COLOSSAL CAVE."
        dc.b $0d,0
m37
        dc.b $11,"GOD MODE? NICE TRY. THIS IS A COMMODORE",$0d,"64, NOT A 486."
        dc.b $0d,0
m38
        dc.b $11,"THAT'S THE ANSWER TO LIFE, THE UNIVERSE",$0d,"AND EVERYTHING. BUT WHAT WAS THE"
        dc.b $0d,"QUESTION?",$0d,0
m39
        dc.b $11,"YOU WAVE YOUR HAND. THESE AREN'T THE",$0d,"COMMANDS YOU'RE LOOKING FOR."
        dc.b $0d,0
m40
        dc.b $11,"THERE IS NO LAMP HERE. THIS ISN'T ZORK,",$0d,"YOU KNOW. BUT WATCH OUT FOR GRUES"
        dc.b $0d,"ANYWAY.",$0d,0
m41
        dc.b $11,"TYPE COMMANDS LIKE TAKE KEY, OPEN DOOR,",$0d,"EXAMINE MAT, N S E W U D, L = LOOK,"
        dc.b $0d,"I = INVENTORY, TAKE ALL, DROP ALL,",$0d,"G = AGAIN, SCORE, MAP, SAVE, LOAD, QUIT"
        dc.b $0d,"F1 LOAD  F3 SAVE  F5 MUSIC  F7 QUIT",$0d,"THREE SAVE SLOTS: PRESS 1, 2 OR 3."
        dc.b $0d,"HINT GIVES A CLUE BUT COSTS 3 POINTS.",$0d,"FIND THE 16 HIDDEN STAR FRAGMENTS!"
        dc.b $0d,0
m42
        dc.b $11,"FROM FAR ABOVE COMES A LOUD BANGING.",$0d,"THEY ARE TRYING TO BREAK IN!"
        dc.b $0d,0
m43
        dc.b $17,"UNCLE EDMUND LOOKS UP FROM THE SCREENS:",$0d,"'THE SHIP NEEDS POWER. USE THE AMULET!'"
        dc.b $0d,0
t_intro
        dc.b $11,"UNCLE EDMUND PRESSES THE AMULET INTO",$0d,"YOUR HAND. 'THE STARRAVEN WAITS BELOW."
        dc.b $0d,"GET HER READY TO FLY, I WILL BE IN THE",$0d,"CONTROL ROOM. HURRY!' HE RUNS DOWN THE"
        dc.b $0d,"STAIRS AHEAD OF YOU.",$0d,$0d,0
t_title
        dc.b $17,$0d,"PROLOGUE, PART 3: THE LAUNCH PAD",$0d,$0d,0
t_short
        dc.b "PROLOGUE 3",0
t_quip
        dc.b $17,"THE STARRAVEN WILL HAVE TO FIND ANOTHER",$0d,"PILOT. PREFERABLY A LIVING ONE."
        dc.b $0d,0
d1
        dc.b $1d,"YOU ARE ON A NARROW STAIRWAY THAT",$0d,"SPIRALS DOWN INTO THE ROCK BELOW THE"
        dc.b $0d,"MANOR. FROM ABOVE COMES THE SOUND OF",$0d,"HEAVY BOOTS.",$0d
        dc.b 0
d2
        dc.b $1d,"YOU ARE IN A STEEL CORRIDOR LIT BY",$0d,"HUMMING LAMPS. A HUGE BLAST DOOR WITH A"
        dc.b $0d,"CARD SLOT LEADS EAST. A LOCKER ROOM",$0d,"LIES WEST. STAIRS LEAD UP."
        dc.b $0d,0
d3
        dc.b $1d,"YOU ARE IN A LOCKER ROOM. A ROW OF",$0d,"METAL LOCKERS LINES THE WALL. ONE OF"
        dc.b $0d,"THEM IS MARKED PILOT.",$0d,0
d4
        dc.b $1d,"YOU STAND IN A GIANT HANGAR CARVED OUT",$0d,"OF THE ROCK. ON THE LAUNCH PAD TOWERS A"
        dc.b $0d,"SILVER SPACESHIP: THE STARRAVEN! A",$0d,"CONTROL ROOM LIES NORTH."
        dc.b $0d,0
d5
        dc.b $1d,"YOU ARE IN THE LAUNCH CONTROL ROOM.",$0d,"SCREENS GLOW ABOVE A CONSOLE WITH A"
        dc.b $0d,"ROUND SLOT. A BIG RED LEVER STICKS OUT",$0d,"OF THE WALL.",$0d
        dc.b 0
d6
        dc.b $1d,"YOU ARE INSIDE THE STARRAVEN. A PILOT",$0d,"SEAT FACES WALLS OF BLINKING LIGHTS. A"
        dc.b $0d,"BIG RED BUTTON IS MARKED LAUNCH. THE",$0d,"RAMP LEADS DOWN."
        dc.b $0d,0
t0
        dc.b "THE AMULET",0
t1
        dc.b $11,"A GOLDEN AMULET WITH A GLOWING RED",$0d,"STONE. TINY STARS SEEM TO MOVE INSIDE"
        dc.b $0d,"IT.",$0d,0
t2
        dc.b 0
t3
        dc.b $11,"WORN STONE STEPS. YOU HEAR VOICES FAR",$0d,"ABOVE. BETTER KEEP GOING DOWN."
        dc.b $0d,0
t4
        dc.b $11,"A HUGE STEEL BLAST DOOR. NEXT TO IT IS",$0d,"A SLOT FOR A KEYCARD."
        dc.b $0d,0
t5
        dc.b $11,"THE LOCKERS ARE ALL EMPTY, EXCEPT MAYBE",$0d,"THE ONE MARKED PILOT."
        dc.b $0d,0
t6
        dc.b "A KEYCARD",0
t7
        dc.b $11,"A PLASTIC KEYCARD. IT SAYS: HANGAR",$0d,"ACCESS.",$0d,0
t8
        dc.b "A SPACESUIT",0
t9
        dc.b $11,"A SILVER FLIGHT SUIT WITH A HELMET. IT",$0d,"LOOKS JUST YOUR SIZE."
        dc.b $0d,0
t10
        dc.b "A SPACESUIT (WORN)",0
t11
        dc.b $11,"YOU ARE WEARING IT. IT FEELS LIGHT AND",$0d,"WARM.",$0d,0
t12
        dc.b $11,"A SLEEK SILVER STARSHIP WITH RED FINS.",$0d,"A RAVEN IS PAINTED ON ITS SIDE."
        dc.b $0d,0
t13
        dc.b $11,"THE SHIP'S HATCH. IT IS CONTROLLED FROM",$0d,"THE CONTROL ROOM."
        dc.b $0d,0
t14
        dc.b $11,"A ROUND SLOT IN THE CONSOLE IS EXACTLY",$0d,"THE SIZE OF THE AMULET."
        dc.b $0d,0
t15
        dc.b $11,"A BIG RED LEVER MARKED HATCH.",$0d,0
t16
        dc.b $11,"UNCLE EDMUND IS WORKING AT THE SCREENS.",$0d,"'HURRY!' HE SAYS."
        dc.b $0d,0
t17
        dc.b $11,"A PADDED PILOT SEAT.",$0d,0
t18
        dc.b $11,"A BIG RED BUTTON MARKED LAUNCH.",$0d,0
t_save
        dc.b "SAVE1-LAUNCHPAD",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$54,$48,$45,$20,$4c,$41,$55,$4e,$43,$48,$20,$50,$41,$44,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$20,$01,$53,$54,$41,$49,$52,$53,$0e,$20,$20,$20,$05,$43,$4f,$4e,$54,$52,$4f,$4c,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$20,$20,$20,$20,$20,$62,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$03,$4c,$4f,$43,$4b,$45,$52,$53,$0e,$60,$60,$60
        dc.b $60,$02,$42,$55,$4e,$4b,$45,$52,$0e,$60,$60,$60,$60,$04,$48,$41,$4e,$47,$41,$52,$0e,$60,$60,$60,$60,$60,$06,$53,$48,$49,$50,$0e
        dc.b $0d,$00
        even
song
        dc.w 3                  ; voices
        dc.b $20,$06,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$0a,$9a,$08     ; waveform, attack/decay, sustain/release, pulse
        dc.b $80,$00,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $1d,$0a,$1d,$0a,$29,$0a,$1d,$0a,$1d,$0a,$1d,$0a,$29,$0a,$1d,$0a,$19,$0a,$19,$0a,$25,$0a,$19,$0a,$19,$0a,$19,$0a,$25,$0a,$19,$0a
        dc.b $1b,$0a,$1b,$0a,$27,$0a,$1b,$0a,$1b,$0a,$1b,$0a,$27,$0a,$1b,$0a,$18,$0a,$18,$0a,$24,$0a,$18,$0a,$18,$0a,$18,$0a,$24,$0a,$18,$0a
        dc.b $1d,$0a,$1d,$0a,$29,$0a,$1d,$0a,$1d,$0a,$1d,$0a,$29,$0a,$1d,$0a,$19,$0a,$19,$0a,$25,$0a,$19,$0a,$19,$0a,$19,$0a,$25,$0a,$19,$0a
        dc.b $1b,$0a,$1b,$0a,$27,$0a,$1b,$0a,$1b,$0a,$1b,$0a,$27,$0a,$1b,$0a,$18,$0a,$18,$0a,$24,$0a,$18,$0a,$18,$0a,$18,$0a,$24,$0a,$18,$0a
        dc.b $ff
song_v2
        dc.b $35,$14,$38,$14,$3c,$14,$41,$14,$3d,$1e,$3c,$0a,$38,$28,$3f,$14,$3d,$14,$3c,$14,$3a,$14,$3c,$3c,$00,$14,$41,$14,$3f,$14,$3c,$14
        dc.b $38,$14,$41,$1e,$43,$0a,$44,$28,$43,$14,$3f,$14,$3a,$14,$37,$14,$3c,$28,$40,$28,$ff
song_v3
        dc.b $55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05
        dc.b $55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05
        dc.b $5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05
        dc.b $00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05
        dc.b $00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05
        dc.b $00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a
        dc.b $55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$5c,$0a,$55,$05,$00,$05
        dc.b $ff
        even
actors                               ; moving sprites per room
;       room, sprites, first image, images, image delay, move delay, dx, dy
;       x, y (C64 sprite coordinates), height in lines, colours 1-3
        dc.b 0
        even
frames                               ; offsets of the sprite images
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 0
card                                 ; next part: kind, name, spoken title (in the blob)
        dc.l card_k-base,card_n-base
        dc.l $020a4e             ; "Chapter 1. Into Space"
card_k
        dc.b "CHAPTER 1",0
card_n
        dc.b "INTO SPACE",0
        even
        even
part_end
