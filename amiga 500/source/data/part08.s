;======================================================================
;  THE WORLD OF STRONKIE V2.0 (Amiga) - CHAPTER 5: LANDFALL
;  Created By Mark Stronks
;
;  Part file "PART08": vasm -Fbin -o part08.bin part08.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_WRECK       = $000000      ; picture "wreck" in the blob
PIC_CRASH       = $003d00      ; picture "crash" in the blob
PIC_JUNGLE      = $0076d8      ; picture "jungle" in the blob
PIC_RIVER       = $00e28e      ; picture "river" in the blob
PIC_CCAVE       = $01248c      ; picture "ccave" in the blob
PIC_VGATE       = $017818      ; picture "vgate" in the blob

base
        dc.b "CHAP"
        dc.b 8,1,6,18       ; part, start room, rooms, objects
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
        dc.l tune-base            ; jingle (TUNE action)
        dc.b 5,4
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_WRECK
        dc.b 0,0,0,0,0,0,0,0      ; wreck
        dc.l d2-base,PIC_CRASH
        dc.b 0,0,6,1,0,0,0,0      ; crash
        dc.l d3-base,PIC_JUNGLE
        dc.b 0,2,4,0,0,0,0,0      ; jungle
        dc.l d4-base,PIC_RIVER
        dc.b 0,0,0,3,0,0,0,0      ; river
        dc.l d5-base,PIC_CCAVE
        dc.b 0,0,0,4,0,0,0,0      ; cave
        dc.l d6-base,PIC_VGATE
        dc.b 0,0,0,2,0,0,0,0      ; gate
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,1,2,0
        dc.l t0-base,t1-base
        dc.b 2,1,2,0
        dc.l t0-base,t2-base
        dc.b 3,1,2,0
        dc.l t0-base,t3-base
        dc.b 4,1,1,0
        dc.l t4-base,t5-base
        dc.b 5,2,2,0
        dc.l t0-base,t6-base
        dc.b 6,2,2,0
        dc.l t0-base,t7-base
        dc.b 7,3,1,0
        dc.l t8-base,t9-base
        dc.b 8,3,2,0
        dc.l t0-base,t10-base
        dc.b 9,4,2,0
        dc.l t0-base,t11-base
        dc.b 10,4,2,0
        dc.l t0-base,t12-base
        dc.b 11,5,2,0
        dc.l t0-base,t13-base
        dc.b 11,0,1,0
        dc.l t14-base,t15-base
        dc.b 12,5,2,0
        dc.l t0-base,t16-base
        dc.b 13,6,2,0
        dc.l t0-base,t17-base
        dc.b 14,6,2,0
        dc.l t0-base,t18-base
        dc.b 15,3,2,0
        dc.l t0-base,t19-base
        dc.b 16,0,1,0
        dc.l t20-base,t21-base
        dc.b 17,5,2,0
        dc.l t0-base,t22-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "LEVE",1
        dc.b "HATC",2
        dc.b "DOOR",2
        dc.b "CONS",3
        dc.b "SPAR",3
        dc.b "SLOT",3
        dc.b "EXTI",4
        dc.b "FIRE",5
        dc.b "FLAM",5
        dc.b "ENGI",5
        dc.b "SUNS",6
        dc.b "SUN ",6
        dc.b "SKY ",6
        dc.b "FRUI",7
        dc.b "BRAN",8
        dc.b "BIRD",8
        dc.b "LEAV",8
        dc.b "TREE",9
        dc.b "VINE",9
        dc.b "RIVE",10
        dc.b "WATE",10
        dc.b "CRYS",11
        dc.b "ROCK",12
        dc.b "GUAR",13
        dc.b "CREA",13
        dc.b "STRO",13
        dc.b "GATE",14
        dc.b "WALL",14
        dc.b "BUSH",15
        dc.b "ROOT",15
        dc.b "MONK",16
        dc.b "DIAM",17
        dc.b "BOUL",17
        dc.b "CAVE",18
        dc.b "JUNG",19
        dc.b "VILL",20
        dc.b "NOVA",21
        dc.b "LAMP",22
        dc.b "FORC",23
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $09,$11,$08,$04,$05,$20,$01,$00
        dc.b $1c,$0f,$11,$04,$03,$06,$00,$20,$02,$23,$11,$03,$21,$00,$2b,$0d,$00
        dc.b $0c,$0f,$11,$04,$03,$06,$00,$20,$02,$23,$11,$03,$21,$00,$2b,$0d,$00
        dc.b $08,$0f,$11,$04,$03,$06,$00,$20,$02,$23,$11,$03,$21,$00,$2b,$0d,$00
        dc.b $09,$10,$16,$01,$11,$06,$01,$20,$03,$23,$11,$ff,$21,$01,$26,$0a,$2e,$f4,$72,$21,$3c,$00
        dc.b $1c,$0f,$08,$04,$03,$20,$04,$00
        dc.b $20,$10,$08,$02,$11,$20,$05,$00
        dc.b $0c,$0c,$0d,$04,$05,$06,$02,$20,$06,$21,$02,$2c,$00
        dc.b $1c,$0c,$0d,$04,$05,$06,$02,$20,$06,$21,$02,$2c,$00
        dc.b $08,$0c,$0d,$04,$05,$06,$02,$20,$06,$21,$02,$2c,$00
        dc.b $13,$01,$0a,$04,$01,$05,$03,$20,$07,$00
        dc.b $13,$01,$14,$04,$01,$20,$08,$21,$03,$25,$01,$02,$02,$26,$0a,$2b,$09,$2d,$04,$00
        dc.b $04,$00,$0a,$04,$01,$06,$03,$20,$09,$00
        dc.b $0d,$02,$0a,$04,$01,$06,$03,$20,$0a,$00
        dc.b $20,$00,$0a,$04,$06,$06,$04,$20,$0b,$00
        dc.b $20,$00,$08,$06,$05,$20,$0c,$00
        dc.b $20,$00,$06,$20,$0d,$00
        dc.b $02,$00,$0a,$04,$02,$06,$06,$20,$0e,$00
        dc.b $0f,$04,$16,$04,$02,$02,$04,$06,$06,$20,$0f,$21,$06,$25,$02,$00,$03,$26,$0a,$2b,$06,$00
        dc.b $3a,$04,$16,$04,$02,$02,$04,$06,$06,$20,$0f,$21,$06,$25,$02,$00,$03,$26,$0a,$2b,$06,$00
        dc.b $3a,$05,$16,$04,$02,$02,$04,$06,$06,$20,$0f,$21,$06,$25,$02,$00,$03,$26,$0a,$2b,$06,$00
        dc.b $3a,$05,$16,$04,$02,$02,$04,$06,$06,$20,$0f,$21,$06,$25,$02,$00,$03,$26,$0a,$2b,$06,$00
        dc.b $3a,$00,$16,$04,$02,$02,$04,$06,$06,$20,$0f,$21,$06,$25,$02,$00,$03,$26,$0a,$2b,$06,$00
        dc.b $3a,$00,$0a,$04,$02,$06,$06,$20,$10,$00
        dc.b $36,$05,$08,$04,$02,$20,$11,$00
        dc.b $1e,$07,$08,$01,$07,$20,$12,$00
        dc.b $1b,$09,$10,$04,$04,$06,$07,$20,$13,$21,$07,$24,$05,$26,$05,$00
        dc.b $41,$09,$10,$04,$04,$06,$07,$20,$13,$21,$07,$24,$05,$26,$05,$00
        dc.b $09,$09,$10,$04,$04,$06,$07,$20,$13,$21,$07,$24,$05,$26,$05,$00
        dc.b $13,$09,$10,$04,$04,$06,$07,$20,$13,$21,$07,$24,$05,$26,$05,$00
        dc.b $0f,$09,$10,$04,$04,$06,$07,$20,$13,$21,$07,$24,$05,$26,$05,$00
        dc.b $1b,$09,$0a,$04,$04,$20,$14,$24,$05,$00
        dc.b $41,$09,$0a,$04,$04,$20,$14,$24,$05,$00
        dc.b $09,$09,$0a,$04,$04,$20,$14,$24,$05,$00
        dc.b $13,$09,$0a,$04,$04,$20,$14,$24,$05,$00
        dc.b $0f,$09,$0a,$04,$04,$20,$14,$24,$05,$00
        dc.b $41,$00,$10,$04,$04,$06,$07,$20,$13,$21,$07,$24,$05,$26,$05,$00
        dc.b $41,$00,$0a,$04,$04,$20,$14,$24,$05,$00
        dc.b $01,$12,$10,$04,$04,$06,$07,$20,$13,$21,$07,$24,$05,$26,$05,$00
        dc.b $01,$12,$0a,$04,$04,$20,$14,$24,$05,$00
        dc.b $04,$00,$10,$04,$04,$06,$07,$20,$13,$21,$07,$24,$05,$26,$05,$00
        dc.b $04,$00,$0a,$04,$04,$20,$14,$24,$05,$00
        dc.b $31,$00,$09,$04,$04,$20,$15,$29,$00
        dc.b $01,$0a,$09,$04,$04,$20,$16,$29,$00
        dc.b $09,$0b,$0a,$04,$05,$06,$08,$20,$17,$00
        dc.b $28,$0b,$1a,$04,$05,$02,$04,$06,$08,$20,$18,$23,$0b,$00,$23,$0c,$05,$21,$08,$26,$0a,$2b,$08,$2d,$02,$00
        dc.b $1d,$0b,$1a,$04,$05,$02,$04,$06,$08,$20,$18,$23,$0b,$00,$23,$0c,$05,$21,$08,$26,$0a,$2b,$08,$2d,$02,$00
        dc.b $0f,$0b,$1a,$04,$05,$02,$04,$06,$08,$20,$18,$23,$0b,$00,$23,$0c,$05,$21,$08,$26,$0a,$2b,$08,$2d,$02,$00
        dc.b $0f,$04,$18,$04,$05,$06,$08,$20,$18,$23,$0b,$00,$23,$0c,$05,$21,$08,$26,$0a,$2b,$08,$2d,$02,$00
        dc.b $28,$0b,$0a,$04,$05,$06,$08,$20,$19,$00
        dc.b $0a,$0b,$13,$04,$01,$02,$0c,$20,$1a,$23,$0c,$00,$21,$05,$26,$0a,$2b,$0d,$00
        dc.b $0f,$0b,$13,$04,$01,$02,$0c,$20,$1a,$23,$0c,$00,$21,$05,$26,$0a,$2b,$0d,$00
        dc.b $3e,$0b,$13,$04,$01,$02,$0c,$20,$1a,$23,$0c,$00,$21,$05,$26,$0a,$2b,$0d,$00
        dc.b $3e,$00,$0a,$04,$01,$06,$05,$20,$1b,$00
        dc.b $04,$00,$0a,$04,$06,$06,$04,$20,$1c,$00
        dc.b $04,$00,$0a,$04,$06,$06,$05,$20,$1d,$00
        dc.b $04,$00,$0c,$04,$06,$20,$1e,$26,$05,$27,$09,$00
        dc.b $01,$14,$10,$04,$06,$05,$04,$05,$05,$20,$1e,$26,$05,$27,$09,$00
        dc.b $1a,$07,$13,$04,$06,$02,$07,$20,$1f,$23,$07,$00,$21,$04,$26,$0a,$2b,$06,$00
        dc.b $40,$07,$13,$04,$06,$02,$07,$20,$1f,$23,$07,$00,$21,$04,$26,$0a,$2b,$06,$00
        dc.b $0a,$07,$13,$04,$06,$02,$07,$20,$1f,$23,$07,$00,$21,$04,$26,$0a,$2b,$06,$00
        dc.b $1d,$0d,$08,$04,$06,$20,$20,$00
        dc.b $37,$00,$08,$06,$03,$20,$21,$00
        dc.b $37,$00,$0a,$03,$04,$06,$06,$20,$22,$00
        dc.b $37,$00,$08,$06,$06,$20,$23,$00
        dc.b $37,$00,$08,$06,$07,$20,$24,$00
        dc.b $37,$00,$0a,$06,$08,$03,$04,$20,$25,$00
        dc.b $37,$00,$08,$06,$08,$20,$26,$00
        dc.b $37,$00,$0a,$06,$05,$03,$0c,$20,$27,$00
        dc.b $37,$00,$08,$06,$05,$20,$28,$00
        dc.b $37,$00,$0a,$06,$04,$03,$07,$20,$29,$00
        dc.b $37,$00,$08,$06,$04,$20,$2a,$00
        dc.b $37,$00,$06,$20,$2b,$00
        dc.b $45,$00,$06,$20,$2c,$00
        dc.b $46,$00,$06,$20,$2d,$00
        dc.b $47,$00,$06,$20,$2e,$00
        dc.b $0f,$17,$06,$20,$2f,$00
        dc.b $09,$16,$06,$20,$30,$00
        dc.b $22,$00,$06,$20,$31,$00
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
        dc.l m44-base
        dc.l m45-base
        dc.l m46-base
        dc.l m47-base
        dc.l m48-base
        dc.l m49-base
m1
        dc.b $11,"THE BOULDER ABOVE THEM WOBBLES. YOU",$0d,"HAVE PLAYED BOULDER DASH BEFORE, SO YOU"
        dc.b $0d,"LEAVE THE DIAMONDS ALONE.",$0d,0
m2
        dc.b $11,"YOU PUSH THE BUSHES APART. PEEKING OUT",$0d,"BETWEEN THE ROOTS IS... A SMALL WOODEN"
        dc.b $0d,"MONKEY! WHAT IS THAT DOING ON THIS",$0d,"PLANET?",$0d,0
m3
        dc.b $11,"YOU PICK UP THE WOODEN MONKEY. FROM OUT",$0d,"OF NOWHERE A JAUNTY CARIBBEAN TUNE"
        dc.b $0d,"STARTS TO PLAY... CARVED UNDER ITS",$0d,"FEET: 'MADE BY MARK STRONKS AKA"
        dc.b $0d,"STRONKIE. THIS IS NOT THE SECRET OF",$0d,"MONKEY ISLAND.'",$0d
        dc.b 0
m4
        dc.b $11,"JUST LEAVES AND ROOTS NOW.",$0d,0
m5
        dc.b $11,"THE WOODEN MONKEY JUST GRINS. FOR A",$0d,"MOMENT YOU THINK IT WINKED."
        dc.b $0d,0
m6
        dc.b $11,"BETWEEN THE SMALL CRYSTALS IN THE ROCK",$0d,"SOMETHING GLITTERS... A TINY PIECE OF"
        dc.b $0d,"STARLIGHT!",$0d,0
m7
        dc.b $11,"THE HATCH IS ALREADY OPEN.",$0d,0
m8
        dc.b $11,"YOU HEAVE ON THE LEVER. BANG! EXPLOSIVE",$0d,"BOLTS BLOW THE HATCH OPEN."
        dc.b $0d,0
m9
        dc.b $11,"THE HATCH IS JAMMED.",$0d,0
m10
        dc.b $11,"IT IS JAMMED SHUT. MAYBE THE EMERGENCY",$0d,"LEVER WILL HELP."
        dc.b $0d,0
m11
        dc.b $11,"THE GUARD CHIRPS SOMETHING AND RUBS HIS",$0d,"TUMMY.",$0d,0
m12
        dc.b $13,"NOVA: 'I NEED A NEW POWER CRYSTAL,",$0d,"PILOT. THIS PLANET SEEMS TO BE FULL OF"
        dc.b $0d,"THEM.'",$0d,0
m13
        dc.b $13,"NOVA: 'REPAIRS ARE UNDER WAY. GO AND",$0d,"MAKE FRIENDS, PILOT.'"
        dc.b $0d,0
m14
        dc.b $11,"THE FLAMES ARE MUCH TOO HOT. YOU CANNOT",$0d,"GET PAST.",$0d
        dc.b 0
m15
        dc.b $11,"WHOOSH! A CLOUD OF WHITE FOAM SMOTHERS",$0d,"THE FLAMES. THE PATH NORTH INTO THE"
        dc.b $0d,"JUNGLE IS CLEAR.",$0d,0
m16
        dc.b $11,"WITH WHAT? YOUR BARE HANDS?",$0d,0
m17
        dc.b $11,"OUCH! THAT WAS HOT.",$0d,0
m18
        dc.b $11,"YOU ARE NOT HUNGRY. MAYBE SOMEONE ELSE",$0d,"WOULD LIKE IT."
        dc.b $0d,0
m19
        dc.b $11,"YOU GRAB THE VINE, TAKE A RUN... AND",$0d,"SWING ACROSS THE GLOWING RIVER! YOU"
        dc.b $0d,"LAND RIGHT IN FRONT OF THE CAVE.",$0d,0
m20
        dc.b $11,"WHEEE! YOU SWING ACROSS THE RIVER ONCE",$0d,"MORE.",$0d,0
m21
        dc.b $11,"YOU JUMP INTO THE GLOWING RIVER. THE",$0d,"CURRENT SWEEPS YOU AWAY IN SECONDS..."
        dc.b $0d,0
m22
        dc.b $11,"YOU WADE INTO THE GLOWING RIVER. THE",$0d,"CURRENT SWEEPS YOU AWAY IN SECONDS..."
        dc.b $0d,0
m23
        dc.b $11,"IT IS STUCK FAST IN THE ROCK.",$0d,0
m24
        dc.b $11,"YOU SLAM THE HEAVY EXTINGUISHER AGAINST",$0d,"THE ROCK. CRACK! THE POWER CRYSTAL"
        dc.b $0d,"COMES LOOSE.",$0d,0
m25
        dc.b $11,"YOUR BARE HANDS ARE NO MATCH FOR THE",$0d,"ROCK. YOU NEED SOMETHING HEAVY."
        dc.b $0d,0
m26
        dc.b $11,"YOU SLOT THE POWER CRYSTAL INTO THE",$0d,"CONSOLE. THE SHIP HUMS BACK TO LIFE!"
        dc.b $0d,"NOVA: 'THANK YOU, PILOT. THE REPAIRS",$0d,"WILL TAKE A WHILE. I DETECT LIFE SIGNS"
        dc.b $0d,"TO THE EAST.'",$0d,0
m27
        dc.b $11,"YOU NEED A NEW POWER CRYSTAL FIRST.",$0d,0
m28
        dc.b $11,"THE GUARD POINTS HIS SPEAR AT YOU AND",$0d,"CHIRPS ANGRILY."
        dc.b $0d,0
m29
        dc.b $13,"NOVA ON YOUR RADIO: 'PILOT, FIRST FIND",$0d,"A POWER CRYSTAL FOR THE SHIP, PLEASE!'"
        dc.b $0d,0
m30
        dc.b $11,"YOU FOLLOW THE LITTLE GUARD THROUGH THE",$0d,"GATE, INTO THE VILLAGE OF THE"
        dc.b $0d,"STRONKIES...",$0d,0
m31
        dc.b $11,"THE GUARD SNIFFS THE BLUE FRUIT, TAKES",$0d,"A HUGE BITE AND GRINS FROM EAR TO EAR."
        dc.b $0d,"HE OPENS THE GATE AND WAVES YOU IN.",$0d,0
m32
        dc.b $11,"HE IS SMALL, BUT HIS SPEAR IS SHARP.",$0d,"BETTER MAKE FRIENDS."
        dc.b $0d,0
m33
        dc.b $11,"PULL THE EMERGENCY LEVER.",$0d,0
m34
        dc.b $11,"TAKE THE FIRE EXTINGUISHER FROM THE",$0d,"COCKPIT.",$0d,0
m35
        dc.b $11,"PUT OUT THE FIRE WITH THE EXTINGUISHER.",$0d,0
m36
        dc.b $11,"SWING ACROSS THE RIVER ON THE VINE.",$0d,0
m37
        dc.b $11,"YOU NEED SOMETHING HEAVY TO BREAK THE",$0d,"CRYSTAL LOOSE."
        dc.b $0d,0
m38
        dc.b $11,"BREAK THE CRYSTAL LOOSE WITH THE",$0d,"EXTINGUISHER.",$0d,0
m39
        dc.b $11,"TAKE THE POWER CRYSTAL.",$0d,0
m40
        dc.b $11,"PUT THE CRYSTAL INTO THE CONSOLE OF THE",$0d,"SHIP.",$0d,0
m41
        dc.b $11,"THE GUARD LOOKS HUNGRY. FRUIT GROWS IN",$0d,"THE JUNGLE.",$0d
        dc.b 0
m42
        dc.b $11,"GIVE THE FRUIT TO THE GUARD.",$0d,0
m43
        dc.b $11,"GO EAST THROUGH THE GATE.",$0d,0
m44
        dc.b $11,"A HOLLOW VOICE SAYS: WRONG GAME. THIS",$0d,"ISN'T COLOSSAL CAVE."
        dc.b $0d,0
m45
        dc.b $11,"GOD MODE? NICE TRY. THIS IS A COMMODORE",$0d,"64, NOT A 486."
        dc.b $0d,0
m46
        dc.b $11,"THAT'S THE ANSWER TO LIFE, THE UNIVERSE",$0d,"AND EVERYTHING. BUT WHAT WAS THE"
        dc.b $0d,"QUESTION?",$0d,0
m47
        dc.b $11,"YOU WAVE YOUR HAND. THESE AREN'T THE",$0d,"COMMANDS YOU'RE LOOKING FOR."
        dc.b $0d,0
m48
        dc.b $11,"THERE IS NO LAMP HERE. THIS ISN'T ZORK,",$0d,"YOU KNOW. BUT WATCH OUT FOR GRUES"
        dc.b $0d,"ANYWAY.",$0d,0
m49
        dc.b $11,"TYPE COMMANDS LIKE TAKE KEY, OPEN DOOR,",$0d,"EXAMINE MAT, N S E W U D, L = LOOK,"
        dc.b $0d,"I = INVENTORY, TAKE ALL, DROP ALL,",$0d,"G = AGAIN, SCORE, MAP, SAVE, LOAD, QUIT"
        dc.b $0d,"F1 LOAD  F3 SAVE  F5 MUSIC  F7 QUIT",$0d,"THREE SAVE SLOTS: PRESS 1, 2 OR 3."
        dc.b $0d,"HINT GIVES A CLUE BUT COSTS 3 POINTS.",$0d,"FIND THE 16 HIDDEN STAR FRAGMENTS!"
        dc.b $0d,0
t_intro
        dc.b $11,"LECHUCKLE'S PARTING SHOT HAS DONE ITS",$0d,"WORK. THE STARRAVEN DIVES THROUGH"
        dc.b $0d,"PURPLE CLOUDS. ALARMS SCREAM, THE",$0d,"ENGINES COUGH... AND WITH A TERRIBLE"
        dc.b $0d,"CRASH YOU LAND ON THE WORLD OF",$0d,"STRONKIE. NOVA: 'MAIN POWER CRYSTAL"
        dc.b $0d,"SHATTERED. PILOT, I NEED A NEW POWER",$0d,"CRYSTAL TO REPAIR THE SHIP.'"
        dc.b $0d,$0d,0
t_title
        dc.b $17,$0d,"CHAPTER 5: LANDFALL",$0d,$0d,0
t_short
        dc.b "CHAPTER 5",0
t_quip
        dc.b $17,"THE STRONKIES WILL TELL STORIES ABOUT",$0d,"THE CLUMSY ALIEN FOR YEARS."
        dc.b $0d,0
d1
        dc.b $1d,"YOU ARE IN THE WRECKED COCKPIT OF THE",$0d,"STARRAVEN. SPARKS FLY FROM THE CONSOLE."
        dc.b $0d,"THE HATCH IS JAMMED SHUT. A RED",$0d,"EMERGENCY LEVER HANGS BESIDE IT."
        dc.b $0d,0
d2
        dc.b $1d,"YOU STAND BESIDE THE SMOKING WRECK OF",$0d,"THE STARRAVEN IN A FIELD OF PURPLE"
        dc.b $0d,"GRASS UNDER TWO SUNS. FLAMES FROM THE",$0d,"ENGINE BLOCK THE PATH NORTH. A PATH"
        dc.b $0d,"LEADS EAST.",$0d,0
d3
        dc.b $1d,"YOU ARE IN A JUNGLE OF GIANT PURPLE",$0d,"TREES. STRANGE BIRDS SING. THICK BUSHES"
        dc.b $0d,"GROW BETWEEN THE ROOTS. HEAVY BLUE",$0d,"FRUIT HANGS FROM A LOW BRANCH. THE PATH"
        dc.b $0d,"LEADS EAST TO A RIVER.",$0d,0
d4
        dc.b $1d,"YOU STAND BY A WIDE, FAST RIVER OF",$0d,"GLOWING WATER. A TALL TREE LEANS OVER"
        dc.b $0d,"IT WITH A LONG VINE. ON THE FAR BANK IS",$0d,"A CAVE.",$0d,0
d5
        dc.b $1d,"YOU ARE IN A CAVE FULL OF GLOWING",$0d,"CRYSTALS. IN THE MIDDLE ONE BIG CRYSTAL"
        dc.b $0d,"PULSES WITH LIGHT. A VINE HANGS BACK",$0d,"ACROSS THE RIVER TO THE WEST. IN A"
        dc.b $0d,"CORNER, A PILE OF DIAMONDS LIES UNDER A",$0d,"BIG BOULDER."
        dc.b $0d,0
d6
        dc.b $1d,"YOU STAND BEFORE A GATE IN A WALL OF",$0d,"WOVEN BRANCHES. A SMALL BLUE CREATURE"
        dc.b $0d,"WITH LONG EARS GUARDS IT WITH A SPEAR.",$0d,0
t0
        dc.b 0
t1
        dc.b $11,"EMERGENCY HATCH RELEASE. PULL IN CASE",$0d,"OF CRASH.",$0d,0
t2
        dc.b $11,"BENT AND JAMMED SHUT.",$0d,0
t3
        dc.b $11,"THE EMPTY POWER CRYSTAL SLOT IS BLACK",$0d,"AND BURNT.",$0d,0
t4
        dc.b "A FIRE EXTINGUISHER",0
t5
        dc.b $11,"A HEAVY RED FIRE EXTINGUISHER.",$0d,0
t6
        dc.b $11,"THE BROKEN ENGINE IS BURNING FIERCELY.",$0d,0
t7
        dc.b $11,"ONE SUN IS ORANGE, THE OTHER BLUE. YOU",$0d,"ARE A LONG WAY FROM HOME."
        dc.b $0d,0
t8
        dc.b "A BLUE FRUIT",0
t9
        dc.b $11,"A HEAVY BLUE FRUIT. IT SMELLS SWEET.",$0d,0
t10
        dc.b $11,"THE TREES ARE AS TALL AS CHURCHES.",$0d,"THEIR LEAVES ARE PURPLE."
        dc.b $0d,0
t11
        dc.b $11,"A LONG, STRONG VINE HANGS FROM THE",$0d,"TREE, OUT OVER THE WATER."
        dc.b $0d,0
t12
        dc.b $11,"THE WATER GLOWS AND RUSHES PAST MUCH",$0d,"TOO FAST TO SWIM."
        dc.b $0d,0
t13
        dc.b $11,"A BIG POWER CRYSTAL, STUCK FAST IN THE",$0d,"ROCK.",$0d,0
t14
        dc.b "A POWER CRYSTAL",0
t15
        dc.b $11,"IT HUMS AND GLOWS. JUST WHAT THE SHIP",$0d,"NEEDS.",$0d,0
t16
        dc.b $11,"SMALL CRYSTALS GROW EVERYWHERE IN THE",$0d,"ROCK.",$0d,0
t17
        dc.b $11,"A SMALL BLUE STRONKIE WITH LONG EARS.",$0d,"HE KEEPS LOOKING HUNGRILY AT THE"
        dc.b $0d,"JUNGLE.",$0d,0
t18
        dc.b $11,"WOVEN FROM LIVING BRANCHES.",$0d,0
t19
        dc.b $11,"THICK PURPLE BUSHES. SOMETHING SEEMS TO",$0d,"BE HIDING IN THERE."
        dc.b $0d,0
t20
        dc.b "A WOODEN MONKEY",0
t21
        dc.b $11,"A SMALL, HAND-CARVED WOODEN MONKEY WITH",$0d,"A BIG GRIN. CARVED UNDER ITS FEET:"
        dc.b $0d,"'MADE BY MARK STRONKS AKA STRONKIE.'",$0d,0
t22
        dc.b $11,"A PILE OF DIAMONDS UNDER A WOBBLY",$0d,"BOULDER. SCRATCHED INTO THE ROCK:"
        dc.b $0d,"ROCKFORD WAS HERE.",$0d,0
t_save
        dc.b "SAVE1-LANDFALL",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$4c,$41,$4e,$44,$46,$41,$4c,$4c,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$03,$4a,$55,$4e
        dc.b $47,$4c,$45,$0e,$60,$60,$60,$60,$04,$52,$49,$56,$45,$52,$0e,$60,$60,$60,$60,$60,$60,$05,$43,$41,$56,$45,$0e,$0d,$1f,$20,$20,$20
        dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$20,$01,$57,$52,$45,$43,$4b,$0e,$60,$60,$60,$60,$60,$02,$43,$52,$41
        dc.b $53,$48,$0e,$60,$60,$60,$60,$60,$60,$06,$47,$41,$54,$45,$0e,$0d,$00
        even
song
        dc.w 3                  ; voices
        dc.b $10,$08,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$09,$76,$05     ; waveform, attack/decay, sustain/release, pulse
        dc.b $80,$00,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $20,$12,$20,$06,$27,$0c,$20,$0c,$24,$0c,$27,$0c,$29,$0c,$27,$0c,$25,$12,$25,$06,$2c,$0c,$25,$0c,$29,$0c,$2c,$0c,$2e,$0c,$2c,$0c
        dc.b $20,$12,$20,$06,$27,$0c,$20,$0c,$24,$0c,$27,$0c,$29,$0c,$27,$0c,$25,$12,$25,$06,$2c,$0c,$25,$0c,$29,$0c,$2c,$0c,$2e,$0c,$2c,$0c
        dc.b $20,$12,$20,$06,$27,$0c,$20,$0c,$24,$0c,$27,$0c,$29,$0c,$27,$0c,$25,$12,$25,$06,$2c,$0c,$25,$0c,$29,$0c,$2c,$0c,$2e,$0c,$2c,$0c
        dc.b $20,$12,$20,$06,$27,$0c,$20,$0c,$24,$0c,$27,$0c,$29,$0c,$27,$0c,$25,$12,$25,$06,$2c,$0c,$25,$0c,$29,$0c,$2c,$0c,$2e,$0c,$2c,$0c
        dc.b $ff
song_v2
        dc.b $38,$0c,$3a,$0c,$3c,$18,$3f,$0c,$3c,$0c,$3a,$18,$38,$0c,$35,$0c,$38,$18,$3a,$30,$3c,$0c,$3f,$0c,$41,$18,$3f,$0c,$3c,$0c,$3a,$18
        dc.b $38,$0c,$3a,$0c,$3c,$0c,$3a,$0c,$38,$30,$3f,$0c,$41,$0c,$44,$18,$41,$0c,$3f,$0c,$3c,$18,$3d,$0c,$3f,$0c,$41,$18,$3f,$30,$3c,$0c
        dc.b $3a,$0c,$38,$18,$3a,$0c,$3c,$0c,$3f,$18,$3c,$0c,$3a,$0c,$38,$18,$00,$30,$ff
song_v3
        dc.b $55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06
        dc.b $55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06
        dc.b $55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06
        dc.b $55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06
        dc.b $55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06
        dc.b $55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06
        dc.b $55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06
        dc.b $55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06
        dc.b $ff
        even
tune
        dc.w 3                  ; voices
        dc.b $10,$08,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$09,$76,$05     ; waveform, attack/decay, sustain/release, pulse
        dc.b $80,$00,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l tune_v1-base
        dc.l tune_v2-base
        dc.l tune_v3-base
tune_v1
        dc.b $38,$05,$3d,$05,$41,$0a,$44,$05,$41,$05,$00,$05,$3d,$05,$3f,$0a,$42,$05,$3f,$05,$3c,$0a,$3d,$05,$00,$05,$41,$0a,$3d,$05,$38,$05
        dc.b $3a,$0a,$3c,$05,$3d,$05,$41,$0a,$3f,$0a,$3d,$14,$fe,$20,$12,$20,$06,$27,$0c,$20,$0c,$24,$0c,$27,$0c,$29,$0c,$27,$0c,$25,$12,$25
        dc.b $06,$2c,$0c,$25,$0c,$29,$0c,$2c,$0c,$2e,$0c,$2c,$0c,$20,$12,$20,$06,$27,$0c,$20,$0c,$24,$0c,$27,$0c,$29,$0c,$27,$0c,$25,$12,$25
        dc.b $06,$2c,$0c,$25,$0c,$29,$0c,$2c,$0c,$2e,$0c,$2c,$0c,$20,$12,$20,$06,$27,$0c,$20,$0c,$24,$0c,$27,$0c,$29,$0c,$27,$0c,$25,$12,$25
        dc.b $06,$2c,$0c,$25,$0c,$29,$0c,$2c,$0c,$2e,$0c,$2c,$0c,$20,$12,$20,$06,$27,$0c,$20,$0c,$24,$0c,$27,$0c,$29,$0c,$27,$0c,$25,$12,$25
        dc.b $06,$2c,$0c,$25,$0c,$29,$0c,$2c,$0c,$2e,$0c,$2c,$0c,$ff
tune_v2
        dc.b $25,$0f,$2c,$05,$25,$0a,$2c,$0a,$20,$0f,$27,$05,$20,$0a,$24,$0a,$25,$0f,$2c,$05,$29,$0a,$2c,$0a,$25,$28,$fe,$38,$0c,$3a,$0c,$3c
        dc.b $18,$3f,$0c,$3c,$0c,$3a,$18,$38,$0c,$35,$0c,$38,$18,$3a,$30,$3c,$0c,$3f,$0c,$41,$18,$3f,$0c,$3c,$0c,$3a,$18,$38,$0c,$3a,$0c,$3c
        dc.b $0c,$3a,$0c,$38,$30,$3f,$0c,$41,$0c,$44,$18,$41,$0c,$3f,$0c,$3c,$18,$3d,$0c,$3f,$0c,$41,$18,$3f,$30,$3c,$0c,$3a,$0c,$38,$18,$3a
        dc.b $0c,$3c,$0c,$3f,$18,$3c,$0c,$3a,$0c,$38,$18,$00,$30,$ff
tune_v3
        dc.b $55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05
        dc.b $55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05
        dc.b $fe,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00
        dc.b $06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00
        dc.b $06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00
        dc.b $06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00
        dc.b $06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00
        dc.b $06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00
        dc.b $06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00
        dc.b $06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00,$06,$55,$06,$00,$06,$50,$06,$00,$06,$55,$06,$55,$06,$50,$06,$00
        dc.b $06,$ff
        even
actors                               ; moving sprites per room
;       room, sprites, first image, images, image delay, move delay, dx, dy
;       x, y (C64 sprite coordinates), height in lines, colours 1-3
        dc.b 2,1,0,2,6,2,1,1
        dc.w 64,61,7,$112,$335,$fd6
        dc.b 2,1,2,2,7,2,1,-1
        dc.w 32,69,7,$112,$335,$fd6
        dc.b 3,1,4,2,6,2,-1,1
        dc.w 224,55,7,$112,$335,$fd6
        dc.b 4,1,6,2,6,2,1,1
        dc.w 104,65,7,$112,$335,$fd6
        dc.b 6,1,8,2,6,2,-1,1
        dc.w 264,63,7,$112,$335,$fd6
        dc.b 0
        even
frames                               ; offsets of the sprite images
        dc.l fr0-base
        dc.l fr1-base
        dc.l fr2-base
        dc.l fr3-base
        dc.l fr4-base
        dc.l fr5-base
        dc.l fr6-base
        dc.l fr7-base
        dc.l fr8-base
        dc.l fr9-base
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
fr6                              ; "bird1": 1 sprite(s), 7 lines
        dc.w $c006,$0000,$600c,$0000,$3838,$0000,$1e78,$0080,$06f8,$0118,$01c0,$0000,$0000,$0000
fr7                              ; "bird2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$0000,$0000,$0600,$0080,$7ef0,$0110,$fffc,$000c,$01c0,$0000,$0000,$0000
fr8                              ; "bird1": 1 sprite(s), 7 lines
        dc.w $c006,$0000,$600c,$0000,$3838,$0000,$1e78,$0080,$06f8,$0118,$01c0,$0000,$0000,$0000
fr9                              ; "bird2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$0000,$0000,$0600,$0080,$7ef0,$0110,$fffc,$000c,$01c0,$0000,$0000,$0000
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 12,0
        dc.l $01bf30             ; NOVA: I need a new power crystal, pilot. this 
        dc.w 13,0
        dc.l $01f3a8             ; NOVA: Repairs are under way. go and make frien
        dc.w 26,0
        dc.l $02198c             ; NOVA: Thank you, pilot. the repairs will take 
        dc.w 29,0
        dc.l $023b5e             ; NOVA: Pilot, first find a power crystal for th
        dc.w 0
card                                 ; next part: kind, name, spoken title (in the blob)
        dc.l card_k-base,card_n-base
        dc.l $026494             ; "Chapter 6. The Village"
card_k
        dc.b "CHAPTER 6",0
card_n
        dc.b "THE VILLAGE",0
        even
        even
part_end
