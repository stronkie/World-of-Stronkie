;======================================================================
;  THE WORLD OF STRONKIE V2.2 (Amiga) - CHAPTER 7: THE CRYSTAL MOUNTAINS
;  Created By Mark Stronks
;
;  Part file "PART10": vasm -Fbin -o part10.bin part10.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_LEDGE       = $000000      ; picture "ledge" in the blob
PIC_ICECAVE     = $003f92      ; picture "icecave" in the blob
PIC_ICEBRIDGE   = $00b4f2      ; picture "icebridge" in the blob
PIC_CAMP        = $00e6ec      ; picture "camp" in the blob
PIC_TENT        = $012672      ; picture "tent" in the blob
PIC_STEPS       = $017d84      ; picture "steps" in the blob

base
        dc.b "CHAP"
        dc.b 10,1,6,13       ; part, start room, rooms, objects
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
        dc.b 3,14
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_LEDGE
        dc.b 2,0,3,0,0,0,0,0      ; ledge
        dc.l d2-base,PIC_ICECAVE
        dc.b 0,1,0,0,0,0,0,0      ; icecave
        dc.l d3-base,PIC_ICEBRIDGE
        dc.b 0,0,4,1,0,0,0,0      ; bridge
        dc.l d4-base,PIC_CAMP
        dc.b 6,0,0,3,0,0,0,0      ; camp
        dc.l d5-base,PIC_TENT
        dc.b 0,0,0,4,0,0,0,0      ; tent
        dc.l d6-base,PIC_STEPS
        dc.b 0,4,0,0,0,0,0,0      ; steps
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,1,2,0
        dc.l t0-base,t1-base
        dc.b 2,1,2,0
        dc.l t0-base,t2-base
        dc.b 2,0,1,0
        dc.l t3-base,t4-base
        dc.b 3,2,2,0
        dc.l t0-base,t5-base
        dc.b 4,2,2,0
        dc.l t0-base,t6-base
        dc.b 5,2,1,0
        dc.l t7-base,t8-base
        dc.b 5,0,1,0
        dc.l t9-base,t10-base
        dc.b 6,3,2,0
        dc.l t0-base,t11-base
        dc.b 7,4,2,0
        dc.l t0-base,t12-base
        dc.b 8,4,2,0
        dc.l t0-base,t13-base
        dc.b 9,5,1,0
        dc.l t14-base,t15-base
        dc.b 10,5,2,0
        dc.l t0-base,t16-base
        dc.b 11,6,2,0
        dc.l t0-base,t17-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "GLID",1
        dc.b "WREC",1
        dc.b "SNOW",2
        dc.b "BEAS",3
        dc.b "MONS",3
        dc.b "JUNK",4
        dc.b "PILE",4
        dc.b "EQUI",4
        dc.b "SPIK",5
        dc.b "BOOT",5
        dc.b "BRID",6
        dc.b "ICE ",6
        dc.b "GORG",6
        dc.b "SOLD",7
        dc.b "GUAR",7
        dc.b "TENT",8
        dc.b "CAMP",8
        dc.b "AMUL",9
        dc.b "TABL",10
        dc.b "MAPS",10
        dc.b "MACH",10
        dc.b "PLAN",10
        dc.b "STEP",11
        dc.b "STAI",11
        dc.b "TEMP",11
        dc.b "CAVE",12
        dc.b "LAMP",13
        dc.b "FORC",14
        dc.b "NINJ",15
        dc.b "FIGU",15
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $0c,$0f,$06,$20,$01,$00
        dc.b $20,$0f,$06,$20,$01,$00
        dc.b $01,$0f,$06,$20,$01,$00
        dc.b $1d,$0f,$06,$20,$01,$00
        dc.b $0c,$04,$0d,$04,$02,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $1c,$04,$0d,$04,$02,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $08,$04,$0d,$04,$02,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $2c,$00,$09,$04,$02,$20,$03,$29,$00
        dc.b $1d,$03,$09,$04,$02,$20,$03,$29,$00
        dc.b $2e,$03,$09,$04,$02,$20,$03,$29,$00
        dc.b $3f,$03,$09,$04,$02,$20,$03,$29,$00
        dc.b $20,$03,$09,$04,$02,$20,$03,$29,$00
        dc.b $09,$03,$09,$04,$02,$20,$03,$29,$00
        dc.b $2b,$05,$08,$02,$07,$20,$04,$00
        dc.b $2b,$05,$10,$02,$06,$20,$05,$23,$06,$00,$23,$07,$ff,$26,$05,$00
        dc.b $2b,$05,$08,$01,$06,$20,$06,$00
        dc.b $04,$00,$0a,$04,$03,$03,$07,$20,$07,$00
        dc.b $04,$00,$10,$04,$03,$06,$01,$20,$08,$21,$01,$24,$04,$26,$0a,$00
        dc.b $26,$00,$09,$04,$03,$20,$09,$29,$00
        dc.b $3d,$02,$0b,$03,$03,$20,$0a,$23,$03,$ff,$00
        dc.b $09,$02,$0d,$04,$01,$03,$03,$20,$0a,$23,$03,$ff,$00
        dc.b $09,$02,$0d,$04,$03,$03,$03,$20,$0a,$23,$03,$ff,$00
        dc.b $09,$02,$0d,$04,$04,$03,$03,$20,$0a,$23,$03,$ff,$00
        dc.b $09,$02,$0b,$03,$03,$20,$0a,$23,$03,$ff,$00
        dc.b $27,$02,$1a,$04,$04,$02,$03,$06,$02,$20,$0b,$23,$03,$00,$21,$02,$23,$09,$00,$25,$04,$02,$05,$26,$0a,$00
        dc.b $27,$02,$0b,$02,$03,$20,$0c,$23,$03,$00,$00
        dc.b $04,$00,$0a,$04,$04,$06,$02,$20,$0d,$00
        dc.b $01,$08,$0a,$04,$04,$06,$02,$20,$0d,$00
        dc.b $01,$08,$08,$04,$04,$24,$05,$00
        dc.b $02,$00,$0a,$04,$04,$03,$0b,$20,$0e,$00
        dc.b $1d,$07,$08,$04,$04,$20,$0f,$00
        dc.b $09,$09,$13,$04,$05,$06,$03,$20,$10,$23,$0b,$ff,$21,$03,$26,$0a,$2b,$05,$00
        dc.b $10,$0a,$08,$04,$05,$20,$11,$00
        dc.b $06,$00,$0c,$04,$06,$20,$12,$26,$0a,$27,$0b,$00
        dc.b $1b,$00,$0c,$04,$06,$20,$12,$26,$0a,$27,$0b,$00
        dc.b $01,$0b,$0c,$04,$06,$20,$12,$26,$0a,$27,$0b,$00
        dc.b $20,$00,$06,$20,$13,$00
        dc.b $37,$00,$0a,$03,$07,$03,$06,$20,$14,$00
        dc.b $37,$00,$08,$03,$07,$20,$15,$00
        dc.b $37,$00,$08,$06,$01,$20,$16,$00
        dc.b $37,$00,$0a,$06,$02,$03,$03,$20,$17,$00
        dc.b $37,$00,$08,$06,$02,$20,$18,$00
        dc.b $37,$00,$08,$06,$03,$20,$19,$00
        dc.b $37,$00,$06,$20,$1a,$00
        dc.b $45,$00,$06,$20,$1b,$00
        dc.b $46,$00,$06,$20,$1c,$00
        dc.b $47,$00,$06,$20,$1d,$00
        dc.b $0f,$0e,$06,$20,$1e,$00
        dc.b $09,$0d,$06,$20,$1f,$00
        dc.b $22,$00,$06,$20,$20,$00
        dc.b $00,$00,$0c,$04,$06,$06,$04,$20,$21,$21,$04,$00
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
        dc.b $11,"HE'S GONE. THE LAST NINJA ALWAYS IS.",$0d,0
m2
        dc.b $11,"ROOTING THROUGH THE JUNK AS QUIETLY AS",$0d,"YOU CAN... SOMETHING GLITTERS... A TINY"
        dc.b $0d,"PIECE OF STARLIGHT!",$0d,0
m3
        dc.b $11,"THE BEAST OPENS ONE HUGE EYE... THEN",$0d,"ITS MOUTH. THAT IS THE LAST THING YOU"
        dc.b $0d,"SEE.",$0d,0
m4
        dc.b $11,"YOU ARE ALREADY WEARING THEM.",$0d,0
m5
        dc.b $11,"YOU PULL ON THE SPIKED BOOTS. CRUNCH!",$0d,"THEY BITE INTO THE ICE."
        dc.b $0d,0
m6
        dc.b $11,"PICK THEM UP FIRST.",$0d,0
m7
        dc.b $11,"YOU STEP ONTO THE ICE AND SLIDE",$0d,"STRAIGHT BACK. YOU NEED SOMETHING TO"
        dc.b $0d,"GRIP THE ICE.",$0d,0
m8
        dc.b $11,"STEP BY STEP THE SPIKES CARRY YOU",$0d,"ACROSS THE GORGE. DON'T LOOK DOWN!"
        dc.b $0d,0
m9
        dc.b $11,"INTO A BOTTOMLESS GORGE? REALLY?",$0d,0
m10
        dc.b $11,"YOU PACK A HANDFUL OF SNOW INTO A HARD",$0d,"SNOWBALL.",$0d,0
m11
        dc.b $11,"YOU THROW THE SNOWBALL FAR OVER THE",$0d,"TENTS. THUMP! THE SOLDIERS SPIN AROUND:"
        dc.b $0d,"'WHO GOES THERE?' AND RUN OFF TO SEARCH",$0d,"THE ROCKS.",$0d
        dc.b 0
m12
        dc.b $11,"YOU THROW THE SNOWBALL. SPLAT. VERY",$0d,"SATISFYING, BUT NOT VERY USEFUL HERE."
        dc.b $0d,0
m13
        dc.b $11,"THE SOLDIERS WOULD SEE YOU AT ONCE. YOU",$0d,"NEED TO DISTRACT THEM."
        dc.b $0d,0
m14
        dc.b $11,"WITHOUT THE AMULET THE TEMPLE WILL",$0d,"NEVER OPEN. VEX HAS IT IN HIS TENT."
        dc.b $0d,0
m15
        dc.b $11,"TWO AGAINST ONE, AND THEY HAVE RAY",$0d,"GUNS. NO.",$0d,0
m16
        dc.b $11,"YOU GRAB THE AMULET. IT GLOWS WARMLY IN",$0d,"YOUR HAND, AS IF IT KNOWS YOU."
        dc.b $0d,0
m17
        dc.b $11,"VEX'S PLANS: DRAIN THE STAR HEART, SELL",$0d,"ITS POWER, RULE THE GALAXY. CHARMING."
        dc.b $0d,0
m18
        dc.b $11,"YOU CLIMB THE ENDLESS CRYSTAL STAIRS.",$0d,"FAR BELOW, AN ANGRY SHOUT ECHOES FROM"
        dc.b $0d,"THE CAMP: VEX HAS FOUND HIS TENT EMPTY!",$0d,0
m19
        dc.b $13,"NOVA ON THE RADIO: 'GET THE AMULET",$0d,"BACK, PILOT. THE TEMPLE NEEDS IT.'"
        dc.b $0d,0
m20
        dc.b $11,"THE ICE CAVE HOLDS SOMETHING FOR THE",$0d,"ICE. BE QUIET!",$0d
        dc.b 0
m21
        dc.b $11,"WEAR THE SPIKED BOOTS.",$0d,0
m22
        dc.b $11,"CROSS THE ICE BRIDGE TO THE EAST.",$0d,0
m23
        dc.b $11,"MAKE A SNOWBALL.",$0d,0
m24
        dc.b $11,"THROW THE SNOWBALL IN THE CAMP TO",$0d,"DISTRACT THE SOLDIERS."
        dc.b $0d,0
m25
        dc.b $11,"TAKE THE AMULET FROM VEX'S TENT.",$0d,0
m26
        dc.b $11,"CLIMB THE TEMPLE STEPS NORTH OF THE",$0d,"CAMP.",$0d,0
m27
        dc.b $11,"A HOLLOW VOICE SAYS: WRONG GAME. THIS",$0d,"ISN'T COLOSSAL CAVE."
        dc.b $0d,0
m28
        dc.b $11,"GOD MODE? NICE TRY. THIS IS A COMMODORE",$0d,"64, NOT A 486."
        dc.b $0d,0
m29
        dc.b $11,"THAT'S THE ANSWER TO LIFE, THE UNIVERSE",$0d,"AND EVERYTHING. BUT WHAT WAS THE"
        dc.b $0d,"QUESTION?",$0d,0
m30
        dc.b $11,"YOU WAVE YOUR HAND. THESE AREN'T THE",$0d,"COMMANDS YOU'RE LOOKING FOR."
        dc.b $0d,0
m31
        dc.b $11,"THERE IS NO LAMP HERE. THIS ISN'T ZORK,",$0d,"YOU KNOW. BUT WATCH OUT FOR GRUES"
        dc.b $0d,"ANYWAY.",$0d,0
m32
        dc.b $11,"TYPE COMMANDS LIKE TAKE KEY, OPEN DOOR,",$0d,"EXAMINE MAT, N S E W U D, L = LOOK,"
        dc.b $0d,"I = INVENTORY, TAKE ALL, DROP ALL,",$0d,"G = AGAIN, SCORE, MAP, SAVE, LOAD, QUIT"
        dc.b $0d,"F1 LOAD  F3 SAVE  F5 MUSIC  F7 QUIT",$0d,"THREE SAVE SLOTS: PRESS 1, 2 OR 3."
        dc.b $0d,"HINT GIVES A CLUE BUT COSTS 3 POINTS.",$0d,"FIND THE 16 HIDDEN STAR FRAGMENTS!"
        dc.b $0d,0
m33
        dc.b $11,"A FIGURE IN BLACK SNEAKS ACROSS THE",$0d,"STEPS, ROLLS... AND VANISHES. JUST THE"
        dc.b $0d,"LAST NINJA, ON HIS WAY TO SOME OTHER",$0d,"GAME.",$0d,0
t_intro
        dc.b $11,"THE GLIDER CARRIES YOU HIGH OVER",$0d,"FORESTS AND RIVERS, UNTIL A STORM"
        dc.b $0d,"THROWS YOU DOWN ON A SNOWY LEDGE. NOVA",$0d,"ON YOUR RADIO: 'PILOT! SOMEONE BROKE"
        dc.b $0d,"INTO THE STARRAVEN AND TOOK THE AMULET.",$0d,"THE TRACKS LEAD TO THE BLACK TENTS!'"
        dc.b $0d,$0d,0
t_title
        dc.b $17,$0d,"CHAPTER 7: THE CRYSTAL MOUNTAINS",$0d,$0d,0
t_short
        dc.b "CHAPTER 7",0
t_quip
        dc.b $17,"AT LEAST THE ICE WILL KEEP YOU FRESH",$0d,"UNTIL THE SEQUEL."
        dc.b $0d,0
d1
        dc.b $1d,"YOU ARE ON A NARROW, SNOWY LEDGE HIGH",$0d,"IN THE CRYSTAL MOUNTAINS. THE WRECK OF"
        dc.b $0d,"YOUR GLIDER LIES IN THE SNOW. A PATH",$0d,"LEADS EAST, A DARK CAVE NORTH."
        dc.b $0d,0
d2
        dc.b $1d,"YOU ARE IN AN ICE CAVE. A HUGE WHITE",$0d,"BEAST SLEEPS ON A PILE OF OLD JUNK,"
        dc.b $0d,"SNORING LOUDLY. BETTER BE QUIET!",$0d,0
d3
        dc.b $1d,"YOU STAND AT AN ICE BRIDGE OVER A",$0d,"BOTTOMLESS GORGE. THE ICE IS AS SMOOTH"
        dc.b $0d,"AS GLASS. ON THE OTHER SIDE ARE BLACK",$0d,"TENTS.",$0d,0
d4
        dc.b $1d,"YOU HIDE BEHIND A ROCK AT THE EDGE OF",$0d,"VEX'S CAMP. THE BIGGEST TENT IS TO THE"
        dc.b $0d,"EAST. A PATH LEADS NORTH TO THE TEMPLE",$0d,"STEPS.",$0d,0
d5
        dc.b $1d,"YOU ARE INSIDE COMMANDER VEX'S TENT.",$0d,"MAPS AND STRANGE MACHINES COVER A"
        dc.b $0d,"TABLE.",$0d,0
d6
        dc.b $1d,"YOU STAND AT THE FOOT OF THE TEMPLE",$0d,"STEPS. THOUSANDS OF CRYSTAL STAIRS"
        dc.b $0d,"CLIMB UP TO THE SHINING SKY TEMPLE.",$0d,0
t0
        dc.b 0
t1
        dc.b $11,"IT WILL NEVER FLY AGAIN.",$0d,0
t2
        dc.b $11,"DEEP, FRESH SNOW. GOOD FOR SNOWBALLS.",$0d,0
t3
        dc.b "A SNOWBALL",0
t4
        dc.b $11,"HARD AND COLD.",$0d,0
t5
        dc.b $11,"WHITE FUR, SIX LEGS AND TEETH LIKE",$0d,"ICICLES. IT IS FAST ASLEEP."
        dc.b $0d,0
t6
        dc.b $11,"OLD ROPES, BROKEN SLEDGES... AND",$0d,"SOMETHING THAT GLITTERS."
        dc.b $0d,0
t7
        dc.b "A PAIR OF SPIKED BOOTS",0
t8
        dc.b $11,"BOOTS WITH IRON SPIKES UNDER THE SOLES.",$0d,"PERFECT FOR ICE."
        dc.b $0d,0
t9
        dc.b "SPIKED BOOTS (WORN)",0
t10
        dc.b $11,"THEY GRIP THE ICE WELL.",$0d,0
t11
        dc.b $11,"A BRIDGE OF PURE ICE. ONE SLIP AND YOU",$0d,"ARE GONE.",$0d,0
t12
        dc.b $11,"TWO SOLDIERS IN BLACK, GUARDING THE BIG",$0d,"TENT.",$0d,0
t13
        dc.b $11,"BLACK TENTS WITH THE SIGN OF A RAVEN IN",$0d,"A CIRCLE.",$0d
        dc.b 0
t14
        dc.b "THE AMULET",0
t15
        dc.b $11,"YOUR AMULET! IT GLOWS WARMLY, AS IF IT",$0d,"KNOWS YOU.",$0d
        dc.b 0
t16
        dc.b $11,"VEX'S PLANS: DRAIN THE STAR HEART, SELL",$0d,"ITS POWER, RULE THE GALAXY. CHARMING."
        dc.b $0d,0
t17
        dc.b $11,"CRYSTAL STAIRS, GLITTERING ALL THE WAY",$0d,"TO THE TEMPLE."
        dc.b $0d,0
t_save
        dc.b "SAVE1-MOUNTAINS",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$54,$48,$45,$20,$43,$52,$59,$53,$54,$41,$4c,$20,$4d,$4f,$55,$4e,$54,$41,$49,$4e,$53,$0d,$1f,$20,$02,$49
        dc.b $43,$45,$20,$43,$41,$56,$45,$0e,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$06,$53,$54,$45,$50,$53,$0e,$0d,$1f,$20,$20
        dc.b $20,$20,$62,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$20,$01,$4c,$45,$44,$47
        dc.b $45,$0e,$60,$60,$60,$60,$60,$03,$42,$52,$49,$44,$47,$45,$0e,$60,$60,$60,$60,$60,$04,$43,$41,$4d,$50,$0e,$60,$60,$60,$60,$60,$60
        dc.b $05,$54,$45,$4e,$54,$0e,$0d,$00
        even
song
        dc.w 3                  ; voices
        dc.b $10,$4a,$a9,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$6a,$9a,$02     ; waveform, attack/decay, sustain/release, pulse
        dc.b $10,$00,$60,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $18,$80,$14,$80,$1b,$80,$16,$80,$18,$80,$14,$80,$1b,$80,$16,$80,$ff
song_v2
        dc.b $43,$40,$41,$20,$3f,$20,$3e,$60,$00,$20,$3f,$40,$3c,$40,$3a,$80,$43,$40,$44,$20,$43,$20,$41,$60,$00,$20,$3f,$40,$3e,$40,$3c,$80
        dc.b $ff
song_v3
        dc.b $3c,$08,$3f,$08,$43,$08,$3f,$08,$3c,$08,$3f,$08,$43,$08,$3f,$08,$3c,$08,$3f,$08,$43,$08,$3f,$08,$3c,$08,$3f,$08,$43,$08,$3f,$08
        dc.b $38,$08,$3c,$08,$3f,$08,$3c,$08,$38,$08,$3c,$08,$3f,$08,$3c,$08,$38,$08,$3c,$08,$3f,$08,$3c,$08,$38,$08,$3c,$08,$3f,$08,$3c,$08
        dc.b $3f,$08,$43,$08,$46,$08,$43,$08,$3f,$08,$43,$08,$46,$08,$43,$08,$3f,$08,$43,$08,$46,$08,$43,$08,$3f,$08,$43,$08,$46,$08,$43,$08
        dc.b $3a,$08,$3e,$08,$41,$08,$3e,$08,$3a,$08,$3e,$08,$41,$08,$3e,$08,$3a,$08,$3e,$08,$41,$08,$3e,$08,$3a,$08,$3e,$08,$41,$08,$3e,$08
        dc.b $3c,$08,$3f,$08,$43,$08,$3f,$08,$3c,$08,$3f,$08,$43,$08,$3f,$08,$3c,$08,$3f,$08,$43,$08,$3f,$08,$3c,$08,$3f,$08,$43,$08,$3f,$08
        dc.b $38,$08,$3c,$08,$3f,$08,$3c,$08,$38,$08,$3c,$08,$3f,$08,$3c,$08,$38,$08,$3c,$08,$3f,$08,$3c,$08,$38,$08,$3c,$08,$3f,$08,$3c,$08
        dc.b $3f,$08,$43,$08,$46,$08,$43,$08,$3f,$08,$43,$08,$46,$08,$43,$08,$3f,$08,$43,$08,$46,$08,$43,$08,$3f,$08,$43,$08,$46,$08,$43,$08
        dc.b $3a,$08,$3e,$08,$41,$08,$3e,$08,$3a,$08,$3e,$08,$41,$08,$3e,$08,$3a,$08,$3e,$08,$41,$08,$3e,$08,$3a,$08,$3e,$08,$41,$08,$3e,$08
        dc.b $ff
        even
actors                               ; moving sprites per room
;       room, sprites, first image, images, image delay, move delay, dx, dy
;       x, y (C64 sprite coordinates), height in lines, colours 1-3
        dc.b 1,1,0,2,6,2,1,1
        dc.w 104,59,7,$112,$335,$fd6
        dc.b 3,1,2,2,6,2,-1,1
        dc.w 244,61,7,$112,$335,$fd6
        dc.b 4,3,4,1,8,6,1,0
        dc.w 64,55,12,$000,$bbd,$eef
        dc.b 6,2,5,2,6,1,-1,0
        dc.w 324,59,8,$fa4,$fe8,$fff
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
fr0                              ; "bird1": 1 sprite(s), 7 lines
        dc.w $c006,$0000,$600c,$0000,$3838,$0000,$1e78,$0080,$06f8,$0118,$01c0,$0000,$0000,$0000
fr1                              ; "bird2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$0000,$0000,$0600,$0080,$7ef0,$0110,$fffc,$000c,$01c0,$0000,$0000,$0000
fr2                              ; "bird1": 1 sprite(s), 7 lines
        dc.w $c006,$0000,$600c,$0000,$3838,$0000,$1e78,$0080,$06f8,$0118,$01c0,$0000,$0000,$0000
fr3                              ; "bird2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$0000,$0000,$0600,$0080,$7ef0,$0110,$fffc,$000c,$01c0,$0000,$0000,$0000
fr4                              ; "cloud": 3 sprite(s), 12 lines
        dc.w $0000,$0000,$0000,$0003,$0007,$007f,$007f,$03ff,$03ff,$0fff,$0fff,$1fff,$1fff,$3fff,$3fff,$7fff
        dc.w $3fff,$7fff,$0fff,$3fff,$001f,$0fff,$0000,$001f
        dc.w $0000,$1e00,$3f00,$fff0,$fff8,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$ffff
        dc.w $ffff,$ffff,$ffff,$ffff,$ffff,$ffff,$0000,$ffff
        dc.w $0000,$0000,$0000,$0000,$0000,$01c0,$0380,$ffc0,$ffc0,$fff0,$fff0,$fff8,$fff8,$fffc,$fffc,$fffe
        dc.w $fffc,$fffe,$fff0,$fffc,$fc00,$fff0,$0000,$f800
fr5                              ; "comet1": 2 sprite(s), 8 lines
        dc.w $0000,$0000,$0000,$0000,$0000,$001e,$001f,$07ff,$e7ff,$1fff,$001f,$07ff,$0000,$001e,$0000,$0000
        dc.w $0000,$0000,$0000,$0400,$0300,$8f00,$ef80,$ffc0,$ffe0,$fff0,$ef80,$ffc0,$0300,$8f00,$0000,$0400
fr6                              ; "comet2": 2 sprite(s), 8 lines
        dc.w $0000,$0000,$0000,$0004,$0000,$01ef,$003f,$1fff,$e3ff,$1fff,$003f,$1fff,$0000,$01ef,$0000,$0004
        dc.w $0000,$0000,$0000,$1000,$0600,$0e00,$ef80,$ff80,$fff0,$fff8,$ef80,$ff80,$0600,$0e00,$0000,$1000
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 19,0
        dc.l $01a912             ; NOVA: Get the amulet back, pilot. the temple n
        dc.w 0
card                                 ; next part: kind, name, spoken title (in the blob)
        dc.l card_k-base,card_n-base
        dc.l $01cd22             ; "Chapter 8. The Sky Temple"
card_k
        dc.b "CHAPTER 8",0
card_n
        dc.b "THE SKY TEMPLE",0
        even
        even
part_end
