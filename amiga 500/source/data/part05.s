;======================================================================
;  THE WORLD OF STRONKIE V2.2 (Amiga) - CHAPTER 2: THE DERELICT STATION
;  Created By Mark Stronks
;
;  Part file "PART05": vasm -Fbin -o part05.bin part05.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_DOCK        = $000000      ; picture "dock" in the blob
PIC_STCORR      = $00475e      ; picture "stcorr" in the blob
PIC_QUARTERS    = $00af3a      ; picture "quarters" in the blob
PIC_POWER       = $00f84c      ; picture "power" in the blob
PIC_MAPROOM     = $014ade      ; picture "maproom" in the blob

base
        dc.b "CHAP"
        dc.b 5,1,5,10       ; part, start room, rooms, objects
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
        dc.b 4,11
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_DOCK
        dc.b 0,0,2,0,0,0,0,0      ; dock
        dc.l d2-base,PIC_STCORR
        dc.b 3,0,0,1,0,0,0,0      ; corridor
        dc.l d3-base,PIC_QUARTERS
        dc.b 0,2,0,0,0,0,0,0      ; quarters
        dc.l d4-base,PIC_POWER
        dc.b 2,0,0,0,0,0,0,0      ; power
        dc.l d5-base,PIC_MAPROOM
        dc.b 0,0,0,2,0,0,0,0      ; maproom
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,1,2,0
        dc.l t0-base,t1-base
        dc.b 2,2,2,0
        dc.l t0-base,t2-base
        dc.b 3,2,0,0
        dc.l t3-base,t4-base
        dc.b 3,0,0,0
        dc.l t5-base,t6-base
        dc.b 4,3,2,0
        dc.l t0-base,t7-base
        dc.b 5,3,2,0
        dc.l t0-base,t8-base
        dc.b 6,4,2,0
        dc.l t0-base,t9-base
        dc.b 7,4,2,0
        dc.l t0-base,t10-base
        dc.b 8,5,2,0
        dc.l t0-base,t11-base
        dc.b 9,5,1,0
        dc.l t12-base,t13-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "SHIP",1
        dc.b "STAR",1
        dc.b "WIRE",2
        dc.b "SPAR",2
        dc.b "ROBO",3
        dc.b "DROI",3
        dc.b "TERM",4
        dc.b "COMP",4
        dc.b "LOG ",4
        dc.b "SCRE",4
        dc.b "BUNK",5
        dc.b "BEDS",5
        dc.b "BED ",5
        dc.b "GENE",6
        dc.b "SWIT",7
        dc.b "HOLO",8
        dc.b "PLAN",8
        dc.b "MAP ",8
        dc.b "TABL",8
        dc.b "CHAR",9
        dc.b "DISC",9
        dc.b "DISK",9
        dc.b "1985",10
        dc.b "1234",11
        dc.b "0000",11
        dc.b "CODE",11
        dc.b "ZORG",11
        dc.b "SO  ",12
        dc.b "LAMP",13
        dc.b "FORC",14
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $3d,$0c,$06,$20,$01,$00
        dc.b $0c,$05,$0d,$04,$03,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $1c,$05,$0d,$04,$03,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $08,$05,$0d,$04,$03,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $0c,$04,$0a,$04,$03,$20,$03,$21,$04,$00
        dc.b $03,$00,$0a,$04,$02,$06,$01,$20,$04,$00
        dc.b $2c,$0a,$1a,$04,$02,$06,$01,$20,$05,$23,$03,$00,$23,$04,$02,$21,$01,$25,$02,$01,$04,$26,$0a,$2b,$0d,$00
        dc.b $2c,$00,$0c,$04,$02,$06,$01,$20,$06,$2b,$04,$00
        dc.b $2c,$00,$06,$20,$07,$00
        dc.b $1d,$03,$0a,$01,$03,$20,$08,$2b,$08,$00
        dc.b $20,$03,$08,$01,$03,$20,$09,$00
        dc.b $09,$03,$06,$20,$0a,$00
        dc.b $10,$04,$0a,$04,$03,$20,$03,$21,$04,$00
        dc.b $36,$02,$0b,$04,$02,$20,$0b,$2d,$06,$29,$00
        dc.b $09,$02,$0b,$04,$02,$20,$0b,$2d,$06,$29,$00
        dc.b $04,$00,$0a,$04,$02,$06,$02,$20,$0c,$00
        dc.b $15,$00,$0a,$04,$04,$05,$02,$20,$0d,$00
        dc.b $15,$00,$14,$04,$04,$20,$0e,$21,$02,$25,$02,$02,$05,$26,$0a,$2b,$09,$2d,$06,$00
        dc.b $13,$07,$16,$04,$04,$06,$02,$20,$0e,$21,$02,$25,$02,$02,$05,$26,$0a,$2b,$09,$2d,$06,$00
        dc.b $14,$07,$16,$04,$04,$06,$02,$20,$0e,$21,$02,$25,$02,$02,$05,$26,$0a,$2b,$09,$2d,$06,$00
        dc.b $27,$07,$16,$04,$04,$06,$02,$20,$0e,$21,$02,$25,$02,$02,$05,$26,$0a,$2b,$09,$2d,$06,$00
        dc.b $0f,$07,$16,$04,$04,$06,$02,$20,$0e,$21,$02,$25,$02,$02,$05,$26,$0a,$2b,$09,$2d,$06,$00
        dc.b $09,$09,$11,$04,$05,$06,$03,$20,$0f,$23,$0a,$ff,$21,$03,$26,$0a,$00
        dc.b $05,$00,$08,$04,$01,$20,$10,$00
        dc.b $01,$01,$10,$04,$01,$02,$0a,$20,$11,$26,$0a,$2b,$0a,$27,$06,$00
        dc.b $01,$01,$08,$04,$01,$20,$12,$00
        dc.b $20,$00,$08,$06,$02,$20,$13,$00
        dc.b $20,$00,$06,$20,$14,$00
        dc.b $37,$00,$0a,$06,$01,$06,$04,$20,$15,$00
        dc.b $37,$00,$08,$06,$01,$20,$16,$00
        dc.b $37,$00,$08,$06,$02,$20,$17,$00
        dc.b $37,$00,$08,$03,$0a,$20,$18,$00
        dc.b $37,$00,$06,$20,$19,$00
        dc.b $45,$00,$06,$20,$1a,$00
        dc.b $46,$00,$06,$20,$1b,$00
        dc.b $47,$00,$06,$20,$1c,$00
        dc.b $0f,$0e,$06,$20,$1d,$00
        dc.b $09,$0d,$06,$20,$1e,$00
        dc.b $22,$00,$06,$20,$1f,$00
        dc.b $00,$00,$0e,$04,$02,$06,$05,$20,$20,$21,$05,$2b,$0d,$00
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
m1
        dc.b $11,"'MAKE IT SO!' YOU ORDER, IN YOUR BEST",$0d,"STARSHIP CAPTAIN VOICE. NOVA:"
        dc.b $0d,"'ENGAGING... NOTHING, PILOT. I AM NOT",$0d,"THAT KIND OF STARSHIP.' YOU SHALL BE"
        dc.b $0d,"MISSED, SIR PATRICK STEWART - OUR",$0d,"CAPTAIN JEAN-LUC PICARD OF STAR TREK."
        dc.b $0d,"1940-2026.",$0d,0
m2
        dc.b $11,"UNDER A DUSTY MATTRESS SOMETHING",$0d,"GLITTERS... A TINY PIECE OF STARLIGHT!"
        dc.b $0d,0
m3
        dc.b $11,"THE LAST LOG ENTRY READS: 'SECURITY",$0d,"CODE CHANGED TO 1985. DO NOT FORGET IT"
        dc.b $0d,"AGAIN, ZORG!'",$0d,0
m4
        dc.b $11,"THE ROBOT BLOCKS THE WAY. 'ACCESS CODE",$0d,"REQUIRED.'",$0d
        dc.b 0
m5
        dc.b $11,"THE ROBOT'S EYE TURNS GREEN. 'ACCESS",$0d,"GRANTED.' IT ROLLS ASIDE AND SWITCHES"
        dc.b $0d,"ITSELF OFF.",$0d,0
m6
        dc.b $11,"'ACCESS DENIED,' THE ROBOT BUZZES.",$0d,0
m7
        dc.b $11,"NOBODY ANSWERS. YOUR VOICE ECHOES",$0d,"THROUGH THE EMPTY STATION."
        dc.b $0d,0
m8
        dc.b $11,"YOUR FIST CLANGS OFF ITS ARMOUR. THE",$0d,"ROBOT GIVES YOU A WARNING ZAP. OUCH!"
        dc.b $0d,0
m9
        dc.b $11,"'ACCESS CODE REQUIRED,' IT REPEATS.",$0d,0
m10
        dc.b $11,"IT WEIGHS MORE THAN A CAR.",$0d,0
m11
        dc.b $11,"ZZZAP! A HUNDRED-YEAR-OLD POWER CABLE",$0d,"STILL HAS PLENTY OF POWER LEFT..."
        dc.b $0d,0
m12
        dc.b $11,"THE MAP ROOM DOOR IS DEAD. THERE IS NO",$0d,"POWER.",$0d,0
m13
        dc.b $11,"THE GENERATOR IS ALREADY RUNNING.",$0d,0
m14
        dc.b $11,"YOU THROW THE SWITCH. THE GENERATOR",$0d,"COUGHS, THEN ROARS INTO LIFE. ALL OVER"
        dc.b $0d,"THE STATION THE LIGHTS FLICKER ON!",$0d,0
m15
        dc.b $11,"YOU PULL THE STAR CHART DISC OUT OF THE",$0d,"TABLE. THE HOLOGRAM FLICKERS AND FADES."
        dc.b $0d,0
m16
        dc.b $11,"THAT IS WHERE THE STARRAVEN IS DOCKED.",$0d,"TRY: ENTER SHIP."
        dc.b $0d,0
m17
        dc.b $11,"YOU CLIMB ABOARD AND SLOT THE STAR",$0d,"CHART INTO THE CONSOLE. NOVA: 'COURSE"
        dc.b $0d,"PLOTTED FOR THE WORLD OF STRONKIE. HOLD",$0d,"ON, PILOT!' THE STARRAVEN BLASTS AWAY"
        dc.b $0d,"FROM KX-9, TOWARDS A DISTANT RINGED",$0d,"PLANET... BUT FIRST, A FEW DETOURS."
        dc.b $0d,0
m18
        dc.b $13,"NOVA'S VOICE CRACKLES: 'NOT WITHOUT THE",$0d,"STAR CHART, PILOT!'"
        dc.b $0d,0
m19
        dc.b $13,"NOVA'S VOICE IN YOUR HELMET: 'THE",$0d,"STATION HAS NO POWER. FIND THE"
        dc.b $0d,"GENERATOR.'",$0d,0
m20
        dc.b $13,"NOVA'S VOICE IN YOUR HELMET: 'GET THE",$0d,"STAR CHART AND COME BACK.'"
        dc.b $0d,0
m21
        dc.b $11,"THE ROBOT WANTS AN ACCESS CODE. MAYBE",$0d,"THE CREW WROTE IT DOWN SOMEWHERE."
        dc.b $0d,0
m22
        dc.b $11,"SAY THE CODE FROM THE TERMINAL TO THE",$0d,"ROBOT.",$0d,0
m23
        dc.b $11,"THE GENERATOR IS BEHIND THE ROBOT.",$0d,"SWITCH IT ON.",$0d,0
m24
        dc.b $11,"TAKE THE STAR CHART IN THE MAP ROOM.",$0d,0
m25
        dc.b $11,"GO BACK TO THE DOCKING BAY AND ENTER",$0d,"THE SHIP.",$0d,0
m26
        dc.b $11,"A HOLLOW VOICE SAYS: WRONG GAME. THIS",$0d,"ISN'T COLOSSAL CAVE."
        dc.b $0d,0
m27
        dc.b $11,"GOD MODE? NICE TRY. THIS IS A COMMODORE",$0d,"64, NOT A 486."
        dc.b $0d,0
m28
        dc.b $11,"THAT'S THE ANSWER TO LIFE, THE UNIVERSE",$0d,"AND EVERYTHING. BUT WHAT WAS THE"
        dc.b $0d,"QUESTION?",$0d,0
m29
        dc.b $11,"YOU WAVE YOUR HAND. THESE AREN'T THE",$0d,"COMMANDS YOU'RE LOOKING FOR."
        dc.b $0d,0
m30
        dc.b $11,"THERE IS NO LAMP HERE. THIS ISN'T ZORK,",$0d,"YOU KNOW. BUT WATCH OUT FOR GRUES"
        dc.b $0d,"ANYWAY.",$0d,0
m31
        dc.b $11,"TYPE COMMANDS LIKE TAKE KEY, OPEN DOOR,",$0d,"EXAMINE MAT, N S E W U D, L = LOOK,"
        dc.b $0d,"I = INVENTORY, TAKE ALL, DROP ALL,",$0d,"G = AGAIN, SCORE, MAP, SAVE, LOAD, QUIT"
        dc.b $0d,"F1 LOAD  F3 SAVE  F5 MUSIC  F7 QUIT",$0d,"THREE SAVE SLOTS: PRESS 1, 2 OR 3."
        dc.b $0d,"HINT GIVES A CLUE BUT COSTS 3 POINTS.",$0d,"FIND THE 16 HIDDEN STAR FRAGMENTS!"
        dc.b $0d,0
m32
        dc.b $11,"SOMETHING CLANKS IN THE DARK. A RED EYE",$0d,"TURNS TOWARDS YOU AND A METALLIC VOICE"
        dc.b $0d,"BOOMS: 'ANOTHER VISITOR. STAY A",$0d,"WHILE... STAY FOREVER!'"
        dc.b $0d,0
t_intro
        dc.b $11,"THE STARRAVEN DROPS OUT OF HYPERSPACE",$0d,"NEXT TO A HUGE, SILENT SPACE STATION:"
        dc.b $0d,"KX-9. NOVA DOCKS THE SHIP. 'THE STAR",$0d,"CHART SHOULD BE IN THE MAP ROOM. BE"
        dc.b $0d,"CAREFUL, PILOT. NOBODY HAS LIVED HERE",$0d,"FOR A HUNDRED YEARS.'"
        dc.b $0d,$0d,0
t_title
        dc.b $17,$0d,"CHAPTER 2: THE DERELICT STATION",$0d,$0d,0
t_short
        dc.b "CHAPTER 2",0
t_quip
        dc.b $17,"THE STATION HAS ONE MORE RESIDENT NOW.",$0d,"ZORG SAYS HELLO."
        dc.b $0d,0
d1
        dc.b $1d,"YOU ARE IN THE DOCKING BAY OF STATION",$0d,"KX-9. THE STARRAVEN RESTS BEHIND YOU. A"
        dc.b $0d,"DARK CORRIDOR LEADS EAST.",$0d,0
d2
        dc.b $1d,"YOU ARE IN A LONG STATION CORRIDOR.",$0d,"TORN WIRES SPARK FROM THE CEILING."
        dc.b $0d,"DOORS LEAD NORTH, SOUTH AND EAST.",$0d,0
d3
        dc.b $1d,"YOU ARE IN THE OLD CREW QUARTERS. EMPTY",$0d,"BUNKS LINE THE WALL. A COMPUTER"
        dc.b $0d,"TERMINAL STILL FLICKERS IN THE CORNER.",$0d,0
d4
        dc.b $1d,"YOU ARE IN THE POWER ROOM. A HUGE",$0d,"GENERATOR STANDS SILENT. A BIG SWITCH"
        dc.b $0d,"ON THE WALL IS SET TO OFF.",$0d,0
d5
        dc.b $1d,"YOU ARE IN THE MAP ROOM. ABOVE A ROUND",$0d,"TABLE FLOATS A HOLOGRAM OF A PLANET"
        dc.b $0d,"WITH RINGS: THE WORLD OF STRONKIE!",$0d,0
t0
        dc.b 0
t1
        dc.b $11,"YOUR SHIP, WAITING FOR YOU. NOVA'S",$0d,"LIGHTS BLINK IN THE COCKPIT."
        dc.b $0d,0
t2
        dc.b $11,"TORN POWER CABLES, STILL SPARKING.",$0d,"DON'T TOUCH THEM!"
        dc.b $0d,0
t3
        dc.b "A SECURITY ROBOT",0
t4
        dc.b $11,"A TALL ROBOT WITH A RED EYE BLOCKS THE",$0d,"SOUTH DOOR. IT SAYS: 'ACCESS CODE"
        dc.b $0d,"REQUIRED.' THE NUMBER 001 IS PAINTED ON",$0d,"ITS CHEST.",$0d
        dc.b 0
t5
        dc.b "A SWITCHED-OFF ROBOT",0
t6
        dc.b $11,"IT STANDS QUIETLY IN THE CORNER, ITS",$0d,"EYE DARK.",$0d,0
t7
        dc.b $11,"THE LAST LOG ENTRY READS: 'SECURITY",$0d,"CODE CHANGED TO 1985. DO NOT FORGET IT"
        dc.b $0d,"AGAIN, ZORG!'",$0d,0
t8
        dc.b $11,"THE BUNKS ARE EMPTY AND COVERED IN",$0d,"DUST.",$0d,0
t9
        dc.b $11,"A HUGE GENERATOR. IT IS SWITCHED OFF.",$0d,0
t10
        dc.b $11,"A BIG SWITCH WITH TWO POSITIONS: ON AND",$0d,"OFF.",$0d,0
t11
        dc.b $11,"A RINGED PLANET SLOWLY TURNS IN THE",$0d,"AIR. UNDER IT THE TABLE SHOWS A STAR"
        dc.b $0d,"CHART DISC.",$0d,0
t12
        dc.b "A STAR CHART DISC",0
t13
        dc.b $11,"A SHINY DISC. IT HOLDS THE ROUTE TO THE",$0d,"WORLD OF STRONKIE."
        dc.b $0d,0
t_save
        dc.b "SAVE1-KX9",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$54,$48,$45,$20,$44,$45,$52,$45,$4c,$49,$43,$54,$20,$53,$54,$41,$54,$49,$4f,$4e,$0d,$1f,$20,$20,$20,$20
        dc.b $20,$20,$20,$20,$20,$20,$20,$03,$51,$55,$41,$52,$54,$45,$52,$53,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$62,$0d,$1f,$20,$20,$20,$01,$44,$4f,$43,$4b,$0e,$60,$60,$60,$60,$02,$43,$4f,$52,$52,$49,$44,$4f,$52,$0e,$60,$60,$05,$4d,$41
        dc.b $50,$20,$52,$4f,$4f,$4d,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$20,$20,$20,$20,$20
        dc.b $20,$20,$20,$20,$20,$20,$04,$50,$4f,$57,$45,$52,$0e,$0d,$00
        even
song
        dc.w 3                  ; voices
        dc.b $40,$0a,$80,$02     ; waveform, attack/decay, sustain/release, pulse
        dc.b $10,$3a,$9a,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $80,$c0,$8c,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $1f,$38,$00,$38,$1f,$38,$00,$1c,$20,$1c,$1f,$38,$00,$38,$1d,$38,$1e,$38,$1f,$38,$00,$38,$1f,$38,$00,$1c,$20,$1c,$1f,$38,$00,$38
        dc.b $1d,$38,$1e,$38,$ff
song_v2
        dc.b $3e,$54,$00,$1c,$3f,$38,$3e,$38,$00,$70,$3c,$1c,$3d,$1c,$3e,$38,$43,$54,$00,$1c,$44,$38,$43,$38,$00,$70,$41,$1c,$42,$1c,$43,$38
        dc.b $ff
song_v3
        dc.b $25,$54,$00,$1c,$25,$54,$00,$1c,$25,$54,$00,$1c,$25,$54,$00,$1c,$25,$54,$00,$1c,$25,$54,$00,$1c,$25,$54,$00,$1c,$25,$54,$00,$1c
        dc.b $ff
        even
actors                               ; moving sprites per room
;       room, sprites, first image, images, image delay, move delay, dx, dy
;       x, y (C64 sprite coordinates), height in lines, colours 1-3
        dc.b 1,2,0,1,8,2,-1,0
        dc.w 264,67,10,$445,$889,$ccd
        dc.b 0
        even
frames                               ; offsets of the sprite images
        dc.l fr0-base
fr0                              ; "shuttle_l": 2 sprite(s), 10 lines
        dc.w $0000,$0000,$0000,$0000,$0000,$0007,$0007,$007f,$00ff,$07ff,$0fff,$3ff8,$3fff,$7ff0,$1fff,$3fff
        dc.w $0000,$07ff,$0000,$0010
        dc.w $0000,$0000,$0000,$7c00,$7c00,$fe00,$fe08,$ff10,$ff0c,$fff0,$ffc6,$fff8,$ffc7,$fff8,$ffc6,$fff8
        dc.w $000c,$fff0,$0008,$0410
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 1,0
        dc.l $0189da             ; NOVA: Engaging... nothing, pilot. i am not tha
        dc.w 17,0
        dc.l $01ba14             ; NOVA: Course plotted for the world of stronkie
        dc.w 18,0
        dc.l $01e518             ; NOVA: Not without the star chart, pilot!
        dc.w 19,0
        dc.l $01fde2             ; NOVA: The station has no power. find the gener
        dc.w 20,0
        dc.l $02211c             ; NOVA: Get the star chart and come back.
        dc.w 0
card                                 ; next part: kind, name, spoken title (in the blob)
        dc.l card_k-base,card_n-base
        dc.l $0235ac             ; "Chapter 3. Asteroid 42"
card_k
        dc.b "CHAPTER 3",0
card_n
        dc.b "ASTEROID 42",0
        even
        even
part_end
