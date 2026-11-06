;======================================================================
;  THE WORLD OF STRONKIE V2.0 (Amiga) - CHAPTER 6: THE VILLAGE
;  Created By Mark Stronks
;
;  Part file "PART09": vasm -Fbin -o part09.bin part09.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_VSQUARE     = $000000      ; picture "vsquare" in the blob
PIC_MARKET      = $002c14      ; picture "market" in the blob
PIC_ELDER       = $0061a4      ; picture "elder" in the blob
PIC_WORKSHOP    = $00c6e6      ; picture "workshop" in the blob
PIC_TOWER       = $01205c      ; picture "tower" in the blob

base
        dc.b "CHAP"
        dc.b 9,1,5,16       ; part, start room, rooms, objects
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
        dc.b 8,6
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_VSQUARE
        dc.b 3,5,2,4,0,0,0,0      ; square
        dc.l d2-base,PIC_MARKET
        dc.b 0,0,0,1,0,0,0,0      ; market
        dc.l d3-base,PIC_ELDER
        dc.b 0,1,0,0,0,0,0,0      ; hut
        dc.l d4-base,PIC_WORKSHOP
        dc.b 0,0,1,0,0,0,0,0      ; workshop
        dc.l d5-base,PIC_TOWER
        dc.b 1,0,0,0,0,1,0,0      ; tower
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,1,2,0
        dc.l t0-base,t1-base
        dc.b 2,1,2,0
        dc.l t0-base,t2-base
        dc.b 3,0,1,0
        dc.l t3-base,t4-base
        dc.b 4,2,2,0
        dc.l t0-base,t5-base
        dc.b 5,2,2,0
        dc.l t0-base,t6-base
        dc.b 6,0,1,0
        dc.l t7-base,t8-base
        dc.b 7,3,2,0
        dc.l t0-base,t9-base
        dc.b 8,3,2,0
        dc.l t0-base,t10-base
        dc.b 9,0,1,0
        dc.l t11-base,t12-base
        dc.b 10,4,2,0
        dc.l t0-base,t13-base
        dc.b 11,4,2,0
        dc.l t0-base,t14-base
        dc.b 12,0,1,0
        dc.l t15-base,t16-base
        dc.b 13,5,1,0
        dc.l t17-base,t18-base
        dc.b 14,5,2,0
        dc.l t0-base,t19-base
        dc.b 15,5,2,0
        dc.l t0-base,t20-base
        dc.b 16,2,1,0
        dc.l t21-base,t22-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "FOUN",1
        dc.b "WATE",1
        dc.b "STRO",2
        dc.b "PEOP",2
        dc.b "CREA",2
        dc.b "COIN",3
        dc.b "TRAD",4
        dc.b "BEAR",4
        dc.b "STAL",5
        dc.b "STON",5
        dc.b "SHEL",6
        dc.b "ELDE",7
        dc.b "ZOOM",7
        dc.b "SCRO",8
        dc.b "CUSH",8
        dc.b "MAP ",9
        dc.b "BIX ",10
        dc.b "INVE",10
        dc.b "GOGG",10
        dc.b "MACH",11
        dc.b "GEAR",11
        dc.b "SPRI",11
        dc.b "GLID",12
        dc.b "BANN",13
        dc.b "FLAG",13
        dc.b "SAIL",13
        dc.b "TEMP",14
        dc.b "MOUN",14
        dc.b "TENT",14
        dc.b "SHIP",14
        dc.b "NEST",15
        dc.b "POLE",15
        dc.b "GLAS",16
        dc.b "NOSE",16
        dc.b "DISG",16
        dc.b "HUT ",17
        dc.b "MARK",18
        dc.b "WORK",19
        dc.b "TOWE",20
        dc.b "LAMP",21
        dc.b "FORC",22
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $2b,$10,$0e,$02,$10,$06,$3d,$20,$01,$21,$3d,$26,$05,$00
        dc.b $2b,$10,$08,$02,$10,$20,$02,$00
        dc.b $0c,$0f,$0d,$04,$05,$06,$00,$20,$03,$21,$00,$2c,$00
        dc.b $1c,$0f,$0d,$04,$05,$06,$00,$20,$03,$21,$00,$2c,$00
        dc.b $08,$0f,$0d,$04,$05,$06,$00,$20,$03,$21,$00,$2c,$00
        dc.b $1c,$01,$11,$04,$01,$06,$01,$20,$04,$23,$03,$ff,$21,$01,$26,$05,$00
        dc.b $0c,$01,$11,$04,$01,$06,$01,$20,$04,$23,$03,$ff,$21,$01,$26,$05,$00
        dc.b $09,$03,$11,$04,$01,$06,$01,$20,$05,$23,$03,$ff,$21,$01,$26,$05,$00
        dc.b $0c,$01,$08,$04,$01,$20,$06,$00
        dc.b $1a,$03,$14,$04,$02,$02,$03,$20,$07,$23,$03,$00,$23,$06,$ff,$26,$0a,$2b,$02,$00
        dc.b $09,$06,$0a,$04,$02,$03,$06,$20,$08,$00
        dc.b $3b,$06,$10,$02,$06,$06,$02,$20,$09,$21,$02,$26,$0a,$2b,$0d,$00
        dc.b $0f,$06,$10,$02,$06,$06,$02,$20,$09,$21,$02,$26,$0a,$2b,$0d,$00
        dc.b $2b,$06,$10,$02,$06,$06,$02,$20,$09,$21,$02,$26,$0a,$2b,$0d,$00
        dc.b $3b,$00,$10,$02,$06,$06,$02,$20,$09,$21,$02,$26,$0a,$2b,$0d,$00
        dc.b $3b,$00,$08,$06,$02,$20,$0a,$00
        dc.b $20,$04,$0a,$04,$02,$06,$02,$20,$0b,$00
        dc.b $20,$04,$08,$04,$02,$20,$0c,$00
        dc.b $20,$07,$0a,$04,$03,$06,$02,$20,$0d,$00
        dc.b $20,$07,$11,$04,$03,$06,$03,$20,$0e,$21,$03,$23,$09,$ff,$26,$0a,$00
        dc.b $20,$07,$08,$04,$03,$20,$0f,$00
        dc.b $20,$0a,$0a,$04,$04,$06,$02,$20,$10,$00
        dc.b $20,$0a,$0a,$04,$04,$06,$03,$20,$11,$00
        dc.b $20,$0a,$0c,$04,$04,$06,$04,$20,$12,$21,$06,$00
        dc.b $20,$0a,$08,$04,$04,$20,$13,$00
        dc.b $20,$00,$08,$06,$02,$20,$14,$00
        dc.b $20,$00,$06,$20,$15,$00
        dc.b $1a,$0d,$18,$04,$04,$02,$0d,$05,$02,$20,$16,$23,$0d,$00,$23,$0c,$ff,$21,$04,$26,$0a,$2b,$06,$00
        dc.b $40,$0d,$18,$04,$04,$02,$0d,$05,$02,$20,$16,$23,$0d,$00,$23,$0c,$ff,$21,$04,$26,$0a,$2b,$06,$00
        dc.b $1a,$0d,$0a,$04,$04,$02,$0d,$20,$17,$00
        dc.b $09,$0d,$11,$04,$05,$06,$05,$20,$18,$23,$0d,$ff,$21,$05,$26,$05,$00
        dc.b $34,$0c,$10,$04,$05,$02,$0c,$20,$19,$26,$0a,$2b,$0a,$27,$0a,$00
        dc.b $26,$0c,$10,$04,$05,$02,$0c,$20,$19,$26,$0a,$2b,$0a,$27,$0a,$00
        dc.b $0f,$0c,$10,$04,$05,$02,$0c,$20,$19,$26,$0a,$2b,$0a,$27,$0a,$00
        dc.b $34,$00,$10,$04,$05,$02,$0c,$20,$19,$26,$0a,$2b,$0a,$27,$0a,$00
        dc.b $26,$00,$10,$04,$05,$02,$0c,$20,$19,$26,$0a,$2b,$0a,$27,$0a,$00
        dc.b $26,$00,$09,$04,$05,$20,$1a,$29,$00
        dc.b $34,$0c,$08,$02,$0c,$20,$1b,$00
        dc.b $37,$00,$08,$06,$01,$20,$1c,$00
        dc.b $37,$00,$0a,$03,$06,$06,$02,$20,$1d,$00
        dc.b $37,$00,$08,$06,$02,$20,$1e,$00
        dc.b $37,$00,$08,$06,$03,$20,$1f,$00
        dc.b $37,$00,$0a,$06,$06,$06,$04,$20,$20,$00
        dc.b $37,$00,$0a,$06,$04,$03,$0d,$20,$21,$00
        dc.b $37,$00,$08,$06,$04,$20,$22,$00
        dc.b $37,$00,$06,$20,$23,$00
        dc.b $45,$00,$06,$20,$24,$00
        dc.b $46,$00,$06,$20,$25,$00
        dc.b $47,$00,$06,$20,$26,$00
        dc.b $0f,$16,$06,$20,$27,$00
        dc.b $09,$15,$06,$20,$28,$00
        dc.b $22,$00,$06,$20,$29,$00
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
m1
        dc.b $11,"YOU PUT ON THE NOSE GLASSES. THE",$0d,"STRONKIES POINT AT YOU AND FALL OVER"
        dc.b $0d,"LAUGHING. ZAK MCKRACKEN WOULD BE PROUD.",$0d,"YOU KEEP THEM IN YOUR POCKET. YOU NEVER"
        dc.b $0d,"KNOW...",$0d,0
m2
        dc.b $11,"YOU PUT ON THE NOSE GLASSES. THE",$0d,"STRONKIES POINT AT YOU AND FALL OVER"
        dc.b $0d,"LAUGHING. ZAK MCKRACKEN WOULD BE PROUD.",$0d,0
m3
        dc.b $11,"IN THE OLD NEST SOMETHING GLITTERS... A",$0d,"TINY PIECE OF STARLIGHT!"
        dc.b $0d,0
m4
        dc.b $11,"AT THE BOTTOM OF THE FOUNTAIN SOMETHING",$0d,"SHINES. YOU FISH OUT A COIN!"
        dc.b $0d,0
m5
        dc.b $11,"YOU FISH THE COIN OUT OF THE FOUNTAIN.",$0d,0
m6
        dc.b $11,"CLEAR WATER SPLASHES INTO A STONE BOWL.",$0d,0
m7
        dc.b $11,"THE TRADER BITES THE COIN, GRINS AND",$0d,"HANDS YOU A SPIRAL SHELL."
        dc.b $0d,0
m8
        dc.b $11,"THE TRADER SHAKES HIS HEAD AND RUBS HIS",$0d,"FINGERS TOGETHER. HE WANTS TO BE PAID."
        dc.b $0d,0
m9
        dc.b $11,"YOU HOLD THE SHELL TO YOUR EAR. THE",$0d,"CHIRPING ALL AROUND YOU SLOWLY TURNS"
        dc.b $0d,"INTO WORDS! IT WORKS A BIT LIKE A BABEL",$0d,"FISH, BUT LESS SLIMY."
        dc.b $0d,0
m10
        dc.b $11,"ALL YOU HEAR IS HAPPY CHIRPING.",$0d,0
m11
        dc.b $11,"HE CHIRPS, POINTS AT YOUR EMPTY HANDS,",$0d,"THEN AT HIS SHELLS."
        dc.b $0d,0
m12
        dc.b $11,"TRADER: 'A FINE SHELL, NO? THE ELDER",$0d,"WANTS TO SEE YOU, STRANGER.'"
        dc.b $0d,0
m13
        dc.b $11,"THE ELDER CHIRPS SLOWLY. YOU DO NOT",$0d,"UNDERSTAND A WORD."
        dc.b $0d,0
m14
        dc.b $11,"ELDER ZOOMA: 'WELCOME, CHILD OF EARTH.",$0d,"YOUR AMULET IS THE KEY OF THE SKY"
        dc.b $0d,"TEMPLE, WHERE THE STAR HEART KEEPS OUR",$0d,"WORLD ALIVE. COMMANDER VEX HAS COME TO"
        dc.b $0d,"STEAL ITS POWER. TAKE THIS MAP. BIX THE",$0d,"INVENTOR CAN HELP YOU REACH THE"
        dc.b $0d,"TEMPLE.'",$0d,0
m15
        dc.b $11,"ELDER ZOOMA: 'HURRY TO THE TEMPLE,",$0d,"BEFORE VEX FINDS ANOTHER WAY IN.'"
        dc.b $0d,0
m16
        dc.b $11,"THE YOUNG STRONKIE CHIRPS EXCITEDLY AND",$0d,"WAVES A SPANNER AT YOU."
        dc.b $0d,0
m17
        dc.b $11,"BIX: 'HELLO, EARTHLING! THE ELDER WANTS",$0d,"TO SEE YOU FIRST.'"
        dc.b $0d,0
m18
        dc.b $11,"BIX: 'TO THE TEMPLE? THE BRIDGE IS",$0d,"BROKEN, BUT MY GLIDER CAN FLY YOU"
        dc.b $0d,"THERE! IT ONLY NEEDS A BIG, STRONG",$0d,"SAIL.'",$0d,0
m19
        dc.b $11,"BIX: 'JUMP FROM THE LOOKOUT TOWER. GOOD",$0d,"LUCK!'",$0d,0
m20
        dc.b $11,"CHIRP, CHIRP. YOU DO NOT UNDERSTAND",$0d,"THEM.",$0d,0
m21
        dc.b $11,"EVERYONE SMILES AT YOU. THE ELDER AND",$0d,"BIX HAVE MORE TO SAY."
        dc.b $0d,0
m22
        dc.b $11,"BIX STITCHES THE BANNER ONTO HIS",$0d,"GLIDER. 'PERFECT! YOUR GLIDER IS READY."
        dc.b $0d,"TAKE IT UP THE LOOKOUT TOWER AND JUMP!'",$0d,0
m23
        dc.b $11,"BIX CHIRPS HAPPILY, BUT YOU CANNOT",$0d,"UNDERSTAND WHAT HE WANTS."
        dc.b $0d,0
m24
        dc.b $11,"YOU UNTIE THE BIG BANNER FROM ITS POLE.",$0d,0
m25
        dc.b $11,"YOU STRAP INTO THE GLIDER, TAKE A DEEP",$0d,"BREATH AND JUMP. THE WIND CATCHES THE"
        dc.b $0d,"SAIL AND YOU SOAR AWAY TOWARDS THE",$0d,"CRYSTAL MOUNTAINS..."
        dc.b $0d,0
m26
        dc.b $11,"YOU JUMP... AND FIND OUT THAT STRONKIE",$0d,"HAS VERY STRONG GRAVITY."
        dc.b $0d,0
m27
        dc.b $11,"YOU NEED TO BE UP HIGH. THE LOOKOUT",$0d,"TOWER!",$0d,0
m28
        dc.b $11,"SOMETHING SHINES IN THE FOUNTAIN.",$0d,0
m29
        dc.b $11,"BUY SOMETHING AT THE MARKET WITH THE",$0d,"COIN.",$0d,0
m30
        dc.b $11,"LISTEN TO THE SHELL.",$0d,0
m31
        dc.b $11,"TALK TO THE ELDER IN HIS HUT.",$0d,0
m32
        dc.b $11,"TALK TO BIX IN THE WORKSHOP.",$0d,0
m33
        dc.b $11,"THE BANNER ON THE TOWER WOULD MAKE A",$0d,"FINE SAIL.",$0d,0
m34
        dc.b $11,"GIVE THE BANNER TO BIX.",$0d,0
m35
        dc.b $11,"FLY THE GLIDER FROM THE LOOKOUT TOWER.",$0d,0
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
t_intro
        dc.b $11,"THE STRONKIES LIVE IN ROUND HUTS AMONG",$0d,"THE GIANT TREES. EVERYWHERE SMALL BLUE"
        dc.b $0d,"FACES PEEK AT YOU AND CHIRP EXCITEDLY.",$0d,"YOU CANNOT UNDERSTAND A WORD THEY SAY."
        dc.b $0d,$0d,0
t_title
        dc.b $17,$0d,"CHAPTER 6: THE VILLAGE",$0d,$0d,0
t_short
        dc.b "CHAPTER 6",0
t_quip
        dc.b $17,"ELDER ZOOMA SIGHS. HE HAD SUCH HIGH",$0d,"HOPES FOR YOU.",$0d
        dc.b 0
d1
        dc.b $1d,"YOU ARE IN THE VILLAGE SQUARE. A",$0d,"FOUNTAIN SPLASHES IN THE MIDDLE. THE"
        dc.b $0d,"MARKET IS EAST, A WORKSHOP WEST AND THE",$0d,"ELDER'S HUT NORTH. A LOOKOUT TOWER"
        dc.b $0d,"RISES TO THE SOUTH.",$0d,0
d2
        dc.b $1d,"YOU ARE AT THE MARKET. STALLS ARE PILED",$0d,"HIGH WITH FRUIT, SHELLS AND SHINY"
        dc.b $0d,"STONES. AN OLD TRADER WITH A LONG BEARD",$0d,"WAVES AT YOU."
        dc.b $0d,0
d3
        dc.b $1d,"YOU ARE INSIDE THE ELDER'S HUT. AN",$0d,"ANCIENT STRONKIE WITH WHITE FUR SITS ON"
        dc.b $0d,"A CUSHION, SURROUNDED BY SCROLLS.",$0d,0
d4
        dc.b $1d,"YOU ARE IN A WORKSHOP FULL OF GEARS,",$0d,"SPRINGS AND HALF-BUILT FLYING MACHINES."
        dc.b $0d,"A YOUNG STRONKIE WITH GOGGLES IS",$0d,"TINKERING.",$0d,0
d5
        dc.b $1d,"YOU ARE ON TOP OF THE LOOKOUT TOWER.",$0d,"FAR AWAY ON A SNOWY MOUNTAIN SHINES A"
        dc.b $0d,"TEMPLE. NEAR IT ARE BLACK TENTS AND A",$0d,"DARK SHIP! A BIG BANNER FLAPS ON A POLE"
        dc.b $0d,"BESIDE YOU.",$0d,0
t0
        dc.b 0
t1
        dc.b $11,"CLEAR WATER SPLASHES INTO A STONE BOWL.",$0d,"SOMETHING SHINES AT THE BOTTOM."
        dc.b $0d,0
t2
        dc.b $11,"SMALL, BLUE AND FURRY, WITH LONG EARS",$0d,"AND BIG FRIENDLY EYES."
        dc.b $0d,0
t3
        dc.b "A SHINY COIN",0
t4
        dc.b $11,"A HEAVY COIN WITH A STAR ON IT.",$0d,0
t5
        dc.b $11,"HE POINTS AT HIS SHELLS AND RUBS HIS",$0d,"FINGERS TOGETHER."
        dc.b $0d,0
t6
        dc.b $11,"ONE SHELL ON THE STALL SEEMS TO BE",$0d,"SINGING QUIETLY.",$0d
        dc.b 0
t7
        dc.b "A SINGING SHELL",0
t8
        dc.b $11,"A SPIRAL SHELL THAT HUMS SOFTLY. MAYBE",$0d,"LISTEN TO IT?"
        dc.b $0d,0
t9
        dc.b $11,"HE IS VERY OLD AND VERY WISE. HIS EYES",$0d,"TWINKLE.",$0d,0
t10
        dc.b $11,"DRAWINGS OF A TEMPLE ON A MOUNTAIN, AND",$0d,"A SHINING CRYSTAL HEART. ONE SCROLL"
        dc.b $0d,"HOLDS ZOOMA'S MOST POWERFUL SPELL:",$0d,"LOAD",$22,"$",$22,",8 - NOBODY KNOWS WHAT IT DOES,"
        dc.b $0d,"BUT IT TAKES A VERY LONG TIME.",$0d,0
t11
        dc.b "A MAP OF THE MOUNTAINS",0
t12
        dc.b $11,"IT SHOWS THE WAY TO THE SKY TEMPLE. THE",$0d,"BRIDGE ON THE ROAD IS BROKEN."
        dc.b $0d,0
t13
        dc.b $11,"A YOUNG STRONKIE WITH OIL ON HIS NOSE",$0d,"AND HUGE GOGGLES."
        dc.b $0d,0
t14
        dc.b $11,"ONE OF THEM IS A GLIDER WITHOUT A SAIL.",$0d,0
t15
        dc.b "A GLIDER",0
t16
        dc.b $11,"LIGHT WOODEN WINGS WITH YOUR BANNER AS",$0d,"A SAIL.",$0d,0
t17
        dc.b "A BIG BANNER",0
t18
        dc.b $11,"A HUGE BANNER OF STRONG CLOTH.",$0d,0
t19
        dc.b $11,"THE SKY TEMPLE, HIGH ON THE CRYSTAL",$0d,"MOUNTAINS. THE DARK SHIP MUST BE VEX'S."
        dc.b $0d,0
t20
        dc.b $11,"AN OLD BIRD'S NEST SITS AT THE TOP OF",$0d,"THE POLE.",$0d,0
t21
        dc.b "A PAIR OF GROUCHO NOSE GLASSES",0
t22
        dc.b $11,"PLASTIC GLASSES WITH A BIG NOSE AND A",$0d,"MOUSTACHE. A LABEL SAYS: AS WORN BY ZAK"
        dc.b $0d,"MCKRACKEN.",$0d,0
t_save
        dc.b "SAVE1-VILLAGE",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$54,$48,$45,$20,$56,$49,$4c,$4c,$41,$47,$45,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$03,$45
        dc.b $4c,$44,$45,$52,$27,$53,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$04,$57,$4f,$52,$4b
        dc.b $53,$48,$4f,$50,$0e,$60,$60,$60,$01,$53,$51,$55,$41,$52,$45,$0e,$60,$60,$60,$60,$02,$4d,$41,$52,$4b,$45,$54,$0e,$0d,$1f,$20,$20
        dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$05,$54,$4f,$57,$45
        dc.b $52,$0e,$0d,$00
        even
song
        dc.w 3                  ; voices
        dc.b $10,$0a,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $10,$2a,$89,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$05,$40,$04     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $1e,$1c,$25,$1c,$1e,$1c,$25,$1c,$17,$1c,$1e,$1c,$17,$1c,$1e,$1c,$19,$1c,$20,$1c,$19,$1c,$20,$1c,$1e,$1c,$25,$1c,$1e,$38,$1e,$1c
        dc.b $25,$1c,$1e,$1c,$25,$1c,$17,$1c,$1e,$1c,$17,$1c,$1e,$1c,$19,$1c,$20,$1c,$19,$1c,$20,$1c,$1e,$1c,$25,$1c,$1e,$38,$ff
song_v2
        dc.b $3a,$1c,$3d,$1c,$42,$2a,$41,$0e,$3f,$1c,$3d,$1c,$3b,$38,$38,$1c,$3a,$1c,$3b,$1c,$3d,$1c,$3a,$38,$00,$38,$3d,$1c,$3f,$1c,$3d,$1c
        dc.b $3a,$1c,$3b,$1c,$3a,$1c,$38,$38,$35,$1c,$38,$1c,$3d,$1c,$3b,$1c,$3a,$54,$00,$1c,$ff
song_v3
        dc.b $36,$0e,$3a,$0e,$3d,$0e,$3a,$0e,$36,$0e,$3a,$0e,$3d,$0e,$3a,$0e,$2f,$0e,$33,$0e,$36,$0e,$33,$0e,$2f,$0e,$33,$0e,$36,$0e,$33,$0e
        dc.b $31,$0e,$35,$0e,$38,$0e,$35,$0e,$31,$0e,$35,$0e,$38,$0e,$35,$0e,$36,$0e,$3a,$0e,$3d,$0e,$3a,$0e,$36,$0e,$3a,$0e,$3d,$0e,$3a,$0e
        dc.b $36,$0e,$3a,$0e,$3d,$0e,$3a,$0e,$36,$0e,$3a,$0e,$3d,$0e,$3a,$0e,$2f,$0e,$33,$0e,$36,$0e,$33,$0e,$2f,$0e,$33,$0e,$36,$0e,$33,$0e
        dc.b $31,$0e,$35,$0e,$38,$0e,$35,$0e,$31,$0e,$35,$0e,$38,$0e,$35,$0e,$36,$0e,$3a,$0e,$3d,$0e,$3a,$0e,$36,$0e,$3a,$0e,$3d,$0e,$3a,$0e
        dc.b $ff
        even
actors                               ; moving sprites per room
;       room, sprites, first image, images, image delay, move delay, dx, dy
;       x, y (C64 sprite coordinates), height in lines, colours 1-3
        dc.b 1,1,0,2,6,2,1,1
        dc.w 144,63,7,$112,$335,$fd6
        dc.b 2,1,2,2,6,2,-1,1
        dc.w 224,61,7,$112,$335,$fd6
        dc.b 5,1,4,2,6,2,1,1
        dc.w 64,65,7,$112,$335,$fd6
        dc.b 0
        even
frames                               ; offsets of the sprite images
        dc.l fr0-base
        dc.l fr1-base
        dc.l fr2-base
        dc.l fr3-base
        dc.l fr4-base
        dc.l fr5-base
fr0                              ; "bird1": 1 sprite(s), 7 lines
        dc.w $c006,$0000,$600c,$0000,$3838,$0000,$1e78,$0080,$06f8,$0118,$01c0,$0000,$0000,$0000
fr1                              ; "bird2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$0000,$0000,$0600,$0080,$7ef0,$0110,$fffc,$000c,$01c0,$0000,$0000,$0000
fr2                              ; "bird1": 1 sprite(s), 7 lines
        dc.w $c006,$0000,$600c,$0000,$3838,$0000,$1e78,$0080,$06f8,$0118,$01c0,$0000,$0000,$0000
fr3                              ; "bird2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$0000,$0000,$0600,$0080,$7ef0,$0110,$fffc,$000c,$01c0,$0000,$0000,$0000
fr4                              ; "bird1": 1 sprite(s), 7 lines
        dc.w $c006,$0000,$600c,$0000,$3838,$0000,$1e78,$0080,$06f8,$0118,$01c0,$0000,$0000,$0000
fr5                              ; "bird2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$0000,$0000,$0600,$0080,$7ef0,$0110,$fffc,$000c,$01c0,$0000,$0000,$0000
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 0
card                                 ; next part: kind, name, spoken title (in the blob)
        dc.l card_k-base,card_n-base
        dc.l $0152d2             ; "Chapter 7. The Crystal Mountains"
card_k
        dc.b "CHAPTER 7",0
card_n
        dc.b "THE CRYSTAL MOUNTAINS",0
        even
        even
part_end
