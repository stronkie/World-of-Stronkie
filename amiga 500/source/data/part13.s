;======================================================================
;  THE WORLD OF STRONKIE V2.1 (Amiga) - CHAPTER 10: REPAIRS
;  Created By Mark Stronks
;
;  Part file "PART13": vasm -Fbin -o part13.bin part13.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_WORKSHOP    = $000000      ; picture "workshop" in the blob
PIC_MINEENTRY   = $005976      ; picture "mineentry" in the blob
PIC_MAZE        = $00a2ea      ; picture "maze" in the blob
PIC_VEIN        = $01021e      ; picture "vein" in the blob

base
        dc.b "CHAP"
        dc.b 13,1,6,10       ; part, start room, rooms, objects
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
        dc.b 9,11
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_WORKSHOP
        dc.b 0,0,2,0,0,0,0,0      ; site
        dc.l d2-base,PIC_MINEENTRY
        dc.b 0,0,3,1,0,0,0,0      ; entry
        dc.l d3-base,PIC_MAZE
        dc.b 4,3,3,2,0,0,0,0      ; maze1
        dc.l d4-base,PIC_MAZE
        dc.b 3,3,5,4,0,0,0,0      ; maze2
        dc.l d5-base,PIC_MAZE
        dc.b 4,5,3,4,0,6,0,0      ; maze3
        dc.l d6-base,PIC_VEIN
        dc.b 0,0,0,0,5,0,0,0      ; vein
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,1,2,0
        dc.l t0-base,t1-base
        dc.b 2,1,2,0
        dc.l t0-base,t2-base
        dc.b 3,1,1,0
        dc.l t3-base,t4-base
        dc.b 4,2,2,0
        dc.l t0-base,t5-base
        dc.b 5,0,1,0
        dc.l t6-base,t7-base
        dc.b 6,2,2,0
        dc.l t0-base,t8-base
        dc.b 7,2,2,0
        dc.l t0-base,t9-base
        dc.b 8,6,2,0
        dc.l t0-base,t10-base
        dc.b 9,6,2,0
        dc.l t0-base,t11-base
        dc.b 10,0,1,0
        dc.l t12-base,t13-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "SHIP",1
        dc.b "STAR",1
        dc.b "ENGI",1
        dc.b "SOCK",1
        dc.b "BIX ",2
        dc.b "INVE",2
        dc.b "HAMM",3
        dc.b "TREE",4
        dc.b "BRAN",4
        dc.b "KITE",5
        dc.b "PIP ",6
        dc.b "STRO",6
        dc.b "EARS",6
        dc.b "TUNN",7
        dc.b "MINE",7
        dc.b "DARK",7
        dc.b "VEIN",8
        dc.b "ROCK",8
        dc.b "RUBB",9
        dc.b "STON",9
        dc.b "CRYS",10
        dc.b "LAMP",11
        dc.b "FORC",12
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $0c,$09,$0d,$04,$06,$06,$00,$20,$01,$21,$00,$2c,$00
        dc.b $1c,$09,$0d,$04,$06,$06,$00,$20,$01,$21,$00,$2c,$00
        dc.b $08,$09,$0d,$04,$06,$06,$00,$20,$01,$21,$00,$2c,$00
        dc.b $20,$02,$0a,$04,$01,$06,$01,$20,$02,$00
        dc.b $20,$00,$0a,$04,$01,$05,$01,$20,$03,$00
        dc.b $1b,$00,$13,$04,$02,$06,$02,$20,$04,$23,$05,$ff,$21,$02,$26,$05,$2b,$02,$00
        dc.b $09,$05,$13,$04,$02,$06,$02,$20,$04,$23,$05,$ff,$21,$02,$26,$05,$2b,$02,$00
        dc.b $1a,$05,$13,$04,$02,$02,$05,$20,$05,$23,$05,$00,$21,$03,$26,$0a,$2b,$05,$00
        dc.b $1a,$00,$13,$01,$06,$02,$05,$20,$05,$23,$05,$00,$21,$03,$26,$0a,$2b,$05,$00
        dc.b $20,$06,$0a,$04,$02,$06,$03,$20,$06,$00
        dc.b $04,$00,$0a,$04,$02,$06,$03,$20,$07,$00
        dc.b $20,$06,$08,$04,$03,$20,$08,$00
        dc.b $20,$06,$08,$04,$04,$20,$09,$00
        dc.b $20,$06,$08,$04,$05,$20,$0a,$00
        dc.b $20,$06,$08,$04,$06,$20,$0b,$00
        dc.b $20,$06,$06,$20,$0c,$00
        dc.b $28,$08,$17,$04,$06,$02,$03,$06,$04,$20,$0d,$23,$0a,$ff,$21,$04,$26,$0a,$2b,$08,$2d,$02,$00
        dc.b $0f,$03,$15,$04,$06,$06,$04,$20,$0d,$23,$0a,$ff,$21,$04,$26,$0a,$2b,$08,$2d,$02,$00
        dc.b $28,$08,$0a,$04,$06,$06,$04,$20,$0e,$00
        dc.b $09,$0a,$0a,$04,$06,$06,$04,$20,$0f,$00
        dc.b $1e,$0a,$06,$20,$10,$00
        dc.b $1a,$0a,$13,$04,$01,$02,$0a,$20,$11,$23,$0a,$00,$21,$01,$26,$0a,$2b,$09,$00
        dc.b $0a,$0a,$13,$04,$01,$02,$0a,$20,$11,$23,$0a,$00,$21,$01,$26,$0a,$2b,$09,$00
        dc.b $0f,$0a,$13,$04,$01,$02,$0a,$20,$11,$23,$0a,$00,$21,$01,$26,$0a,$2b,$09,$00
        dc.b $01,$01,$12,$04,$01,$05,$01,$20,$12,$26,$0a,$2b,$0a,$2d,$0c,$27,$0e,$00
        dc.b $34,$00,$12,$04,$01,$05,$01,$20,$12,$26,$0a,$2b,$0a,$2d,$0c,$27,$0e,$00
        dc.b $01,$01,$08,$04,$01,$20,$13,$00
        dc.b $34,$00,$08,$04,$01,$20,$13,$00
        dc.b $37,$00,$0a,$03,$03,$06,$04,$20,$14,$00
        dc.b $37,$00,$08,$06,$02,$20,$15,$00
        dc.b $37,$00,$08,$06,$03,$20,$16,$00
        dc.b $37,$00,$08,$06,$04,$20,$17,$00
        dc.b $37,$00,$08,$06,$01,$20,$18,$00
        dc.b $37,$00,$06,$20,$19,$00
        dc.b $45,$00,$06,$20,$1a,$00
        dc.b $46,$00,$06,$20,$1b,$00
        dc.b $47,$00,$06,$20,$1c,$00
        dc.b $0f,$0c,$06,$20,$1d,$00
        dc.b $09,$0b,$06,$20,$1e,$00
        dc.b $22,$00,$06,$20,$1f,$00
        dc.b $00,$00,$09,$05,$03,$23,$06,$fe,$00
        dc.b $00,$00,$0c,$04,$03,$06,$05,$20,$20,$21,$05,$00
        dc.b $00,$00,$0c,$04,$06,$06,$06,$20,$21,$21,$06,$00
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
m1
        dc.b $11,"IN THE RUBBLE SOMETHING GLITTERS... A",$0d,"TINY PIECE OF STARLIGHT!"
        dc.b $0d,0
m2
        dc.b $11,"'A STAR CRYSTAL, THAT'S WHAT SHE NEEDS.",$0d,"TAKE MY HAMMER. AND FIND A LIGHT BEFORE"
        dc.b $0d,"YOU GO INTO THE MINES!'",$0d,0
m3
        dc.b $11,"BIX: 'SHE'S READY! GO GET YOUR UNCLE!'",$0d,0
m4
        dc.b $11,"YOU CLIMB THE TREE, WOBBLE ALONG A",$0d,"BRANCH AND FREE THE KITE. NOT BAD FOR A"
        dc.b $0d,"PILOT!",$0d,0
m5
        dc.b $11,"PIP HUGS HIS KITE. HIS EARS GLOW BRIGHT",$0d,"WITH JOY! 'THANK YOU! I KNOW THE OLD"
        dc.b $0d,"MINES. MY EARS WILL LIGHT THE WAY!'",$0d,"FROM NOW ON, PIP FOLLOWS YOU"
        dc.b $0d,"EVERYWHERE.",$0d,0
m6
        dc.b $11,"PIP SNIFFS. 'MY KITE IS STUCK IN THE",$0d,"TREE. AND I'M TOO SMALL TO CLIMB.'"
        dc.b $0d,0
m7
        dc.b $11,"YOU TAKE TWO STEPS INTO THE TUNNEL. IT",$0d,"IS PITCH DARK. YOU WON'T GET FAR"
        dc.b $0d,"WITHOUT A LIGHT.",$0d,0
m8
        dc.b $11,"PIP SNIFFS THE AIR. 'NORTH! THE CRYSTAL",$0d,"SMELL COMES FROM THE NORTH.'"
        dc.b $0d,0
m9
        dc.b $11,"PIP'S EARS GLOW BRIGHTER. 'EAST!",$0d,"DEFINITELY EAST.'",$0d
        dc.b 0
m10
        dc.b $11,"PIP POINTS AT A HOLE IN THE FLOOR.",$0d,"'DOWN THERE!'",$0d,0
m11
        dc.b $11,"'A STRONKIE SAYING: IF SOMEONE SAYS",$0d,"THEY'VE SEEN ASTEROIDS WITH MORE BRAINS"
        dc.b $0d,"THAN YOU, ASK IF THEY'VE BEEN LOOKING",$0d,"IN A MIRROR!' PIP GIGGLES."
        dc.b $0d,0
m12
        dc.b $11,"PIP SMILES. 'WHERE TO NEXT?'",$0d,0
m13
        dc.b $11,"YOU SWING THE CRYSTAL HAMMER. CRACK! A",$0d,"PERFECT STAR CRYSTAL BREAKS OUT OF THE"
        dc.b $0d,"VEIN.",$0d,0
m14
        dc.b $11,"YOUR BARE HANDS ARE NO MATCH FOR STAR",$0d,"CRYSTAL.",$0d,0
m15
        dc.b $11,"IT IS PART OF THE VEIN. YOU NEED A",$0d,"HAMMER.",$0d,0
m16
        dc.b $11,"IT IS NOT A CANDY. PIP LOOKS AT YOU",$0d,"STRANGELY.",$0d,0
m17
        dc.b $11,"BIX FITS THE STAR CRYSTAL INTO THE NEW",$0d,"ENGINE. THE STARRAVEN HUMS, THEN ROARS!"
        dc.b $0d,"NOVA: 'ALL SYSTEMS GREEN, PILOT. I'VE",$0d,"TRACKED VEX'S FLAGSHIP. IT'S CALLED THE"
        dc.b $0d,"IRON RAVEN.'",$0d,0
m18
        dc.b $11,"PIP WAVES HIS KITE AS THE STARRAVEN",$0d,"CLIMBS INTO THE SKY. NOVA: 'HOLD ON,"
        dc.b $0d,"UNCLE EDMUND. WE'RE COMING.'",$0d,0
m19
        dc.b $13,"NOVA: 'NO ENGINE, NO FLIGHT, PILOT.'",$0d,0
m20
        dc.b $11,"TAKE THE HAMMER IN BIX'S WORKSHOP.",$0d,0
m21
        dc.b $11,"PIP AT THE MINES IS SAD ABOUT HIS KITE.",$0d,"CLIMB THE TREE."
        dc.b $0d,0
m22
        dc.b $11,"GIVE THE KITE TO PIP. HIS GLOWING EARS",$0d,"ARE THE LIGHT YOU NEED."
        dc.b $0d,0
m23
        dc.b $11,"IN THE MAZE, TALK TO PIP: HE KNOWS THE",$0d,"WAY (EAST, NORTH, EAST, DOWN). THEN"
        dc.b $0d,"BREAK THE VEIN.",$0d,0
m24
        dc.b $11,"BRING THE STAR CRYSTAL TO BIX (UP,",$0d,"WEST, NORTH, WEST, WEST)."
        dc.b $0d,0
m25
        dc.b $11,"ENTER THE SHIP AND FLY UP TO VEX'S",$0d,"FLAGSHIP.",$0d,0
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
        dc.b $11,"PIP WHISPERS: 'IT'S EASY TO GET LOST IN",$0d,"HERE. IF YOU DON'T KNOW THE WAY, ASK"
        dc.b $0d,"ME!'",$0d,0
m33
        dc.b $11,"PIP GIGGLES: 'MY GRANDPA ALWAYS SAID:",$0d,"IF SOMEONE SAYS THEY'VE SEEN ASTEROIDS"
        dc.b $0d,"WITH MORE BRAINS THAN YOU, ASK IF",$0d,"THEY'VE BEEN LOOKING IN A MIRROR!'"
        dc.b $0d,0
t_intro
        dc.b $11,"THE STAR HEART SHINES AGAIN, BUT UNCLE",$0d,"EDMUND IS GONE: VEX TOOK HIM UP TO HIS"
        dc.b $0d,"FLAGSHIP IN ORBIT. BIX HAS DRAGGED THE",$0d,"STARRAVEN TO HIS WORKSHOP. 'I CAN FIX"
        dc.b $0d,"HER,' HE SAYS, 'BUT HER NEW ENGINE",$0d,"NEEDS A STAR CRYSTAL FROM THE OLD"
        dc.b $0d,"MINES. AND NOBODY GOES INTO THE MINES",$0d,"WITHOUT A LIGHT.'"
        dc.b $0d,$0d,0
t_title
        dc.b $17,$0d,"CHAPTER 10: REPAIRS",$0d,$0d,0
t_short
        dc.b "CHAPTER 10",0
t_quip
        dc.b $17,"PIP WILL HAVE TO FIND A NEW FRIEND. HE",$0d,"WAS SO FOND OF YOU."
        dc.b $0d,0
d1
        dc.b $1d,"YOU ARE IN BIX'S WORKSHOP. THE BATTERED",$0d,"STARRAVEN FILLS HALF OF IT, SURROUNDED"
        dc.b $0d,"BY TOOLS. A PATH LEADS EAST TO THE OLD",$0d,"CRYSTAL MINES."
        dc.b $0d,0
d2
        dc.b $1d,"YOU STAND AT THE ENTRANCE OF THE OLD",$0d,"CRYSTAL MINES. A DARK TUNNEL LEADS"
        dc.b $0d,"EAST. UNDER A TALL TREE SITS A LITTLE",$0d,"STRONKIE WITH GLOWING EARS, CRYING. HIS"
        dc.b $0d,"KITE IS STUCK HIGH UP IN THE BRANCHES.",$0d,0
d3
        dc.b $1d,"YOU ARE IN A MAZE OF TWISTY LITTLE",$0d,"CRYSTAL PASSAGES, ALL ALIKE. PIP'S"
        dc.b $0d,"GLOWING EARS LIGHT UP THE WALLS.",$0d,0
d4
        dc.b $1d,"YOU ARE IN A MAZE OF TWISTY LITTLE",$0d,"CRYSTAL PASSAGES, ALL ALIKE. PIP'S"
        dc.b $0d,"GLOWING EARS LIGHT UP THE WALLS.",$0d,0
d5
        dc.b $1d,"YOU ARE IN A MAZE OF TWISTY LITTLE",$0d,"CRYSTAL PASSAGES, ALL ALIKE. PIP'S"
        dc.b $0d,"GLOWING EARS LIGHT UP THE WALLS.",$0d,0
d6
        dc.b $1d,"YOU ARE IN A GLITTERING CAVERN. A WIDE",$0d,"VEIN OF STAR CRYSTAL RUNS THROUGH THE"
        dc.b $0d,"ROCK. RUBBLE LIES EVERYWHERE.",$0d,0
t0
        dc.b 0
t1
        dc.b $11,"BIX HAS TAKEN THE ENGINE APART. A ROUND",$0d,"SOCKET WAITS FOR A STAR CRYSTAL."
        dc.b $0d,0
t2
        dc.b $11,"BIX HAS OIL ON HIS EARS AND A HAPPY",$0d,"GLINT IN HIS EYE."
        dc.b $0d,0
t3
        dc.b "A CRYSTAL HAMMER",0
t4
        dc.b $11,"A HEAVY HAMMER FOR BREAKING CRYSTAL.",$0d,0
t5
        dc.b $11,"A TALL PURPLE TREE. A KITE IS STUCK",$0d,"HIGH UP IN IT.",$0d
        dc.b 0
t6
        dc.b "A KITE",0
t7
        dc.b $11,"A LITTLE BLUE KITE WITH A LONG TAIL.",$0d,0
t8
        dc.b $11,"A LITTLE STRONKIE CALLED PIP. HIS EARS",$0d,"GLOW LIKE TWO LANTERNS."
        dc.b $0d,0
t9
        dc.b $11,"PITCH BLACK. YOU WOULD NEED A LIGHT IN",$0d,"THERE.",$0d,0
t10
        dc.b $11,"A VEIN OF STAR CRYSTAL, HARD AS",$0d,"DIAMOND. YOU WOULD NEED A HAMMER."
        dc.b $0d,0
t11
        dc.b $11,"BROKEN ROCK AND CRYSTAL.",$0d,0
t12
        dc.b "A STAR CRYSTAL",0
t13
        dc.b $11,"A PERFECT STAR CRYSTAL. IT HUMS SOFTLY",$0d,"IN YOUR HAND."
        dc.b $0d,0
t_save
        dc.b "SAVE1-REPAIRS",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$52,$45,$50,$41,$49,$52,$53,$0d,$1f,$20,$01,$57,$4f,$52,$4b,$53,$48,$4f,$50,$0e,$60,$60,$60,$60,$02,$4d
        dc.b $49,$4e,$45,$0e,$60,$60,$60,$60,$03,$54,$55,$4e,$4e,$45,$4c,$53,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$20,$20,$20,$20,$06,$56,$45,$49,$4e,$0e,$0d,$00
        even
song
        dc.w 3                  ; voices
        dc.b $10,$08,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$4a,$88,$03     ; waveform, attack/decay, sustain/release, pulse
        dc.b $10,$00,$30,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $22,$1c,$00,$0e,$22,$0e,$1d,$1c,$20,$1c,$22,$1c,$00,$0e,$22,$0e,$1d,$1c,$20,$1c,$1e,$1c,$00,$0e,$1e,$0e,$19,$1c,$1d,$1c,$1e,$1c
        dc.b $00,$0e,$1e,$0e,$19,$1c,$1d,$1c,$1b,$1c,$00,$0e,$1b,$0e,$16,$1c,$19,$1c,$1b,$1c,$00,$0e,$1b,$0e,$16,$1c,$19,$1c,$1d,$1c,$00,$0e
        dc.b $1d,$0e,$18,$1c,$21,$1c,$1d,$1c,$00,$0e,$1d,$0e,$18,$1c,$21,$1c,$ff
song_v2
        dc.b $3a,$2a,$3d,$0e,$3c,$1c,$35,$1c,$3a,$38,$00,$38,$36,$2a,$3a,$0e,$38,$1c,$3d,$1c,$3c,$54,$00,$1c,$3f,$2a,$3d,$0e,$3c,$1c,$3a,$1c
        dc.b $36,$38,$00,$38,$35,$1c,$39,$1c,$3c,$1c,$3f,$1c,$3d,$1c,$3c,$1c,$39,$38,$ff
song_v3
        dc.b $4d,$07,$00,$31,$48,$07,$00,$31,$4d,$07,$00,$31,$48,$07,$00,$31,$4d,$07,$00,$31,$48,$07,$00,$31,$4d,$07,$00,$31,$48,$07,$00,$31
        dc.b $4d,$07,$00,$31,$48,$07,$00,$31,$4d,$07,$00,$31,$48,$07,$00,$31,$4d,$07,$00,$31,$48,$07,$00,$31,$4d,$07,$00,$31,$48,$07,$00,$31
        dc.b $ff
        even
actors                               ; moving sprites per room
;       room, sprites, first image, images, image delay, move delay, dx, dy
;       x, y (C64 sprite coordinates), height in lines, colours 1-3
        dc.b 2,1,0,2,6,2,1,1
        dc.w 84,61,7,$112,$335,$fd6
        dc.b 0
        even
frames                               ; offsets of the sprite images
        dc.l fr0-base
        dc.l fr1-base
fr0                              ; "bird1": 1 sprite(s), 7 lines
        dc.w $c006,$0000,$600c,$0000,$3838,$0000,$1e78,$0080,$06f8,$0118,$01c0,$0000,$0000,$0000
fr1                              ; "bird2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$0000,$0000,$0600,$0080,$7ef0,$0110,$fffc,$000c,$01c0,$0000,$0000,$0000
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 17,0
        dc.l $0158b0             ; NOVA: All systems green, pilot. i've tracked v
        dc.w 18,0
        dc.l $01806e             ; NOVA: Hold on, uncle edmund. we're coming.
        dc.w 19,0
        dc.l $019fb6             ; NOVA: No engine, no flight, pilot.
        dc.w 0
card                                 ; next part: kind, name, spoken title (in the blob)
        dc.l card_k-base,card_n-base
        dc.l $01ba2a             ; "Chapter 11. Vex's Flagship"
card_k
        dc.b "CHAPTER 11",0
card_n
        dc.b "VEX'S FLAGSHIP",0
        even
        even
part_end
