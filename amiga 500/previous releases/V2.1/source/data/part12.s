;======================================================================
;  THE WORLD OF STRONKIE V2.1 (Amiga) - CHAPTER 9: THE STAR HEART
;  Created By Mark Stronks
;
;  Part file "PART12": vasm -Fbin -o part12.bin part12.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_HEART       = $000000      ; picture "heart" in the blob
PIC_WESTGAL     = $006208      ; picture "westgal" in the blob
PIC_EASTGAL     = $00c886      ; picture "eastgal" in the blob
PIC_ALTAR       = $01350e      ; picture "altar" in the blob
PIC_CATACOMB    = $017960      ; picture "catacomb" in the blob
PIC_DEADEND     = $01db94      ; picture "deadend" in the blob

base
        dc.b "CHAP"
        dc.b 12,1,6,13       ; part, start room, rooms, objects
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
        dc.l d1-base,PIC_HEART
        dc.b 0,0,3,2,0,0,0,0      ; heart
        dc.l d2-base,PIC_WESTGAL
        dc.b 0,0,1,0,0,0,0,0      ; westgal
        dc.l d3-base,PIC_EASTGAL
        dc.b 0,0,0,1,0,0,0,0      ; eastgal
        dc.l d4-base,PIC_ALTAR
        dc.b 0,0,0,0,0,1,0,0      ; altar
        dc.l d5-base,PIC_CATACOMB
        dc.b 0,0,6,0,1,0,0,0      ; catacomb
        dc.l d6-base,PIC_DEADEND
        dc.b 0,0,0,5,0,0,0,0      ; deadend
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,255,1,0
        dc.l t0-base,t1-base
        dc.b 2,1,2,0
        dc.l t2-base,t3-base
        dc.b 3,1,2,0
        dc.l t2-base,t4-base
        dc.b 4,1,2,0
        dc.l t2-base,t5-base
        dc.b 5,2,1,0
        dc.l t6-base,t7-base
        dc.b 6,2,2,0
        dc.l t2-base,t8-base
        dc.b 7,3,2,0
        dc.l t2-base,t9-base
        dc.b 8,3,2,0
        dc.l t2-base,t10-base
        dc.b 9,4,2,0
        dc.l t2-base,t11-base
        dc.b 10,5,2,0
        dc.l t2-base,t12-base
        dc.b 11,6,2,0
        dc.l t2-base,t13-base
        dc.b 12,6,2,0
        dc.l t2-base,t14-base
        dc.b 13,0,0,0
        dc.l t15-base,t16-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "AMUL",1
        dc.b "HEAR",2
        dc.b "ALTA",2
        dc.b "CRYS",2
        dc.b "VEX ",3
        dc.b "COMM",3
        dc.b "MACH",4
        dc.b "CABL",4
        dc.b "HORN",5
        dc.b "MURA",6
        dc.b "PAIN",6
        dc.b "PLUG",7
        dc.b "SOCK",7
        dc.b "SOLD",8
        dc.b "GUAR",8
        dc.b "HOLL",9
        dc.b "BASE",9
        dc.b "LOCK",9
        dc.b "RAVE",9
        dc.b "LEVE",10
        dc.b "BARS",11
        dc.b "GATE",11
        dc.b "ARCH",11
        dc.b "CHAS",12
        dc.b "EDGE",12
        dc.b "EDMU",13
        dc.b "UNCL",13
        dc.b "BIX ",13
        dc.b "GUN ",14
        dc.b "RAY ",14
        dc.b "LAMP",15
        dc.b "FORC",16
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $0c,$06,$0d,$04,$02,$06,$00,$20,$01,$21,$00,$2c,$00
        dc.b $1c,$06,$0d,$04,$02,$06,$00,$20,$01,$21,$00,$2c,$00
        dc.b $08,$06,$0d,$04,$02,$06,$00,$20,$01,$21,$00,$2c,$00
        dc.b $3c,$05,$15,$04,$03,$02,$05,$06,$01,$20,$02,$23,$08,$00,$21,$01,$26,$0a,$2b,$08,$00
        dc.b $13,$07,$0a,$04,$03,$06,$01,$20,$03,$00
        dc.b $13,$07,$12,$04,$03,$06,$02,$20,$04,$21,$02,$26,$0a,$2b,$08,$2d,$04,$00
        dc.b $09,$07,$14,$04,$03,$05,$01,$06,$02,$20,$04,$21,$02,$26,$0a,$2b,$08,$2d,$04,$00
        dc.b $3c,$05,$0c,$04,$01,$02,$05,$06,$02,$20,$05,$00
        dc.b $3c,$05,$1d,$04,$01,$02,$05,$06,$03,$20,$06,$21,$03,$23,$03,$06,$25,$01,$05,$05,$25,$01,$04,$04,$26,$0a,$2d,$04,$00
        dc.b $3c,$05,$08,$02,$05,$20,$07,$00
        dc.b $06,$00,$0a,$04,$01,$06,$03,$20,$08,$00
        dc.b $1b,$00,$0a,$04,$01,$06,$03,$20,$08,$00
        dc.b $1b,$00,$08,$04,$01,$24,$04,$00
        dc.b $1d,$03,$0d,$04,$01,$06,$03,$20,$09,$2d,$04,$29,$00
        dc.b $20,$03,$0a,$04,$01,$06,$03,$20,$0a,$00
        dc.b $1a,$01,$0b,$04,$01,$06,$03,$20,$0b,$29,$00
        dc.b $09,$0e,$0a,$04,$01,$05,$03,$20,$0c,$00
        dc.b $13,$0a,$16,$04,$05,$06,$04,$20,$0d,$21,$04,$25,$05,$02,$00,$26,$0a,$2b,$06,$2d,$02,$00
        dc.b $0f,$0a,$16,$04,$05,$06,$04,$20,$0d,$21,$04,$25,$05,$02,$00,$26,$0a,$2b,$06,$2d,$02,$00
        dc.b $13,$0a,$08,$04,$06,$20,$0e,$00
        dc.b $20,$03,$0a,$04,$06,$06,$04,$20,$0f,$00
        dc.b $1d,$03,$0a,$04,$06,$06,$04,$20,$10,$00
        dc.b $20,$03,$08,$05,$04,$20,$11,$00
        dc.b $26,$00,$09,$04,$06,$20,$12,$29,$00
        dc.b $04,$00,$0a,$04,$05,$05,$04,$20,$13,$00
        dc.b $20,$0d,$11,$01,$0d,$06,$05,$20,$14,$21,$05,$23,$0d,$04,$26,$0a,$00
        dc.b $20,$00,$11,$01,$0d,$06,$05,$20,$14,$21,$05,$23,$0d,$04,$26,$0a,$00
        dc.b $20,$0d,$08,$01,$0d,$20,$15,$00
        dc.b $0f,$01,$16,$04,$04,$02,$01,$05,$05,$20,$16,$26,$14,$2b,$0a,$2d,$14,$20,$17,$27,$0d,$00
        dc.b $0a,$01,$16,$04,$04,$02,$01,$05,$05,$20,$16,$26,$14,$2b,$0a,$2d,$14,$20,$17,$27,$0d,$00
        dc.b $0f,$01,$08,$04,$04,$20,$18,$00
        dc.b $0a,$01,$08,$04,$04,$20,$18,$00
        dc.b $0d,$09,$0a,$04,$04,$06,$05,$20,$19,$00
        dc.b $0f,$01,$08,$04,$01,$20,$1a,$00
        dc.b $0a,$01,$08,$02,$01,$20,$1b,$00
        dc.b $37,$00,$08,$03,$05,$20,$1c,$00
        dc.b $37,$00,$08,$06,$01,$20,$1d,$00
        dc.b $37,$00,$08,$06,$02,$20,$1e,$00
        dc.b $37,$00,$08,$06,$03,$20,$1f,$00
        dc.b $37,$00,$08,$06,$04,$20,$20,$00
        dc.b $37,$00,$08,$06,$05,$20,$21,$00
        dc.b $37,$00,$06,$20,$22,$00
        dc.b $45,$00,$06,$20,$23,$00
        dc.b $46,$00,$06,$20,$24,$00
        dc.b $47,$00,$06,$20,$25,$00
        dc.b $0f,$10,$06,$20,$26,$00
        dc.b $09,$0f,$06,$20,$27,$00
        dc.b $22,$00,$06,$20,$28,$00
        dc.b $00,$00,$13,$04,$01,$05,$04,$06,$06,$20,$29,$23,$0d,$01,$21,$06,$2b,$06,$00
        dc.b $00,$00,$0c,$04,$06,$06,$07,$20,$2a,$21,$07,$00
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
m1
        dc.b $11,"BEHIND A LOOSE STONE IN THE MURAL",$0d,"SOMETHING GLITTERS... A TINY PIECE OF"
        dc.b $0d,"STARLIGHT!",$0d,0
m2
        dc.b $11,"YOU BLOW THE SILVER HORN. A PIERCING",$0d,"NOTE FILLS THE GALLERY. THE SOLDIER"
        dc.b $0d,"CLUTCHES HIS HELMET, SCREAMS AND RUNS",$0d,"AWAY!",$0d,0
m3
        dc.b $11,"THE SOLDIER BLOCKS YOUR WAY: 'HANDS",$0d,"OFF!'",$0d,0
m4
        dc.b $11,"YOU YANK THE PLUG OUT OF THE WALL. WITH",$0d,"A DYING WHINE VEX'S MACHINE STOPS. FROM"
        dc.b $0d,"THE CHAMBER COMES A FURIOUS SCREAM.",$0d,0
m5
        dc.b $11,"VEX COVERS HIS EARS AND LAUGHS: 'NICE",$0d,"TUNE! BUT MY MACHINE IS STILL RUNNING.'"
        dc.b $0d,0
m6
        dc.b $11,"THE NOTE OF THE HORN BOUNCES AROUND THE",$0d,"CHAMBER. VEX'S RAY GUN SPARKS AND FALLS"
        dc.b $0d,"FROM HIS HAND. HE STAGGERS BACK, KICKS",$0d,"OPEN A HIDDEN TRAPDOOR AND FLEES DOWN"
        dc.b $0d,"INTO THE CATACOMBS!",$0d,0
m7
        dc.b $11,"TOOT! THE SOUND ECHOES THROUGH THE",$0d,"TEMPLE.",$0d,0
m8
        dc.b $11,"VEX AIMS HIS RAY GUN AT YOU: 'ONE MORE",$0d,"STEP, PILOT...'"
        dc.b $0d,0
m9
        dc.b $11,"VEX IS FASTER. ZAP!",$0d,0
m10
        dc.b $11,"VEX: 'YOUR UNCLE WAS JUST AS STUBBORN.",$0d,"GIVE ME THE AMULET!'"
        dc.b $0d,0
m11
        dc.b $11,"VEX GRABS THE AMULET AND LAUGHS. HIS",$0d,"MACHINE ROARS, AND THE STAR HEART GOES"
        dc.b $0d,"DARK FOREVER...",$0d,0
m12
        dc.b $11,"IT FELL APART IN A SHOWER OF SPARKS.",$0d,0
m13
        dc.b $11,"YOU PULL THE OLD LEVER. WITH A CRASH, A",$0d,"GATE OF CRYSTAL BARS DROPS IN FRONT OF"
        dc.b $0d,"THE DEAD END. VEX IS TRAPPED! HE",$0d,"RATTLES THE BARS: 'YOU DON'T EVEN KNOW"
        dc.b $0d,"WHO I AM, KID!'",$0d,0
m14
        dc.b $11,"THE LEVER IS BACK IN THE CATACOMBS,",$0d,"BESIDE THE ARCHWAY."
        dc.b $0d,0
m15
        dc.b $11,"VEX BACKS AWAY TO THE EDGE OF THE",$0d,"CHASM. 'STAY BACK, KID! YOU HAVE NO"
        dc.b $0d,"IDEA WHAT YOU'RE MESSING WITH.'",$0d,0
m16
        dc.b $11,"VEX DODGES AND LAUGHS. YOU WILL NEVER",$0d,"CATCH HIM LIKE THIS. MAYBE YOU CAN TRAP"
        dc.b $0d,"HIM IN HERE INSTEAD.",$0d,0
m17
        dc.b $11,"VEX GLARES THROUGH THE BARS. 'ASK YOUR",$0d,"DEAR UNCLE WHO I AM, KID.'"
        dc.b $0d,0
m18
        dc.b $11,"YOU JUMP INTO THE CHASM. VEX WATCHES",$0d,"YOU FALL, AND SMILES."
        dc.b $0d,0
m19
        dc.b $11,"THE CRYSTAL BARS BLOCK THE ARCHWAY. VEX",$0d,"IS NOT GOING ANYWHERE."
        dc.b $0d,0
m20
        dc.b $17,"UNCLE EDMUND LOOKS AT THE ALTAR. 'A",$0d,"RAVEN LOCK! VEX SEALED THE HOLLOW. IT"
        dc.b $0d,"TAKES TWO: ONE HOLDS THE LOCK, ONE",$0d,"TURNS THE AMULET. COME ON, UP WE GO!'"
        dc.b $0d,"HE CLIMBS ONTO THE ALTAR.",$0d,0
m21
        dc.b $11,"'TURN THE AMULET IN THE HOLLOW, I'LL",$0d,"HOLD THE LOCK!'"
        dc.b $0d,0
m22
        dc.b $11,"UNCLE EDMUND HOLDS THE RAVEN LOCK OPEN",$0d,"WHILE YOU PRESS THE AMULET INTO THE"
        dc.b $0d,"HOLLOW. CLICK! THE STAR HEART BLAZES UP",$0d,"LIKE A NEW SUN, AND ALL OVER THE PLANET"
        dc.b $0d,"THE STRONKIES CHEER!",$0d,0
m23
        dc.b $11,"THEN A BEAM OF RED LIGHT SHOOTS DOWN",$0d,"FROM THE SKY. IT RIPS VEX OUT OF THE"
        dc.b $0d,"CATACOMBS... AND UNCLE EDMUND WITH HIM!",$0d,"HIGH ABOVE, A HUGE BLACK FLAGSHIP"
        dc.b $0d,"SLIDES AWAY INTO ORBIT. VEX'S VOICE",$0d,"ECHOES THROUGH THE TEMPLE: 'THIS ISN'T"
        dc.b $0d,"OVER, KID!'",$0d,0
m24
        dc.b $11,"THE RAVEN LOCK BLOCKS THE HOLLOW. IT",$0d,"NEEDS TWO PEOPLE TO OPEN."
        dc.b $0d,0
m25
        dc.b $11,"THE LOCK IS FAR TOO HEAVY TO HOLD AND",$0d,"TURN AT THE SAME TIME."
        dc.b $0d,0
m26
        dc.b $11,"THE HOLLOW FOR THE AMULET IS UP ON THE",$0d,"ALTAR.",$0d,0
m27
        dc.b $11,"NOT HERE, NOT NOW. YOU WILL NEED IT.",$0d,0
m28
        dc.b $11,"THE MURALS IN THE WEST GALLERY SHOW A",$0d,"USEFUL INSTRUMENT. TAKE THE HORN."
        dc.b $0d,0
m29
        dc.b $11,"BLOW THE HORN AT THE SOLDIER IN THE",$0d,"EAST GALLERY.",$0d
        dc.b 0
m30
        dc.b $11,"PULL THE PLUG OF VEX'S MACHINE.",$0d,0
m31
        dc.b $11,"NOW BLOW THE HORN AT VEX IN THE HEART",$0d,"CHAMBER.",$0d,0
m32
        dc.b $11,"FOLLOW VEX INTO THE CATACOMBS. THE OLD",$0d,"LEVER CAN TRAP HIM IN THE DEAD END."
        dc.b $0d,0
m33
        dc.b $11,"GO BACK UP TO THE HEART CHAMBER AND",$0d,"TALK TO UNCLE EDMUND."
        dc.b $0d,0
m34
        dc.b $11,"CLIMB THE ALTAR AND PUT THE AMULET INTO",$0d,"THE HOLLOW. UNCLE EDMUND HOLDS THE"
        dc.b $0d,"LOCK.",$0d,0
m35
        dc.b $11,"A HOLLOW VOICE SAYS: WRONG GAME. THIS",$0d,"ISN'T COLOSSAL CAVE."
        dc.b $0d,0
m36
        dc.b $11,"GOD MODE? NICE TRY. THIS IS A COMMODORE",$0d,"64, NOT A 486."
        dc.b $0d,0
m37
        dc.b $11,"THAT'S THE ANSWER TO LIFE, THE UNIVERSE",$0d,"AND EVERYTHING. BUT WHAT WAS THE"
        dc.b $0d,"QUESTION?",$0d,0
m38
        dc.b $11,"YOU WAVE YOUR HAND. THESE AREN'T THE",$0d,"COMMANDS YOU'RE LOOKING FOR."
        dc.b $0d,0
m39
        dc.b $11,"THERE IS NO LAMP HERE. THIS ISN'T ZORK,",$0d,"YOU KNOW. BUT WATCH OUT FOR GRUES"
        dc.b $0d,"ANYWAY.",$0d,0
m40
        dc.b $11,"TYPE COMMANDS LIKE TAKE KEY, OPEN DOOR,",$0d,"EXAMINE MAT, N S E W U D, L = LOOK,"
        dc.b $0d,"I = INVENTORY, TAKE ALL, DROP ALL,",$0d,"G = AGAIN, SCORE, MAP, SAVE, LOAD, QUIT"
        dc.b $0d,"F1 LOAD  F3 SAVE  F5 MUSIC  F7 QUIT",$0d,"THREE SAVE SLOTS: PRESS 1, 2 OR 3."
        dc.b $0d,"HINT GIVES A CLUE BUT COSTS 3 POINTS.",$0d,"FIND THE 16 HIDDEN STAR FRAGMENTS!"
        dc.b $0d,0
m41
        dc.b $11,"FOOTSTEPS! UNCLE EDMUND RUSHES INTO THE",$0d,"CHAMBER, WITH BIX RIGHT BEHIND HIM. 'I"
        dc.b $0d,"FOLLOWED YOU IN MY OLD BACKUP SHIP,' HE",$0d,"PANTS. 'LANDED IN A LAKE. NEVER MIND!"
        dc.b $0d,"WHERE IS VEX?'",$0d,0
m42
        dc.b $11,"VEX IS HERE! HE STANDS WITH HIS BACK TO",$0d,"THE CHASM, LOOKING FOR A WAY OUT. THERE"
        dc.b $0d,"IS NONE... EXCEPT PAST YOU.",$0d,0
t_intro
        dc.b $11,"COMMANDER VEX STEPS OUT OF THE SHADOWS,",$0d,"A RAY GUN IN HIS HAND. HIS SOLDIERS"
        dc.b $0d,"DRAG A HUMMING MACHINE INTO THE CHAMBER",$0d,"AND HOOK IT UP TO THE STAR HEART."
        dc.b $0d,"'STAND ASIDE, LITTLE PILOT. THIS",$0d,"WORLD'S POWER IS MINE.'"
        dc.b $0d,$0d,0
t_title
        dc.b $17,$0d,"CHAPTER 9: THE STAR HEART",$0d,$0d,0
t_short
        dc.b "CHAPTER 9",0
t_quip
        dc.b $17,"VEX THANKS YOU FOR PLAYING. HE REALLY",$0d,"MEANS IT.",$0d,0
d1
        dc.b $1d,"YOU ARE IN THE HEART CHAMBER. ON A HIGH",$0d,"ALTAR FLOATS THE STAR HEART, BUT IT"
        dc.b $0d,"FLICKERS WEAKLY. GALLERIES LEAD EAST",$0d,"AND WEST.",$0d,0
d2
        dc.b $1d,"YOU ARE IN THE WEST GALLERY. OLD MURALS",$0d,"SHOW STRONKIES CHASING AWAY MONSTERS"
        dc.b $0d,"WITH THE SOUND OF A HORN.",$0d,0
d3
        dc.b $1d,"YOU ARE IN THE EAST GALLERY. VEX'S",$0d,"THICK CABLES RUN ALONG THE FLOOR TO A"
        dc.b $0d,"BIG PLUG IN THE WALL.",$0d,0
d4
        dc.b $1d,"YOU STAND ON THE ALTAR BESIDE THE STAR",$0d,"HEART. THERE IS A ROUND HOLLOW IN ITS"
        dc.b $0d,"BASE, BUT A HEAVY LOCK SHAPED LIKE A",$0d,"RAVEN SEALS IT."
        dc.b $0d,0
d5
        dc.b $1d,"YOU ARE IN THE CATACOMBS UNDER THE",$0d,"TEMPLE. GLOWING CRYSTALS LIGHT ANCIENT"
        dc.b $0d,"TUNNELS. AN OLD LEVER STICKS OUT OF THE",$0d,"WALL BESIDE AN ARCHWAY TO THE EAST."
        dc.b $0d,0
d6
        dc.b $1d,"YOU ARE AT A DEAD END ON THE EDGE OF A",$0d,"DEEP CHASM. ABOVE THE ARCHWAY HANGS A"
        dc.b $0d,"GATE OF CRYSTAL BARS.",$0d,0
t0
        dc.b "THE AMULET",0
t1
        dc.b $11,"IT IS BURNING HOT AND GLOWING BRIGHTLY.",$0d,0
t2
        dc.b 0
t3
        dc.b $11,"A CRYSTAL AS BRIGHT AS A SUN... BUT",$0d,"GROWING DIMMER EVERY MOMENT."
        dc.b $0d,0
t4
        dc.b $11,"TALL AND THIN IN A BLACK COAT, WITH A",$0d,"RAVEN ON HIS HELMET. HIS FACE LOOKS"
        dc.b $0d,"STRANGELY FAMILIAR.",$0d,0
t5
        dc.b $11,"A HUMMING BLACK MACHINE. ITS CABLES RUN",$0d,"OFF TO THE EAST GALLERY."
        dc.b $0d,0
t6
        dc.b "A SILVER HORN",0
t7
        dc.b $11,"A CURLED SILVER HORN. THE MURALS SHOW",$0d,"WHAT IT DOES.",$0d
        dc.b 0
t8
        dc.b $11,"MONSTERS WITH HANDS OVER THEIR EARS,",$0d,"FLEEING FROM A HORN."
        dc.b $0d,0
t9
        dc.b $11,"A HUGE PLUG IN A STONE SOCKET. VEX'S",$0d,"CABLES ARE ATTACHED TO IT."
        dc.b $0d,0
t10
        dc.b $11,"A SOLDIER IN BLACK GUARDS THE PLUG. HE",$0d,"WEARS A BIG HELMET."
        dc.b $0d,0
t11
        dc.b $11,"A ROUND HOLLOW, SEALED BY A HEAVY RAVEN",$0d,"LOCK. IT LOOKS LIKE A TWO-PERSON JOB."
        dc.b $0d,0
t12
        dc.b $11,"AN OLD STONE LEVER. A CARVING SHOWS",$0d,"BARS FALLING OVER AN ARCHWAY."
        dc.b $0d,0
t13
        dc.b $11,"A GATE OF CRYSTAL BARS HANGS ABOVE THE",$0d,"ARCHWAY. SOMETHING MUST LET IT DROP."
        dc.b $0d,0
t14
        dc.b $11,"A DEEP, DARK CHASM. NO WAY ACROSS.",$0d,0
t15
        dc.b "UNCLE EDMUND AND BIX",0
t16
        dc.b $11,"UNCLE EDMUND, MUDDY AND OUT OF BREATH,",$0d,"BUT SMILING. BIX WAVES."
        dc.b $0d,0
t_save
        dc.b "SAVE1-STARHEART",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$54,$48,$45,$20,$53,$54,$41,$52,$20,$48,$45,$41,$52,$54,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$20,$04,$41,$4c,$54,$41,$52,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$02,$57,$45
        dc.b $53,$54,$20,$47,$41,$4c,$0e,$60,$60,$60,$01,$48,$45,$41,$52,$54,$0e,$60,$60,$60,$60,$03,$45,$41,$53,$54,$20,$47,$41,$4c,$0e,$0d
        dc.b $1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$85,$62,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$85
        dc.b $43,$41,$54,$41,$43,$4f,$4d,$42,$60,$60,$0e,$86,$44,$45,$41,$44,$20,$45,$4e,$44,$0e,$0d,$00
        even
song
        dc.w 3                  ; voices
        dc.b $20,$06,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$0a,$a9,$08     ; waveform, attack/decay, sustain/release, pulse
        dc.b $80,$00,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $19,$0a,$25,$0a,$19,$0a,$25,$0a,$19,$0a,$25,$0a,$19,$0a,$25,$0a,$15,$0a,$21,$0a,$15,$0a,$21,$0a,$15,$0a,$21,$0a,$15,$0a,$21,$0a
        dc.b $17,$0a,$23,$0a,$17,$0a,$23,$0a,$17,$0a,$23,$0a,$17,$0a,$23,$0a,$14,$0a,$20,$0a,$14,$0a,$20,$0a,$14,$0a,$20,$0a,$14,$0a,$20,$0a
        dc.b $19,$0a,$25,$0a,$19,$0a,$25,$0a,$19,$0a,$25,$0a,$19,$0a,$25,$0a,$15,$0a,$21,$0a,$15,$0a,$21,$0a,$15,$0a,$21,$0a,$15,$0a,$21,$0a
        dc.b $17,$0a,$23,$0a,$17,$0a,$23,$0a,$17,$0a,$23,$0a,$17,$0a,$23,$0a,$14,$0a,$20,$0a,$14,$0a,$20,$0a,$14,$0a,$20,$0a,$14,$0a,$20,$0a
        dc.b $ff
song_v2
        dc.b $3d,$14,$40,$14,$44,$1e,$42,$0a,$40,$14,$3f,$14,$3d,$28,$39,$14,$3d,$14,$40,$14,$3f,$14,$3d,$14,$3b,$14,$38,$28,$3d,$14,$40,$14
        dc.b $44,$14,$49,$14,$47,$1e,$45,$0a,$44,$28,$42,$14,$44,$14,$45,$14,$48,$14,$49,$3c,$00,$14,$ff
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
        dc.l $0228ea             ; "Chapter 10. Repairs"
card_k
        dc.b "CHAPTER 10",0
card_n
        dc.b "REPAIRS",0
        even
        even
part_end
