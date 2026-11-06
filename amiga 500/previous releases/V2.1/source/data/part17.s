;======================================================================
;  THE WORLD OF STRONKIE V2.1 (Amiga) - EPILOGUE: HOME AGAIN
;  Created By Mark Stronks
;
;  Part file "PART17": vasm -Fbin -o part17.bin part17.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_EGARDEN     = $000000      ; picture "egarden" in the blob
PIC_HALL        = $003e06      ; picture "hall" in the blob
PIC_STUDY       = $009472      ; picture "study" in the blob

base
        dc.b "CHAP"
        dc.b 17,1,3,6       ; part, start room, rooms, objects
        dc.l rooms-base
        dc.l objects-base
        dc.l nouns-base
        dc.l actions-base
        dc.l messages-base
        dc.l t_intro-base
        dc.l song-base            ; music
        dc.l t_title-base
        dc.l t_short-base
        dc.l 0            ; title card of the next part
        dc.l t_quip-base
        dc.l actors-base, frames-base
        dc.l map_data-base
        dc.l t_save-base
        dc.l 0            ; jingle (TUNE action)
        dc.b 13,11
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_EGARDEN
        dc.b 2,0,0,0,0,0,0,0      ; garden
        dc.l d2-base,PIC_HALL
        dc.b 3,1,0,0,0,0,0,0      ; hall
        dc.l d3-base,PIC_STUDY
        dc.b 0,2,0,0,0,0,0,0      ; study
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,255,1,0
        dc.l t0-base,t1-base
        dc.b 2,1,2,0
        dc.l t2-base,t3-base
        dc.b 3,1,2,0
        dc.l t2-base,t4-base
        dc.b 4,2,2,0
        dc.l t2-base,t5-base
        dc.b 5,2,2,0
        dc.l t2-base,t6-base
        dc.b 6,3,2,0
        dc.l t2-base,t7-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "FRAG",1
        dc.b "PIEC",1
        dc.b "SHIP",2
        dc.b "STAR",2
        dc.b "PIP ",3
        dc.b "BUTT",3
        dc.b "EDMU",4
        dc.b "UNCL",4
        dc.b "PORT",4
        dc.b "VICT",5
        dc.b "VEX ",5
        dc.b "DESK",6
        dc.b "GLOB",6
        dc.b "LAMP",7
        dc.b "FORC",8
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $20,$03,$08,$04,$01,$20,$01,$00
        dc.b $20,$04,$08,$04,$02,$20,$02,$00
        dc.b $20,$05,$08,$04,$02,$20,$03,$00
        dc.b $20,$00,$08,$04,$02,$20,$02,$00
        dc.b $0a,$01,$13,$04,$03,$05,$3f,$20,$04,$26,$1e,$2b,$0a,$2d,$14,$20,$05,$28,$00
        dc.b $0a,$06,$13,$04,$03,$05,$3f,$20,$04,$26,$1e,$2b,$0a,$2d,$14,$20,$05,$28,$00
        dc.b $0f,$01,$13,$04,$03,$05,$3f,$20,$04,$26,$1e,$2b,$0a,$2d,$14,$20,$05,$28,$00
        dc.b $0f,$06,$13,$04,$03,$05,$3f,$20,$04,$26,$1e,$2b,$0a,$2d,$14,$20,$05,$28,$00
        dc.b $40,$01,$13,$04,$03,$05,$3f,$20,$04,$26,$1e,$2b,$0a,$2d,$14,$20,$05,$28,$00
        dc.b $40,$06,$13,$04,$03,$05,$3f,$20,$04,$26,$1e,$2b,$0a,$2d,$14,$20,$05,$28,$00
        dc.b $0a,$01,$0d,$04,$03,$20,$06,$26,$0a,$20,$07,$28,$00
        dc.b $0a,$06,$0d,$04,$03,$20,$06,$26,$0a,$20,$07,$28,$00
        dc.b $0f,$01,$0d,$04,$03,$20,$06,$26,$0a,$20,$07,$28,$00
        dc.b $0f,$06,$0d,$04,$03,$20,$06,$26,$0a,$20,$07,$28,$00
        dc.b $40,$01,$0d,$04,$03,$20,$06,$26,$0a,$20,$07,$28,$00
        dc.b $40,$06,$0d,$04,$03,$20,$06,$26,$0a,$20,$07,$28,$00
        dc.b $0a,$01,$06,$20,$08,$00
        dc.b $37,$00,$06,$20,$09,$00
        dc.b $45,$00,$06,$20,$0a,$00
        dc.b $46,$00,$06,$20,$0b,$00
        dc.b $47,$00,$06,$20,$0c,$00
        dc.b $0f,$08,$06,$20,$0d,$00
        dc.b $09,$07,$06,$20,$0e,$00
        dc.b $22,$00,$06,$20,$0f,$00
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
m1
        dc.b $11,"'EARTH HAS ONLY ONE SUN! HOW DO YOU",$0d,"EVEN SEE ANYTHING?'"
        dc.b $0d,0
m2
        dc.b $17,"UNCLE EDMUND: 'GO AND HAVE A LOOK AT MY",$0d,"STAR GLOBE IN THE STUDY. BRING YOUR"
        dc.b $0d,"STAR FRAGMENTS.'",$0d,0
m3
        dc.b $11,"VICTOR LOOKS AT HIS SHOES. 'I'M SORRY,",$0d,"KID. FOR EVERYTHING.' EDMUND: 'HE'S"
        dc.b $0d,"DOING THE DISHES FOR THE NEXT HUNDRED",$0d,"YEARS.'",$0d,0
m4
        dc.b $11,"YOU LAY ALL SIXTEEN STAR FRAGMENTS ON",$0d,"THE DESK. ONE BY ONE THEY RISE INTO THE"
        dc.b $0d,"AIR AND FORM A GLOWING STAR MAP... IT",$0d,"SHOWS A WORLD NOBODY HAS EVER SEEN."
        dc.b $0d,"UNCLE EDMUND AND VICTOR WHISPER",$0d,"TOGETHER: 'THE OTHER STRONKIE WORLD."
        dc.b $0d,"THE ONE FROM THE OLD LEGENDS!' NOVA:",$0d,"'COURSE PLOTTED, PILOT. WHENEVER YOU'RE"
        dc.b $0d,"READY.'",$0d,0
m5
        dc.b $11,"*** THE TRUE ENDING *** THE WORLD OF",$0d,"STRONKIE WILL RETURN... CREATED BY MARK"
        dc.b $0d,"STRONKS AKA STRONKIE.",$0d,0
m6
        dc.b $11,"YOU LAY YOUR STAR FRAGMENTS ON THE",$0d,"DESK. THEY FLICKER... BUT NOTHING"
        dc.b $0d,"HAPPENS. SOME PIECES ARE STILL MISSING.",$0d,"(FIND ALL 16 STAR FRAGMENTS FOR THE"
        dc.b $0d,"TRUE ENDING!) UNCLE EDMUND SMILES:",$0d,"'HOME AT LAST. THANK YOU, KID.'"
        dc.b $0d,0
m7
        dc.b $11,"THE END. THE WORLD OF STRONKIE WAS",$0d,"CREATED BY MARK STRONKS AKA STRONKIE."
        dc.b $0d,0
m8
        dc.b $11,"KEEP THEM. UNCLE EDMUND'S STAR GLOBE IS",$0d,"IN THE STUDY."
        dc.b $0d,0
m9
        dc.b $11,"GO TO THE STUDY AND PUT YOUR STAR",$0d,"FRAGMENTS ON THE DESK."
        dc.b $0d,0
m10
        dc.b $11,"A HOLLOW VOICE SAYS: WRONG GAME. THIS",$0d,"ISN'T COLOSSAL CAVE."
        dc.b $0d,0
m11
        dc.b $11,"GOD MODE? NICE TRY. THIS IS A COMMODORE",$0d,"64, NOT A 486."
        dc.b $0d,0
m12
        dc.b $11,"THAT'S THE ANSWER TO LIFE, THE UNIVERSE",$0d,"AND EVERYTHING. BUT WHAT WAS THE"
        dc.b $0d,"QUESTION?",$0d,0
m13
        dc.b $11,"YOU WAVE YOUR HAND. THESE AREN'T THE",$0d,"COMMANDS YOU'RE LOOKING FOR."
        dc.b $0d,0
m14
        dc.b $11,"THERE IS NO LAMP HERE. THIS ISN'T ZORK,",$0d,"YOU KNOW. BUT WATCH OUT FOR GRUES"
        dc.b $0d,"ANYWAY.",$0d,0
m15
        dc.b $11,"TYPE COMMANDS LIKE TAKE KEY, OPEN DOOR,",$0d,"EXAMINE MAT, N S E W U D, L = LOOK,"
        dc.b $0d,"I = INVENTORY, TAKE ALL, DROP ALL,",$0d,"G = AGAIN, SCORE, MAP, SAVE, LOAD, QUIT"
        dc.b $0d,"F1 LOAD  F3 SAVE  F5 MUSIC  F7 QUIT",$0d,"THREE SAVE SLOTS: PRESS 1, 2 OR 3."
        dc.b $0d,"HINT GIVES A CLUE BUT COSTS 3 POINTS.",$0d,"FIND THE 16 HIDDEN STAR FRAGMENTS!"
        dc.b $0d,0
t_intro
        dc.b $11,"WEEKS LATER, THE STARRAVEN LANDS IN THE",$0d,"GARDEN OF RAVENMOOR MANOR. THE STORM IS"
        dc.b $0d,"LONG GONE. UNCLE EDMUND AND VICTOR -",$0d,"NOT VEX ANY MORE - CLIMB OUT, ARGUING"
        dc.b $0d,"ABOUT WHO GETS THE BIGGER ROOM. PIP",$0d,"WAVES FROM THE HATCH: HE WANTED TO SEE"
        dc.b $0d,"EARTH.",$0d,$0d,0
t_title
        dc.b $17,$0d,"EPILOGUE: HOME AGAIN",$0d,$0d,0
t_short
        dc.b "EPILOGUE",0
t_quip
        dc.b $17,"YOU DIED AT HOME? AFTER ALL THAT?",$0d,"IMPRESSIVE.",$0d,0
d1
        dc.b $1d,"YOU ARE IN THE GARDEN OF RAVENMOOR. THE",$0d,"STARRAVEN STANDS ON THE LAWN, AND PIP"
        dc.b $0d,"CHASES BUTTERFLIES. THE MANOR LIES",$0d,"NORTH.",$0d,0
d2
        dc.b $1d,"YOU ARE IN THE GRAND HALL. UNCLE EDMUND",$0d,"AND VICTOR ARE HANGING AN OLD FAMILY"
        dc.b $0d,"PORTRAIT BACK ON THE WALL. THE STUDY IS",$0d,"NORTH.",$0d,0
d3
        dc.b $1d,"YOU ARE IN UNCLE EDMUND'S STUDY.",$0d,"MOONLIGHT FALLS ON THE BIG OAK DESK. A"
        dc.b $0d,"BRASS STAR GLOBE STANDS BESIDE IT.",$0d,0
t0
        dc.b "YOUR STAR FRAGMENTS",0
t1
        dc.b $11,"TINY PIECES OF STARLIGHT. THEY GLOW AND",$0d,"HUM.",$0d,0
t2
        dc.b 0
t3
        dc.b $11,"HOME, SAFE AND SOUND.",$0d,0
t4
        dc.b $11,"PIP IS VERY EXCITED ABOUT BUTTERFLIES.",$0d,0
t5
        dc.b $11,"TWO BROTHERS AND A CROOKED PORTRAIT.",$0d,"IT'S GOOD TO SEE THEM TOGETHER."
        dc.b $0d,0
t6
        dc.b $11,"VICTOR RAVENMOOR, NO LONGER COMMANDER",$0d,"VEX. HE LOOKS RATHER SHEEPISH."
        dc.b $0d,0
t7
        dc.b $11,"UNCLE EDMUND'S DESK. THE BRASS GLOBE",$0d,"HAS SIXTEEN EMPTY LITTLE HOLLOWS IN IT,"
        dc.b $0d,"LIKE STARS.",$0d,0
t_save
        dc.b "SAVE1-EPILOGUE",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$48,$4f,$4d,$45,$20,$41,$47,$41,$49,$4e,$0d,$1f,$20,$20,$03,$53,$54,$55,$44,$59,$0e,$0d,$1f,$20,$20,$20
        dc.b $20,$62,$0d,$1f,$20,$20,$20,$02,$48,$41,$4c,$4c,$0e,$0d,$1f,$20,$20,$20,$20,$62,$0d,$1f,$20,$20,$01,$47,$41,$52,$44,$45,$4e,$0e
        dc.b $0d,$00
        even
song
        dc.w 3                  ; voices
        dc.b $10,$08,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$08,$46,$04     ; waveform, attack/decay, sustain/release, pulse
        dc.b $10,$0a,$40,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $1b,$18,$22,$18,$27,$18,$22,$18,$17,$18,$1e,$18,$23,$18,$1e,$18,$14,$18,$1b,$18,$20,$18,$1b,$18,$16,$18,$1d,$18,$22,$18,$26,$18
        dc.b $1b,$18,$22,$18,$27,$18,$22,$18,$17,$18,$1e,$18,$23,$18,$1e,$18,$14,$18,$1b,$18,$20,$18,$1b,$18,$16,$18,$1d,$18,$22,$18,$26,$18
        dc.b $ff
song_v2
        dc.b $3f,$0c,$3a,$0c,$36,$0c,$3a,$0c,$3f,$0c,$3a,$0c,$36,$0c,$3a,$0c,$3f,$0c,$3b,$0c,$36,$0c,$3b,$0c,$3f,$0c,$3b,$0c,$36,$0c,$3b,$0c
        dc.b $3f,$0c,$3b,$0c,$38,$0c,$3b,$0c,$3f,$0c,$3b,$0c,$38,$0c,$3b,$0c,$3e,$0c,$3a,$0c,$35,$0c,$3a,$0c,$3e,$0c,$3a,$0c,$35,$0c,$3a,$0c
        dc.b $42,$18,$41,$0c,$3f,$0c,$3e,$18,$3a,$18,$3f,$18,$3d,$0c,$3b,$0c,$3a,$30,$3b,$18,$3a,$0c,$38,$0c,$36,$18,$35,$18,$35,$30,$3e,$18
        dc.b $3a,$18,$ff
song_v3
        dc.b $4b,$60,$42,$60,$44,$60,$41,$60,$4b,$60,$42,$60,$44,$60,$41,$60,$ff
        even
actors                               ; moving sprites per room
;       room, sprites, first image, images, image delay, move delay, dx, dy
;       x, y (C64 sprite coordinates), height in lines, colours 1-3
        dc.b 1,1,0,2,5,3,1,1
        dc.w 104,121,7,$222,$fc4,$4cf
        dc.b 1,1,2,2,6,4,-1,-1
        dc.w 264,129,7,$222,$fc4,$4cf
        dc.b 0
        even
frames                               ; offsets of the sprite images
        dc.l fr0-base
        dc.l fr1-base
        dc.l fr2-base
        dc.l fr3-base
fr0                              ; "fly1": 1 sprite(s), 7 lines
        dc.w $6180,$0000,$9240,$6180,$8c20,$73c0,$4640,$3f80,$2f40,$1680,$4d20,$30c0,$71c0,$0000
fr1                              ; "fly2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$3180,$0000,$4a40,$3180,$4c80,$3f00,$2f40,$1680,$1540,$0880,$0000,$0000
fr2                              ; "fly1": 1 sprite(s), 7 lines
        dc.w $6180,$0000,$9240,$6180,$8c20,$73c0,$4640,$3f80,$2f40,$1680,$4d20,$30c0,$71c0,$0000
fr3                              ; "fly2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$3180,$0000,$4a40,$3180,$4c80,$3f00,$2f40,$1680,$1540,$0880,$0000,$0000
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 4,0
        dc.l $00e16e             ; NOVA: Course plotted, pilot. whenever you're r
        dc.w 0
        even
part_end
