;======================================================================
;  THE WORLD OF STRONKIE V2.1 (Amiga) - CHAPTER 4: SPACE PIRATES
;  Created By Mark Stronks
;
;  Part file "PART07": vasm -Fbin -o part07.bin part07.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_PCOCKPIT    = $000000      ; picture "pcockpit" in the blob
PIC_PAIRLOCK    = $002bca      ; picture "pairlock" in the blob
PIC_DECK        = $009242      ; picture "deck" in the blob
PIC_CABIN       = $00cca2      ; picture "cabin" in the blob
PIC_PENGINE     = $011e50      ; picture "pengine" in the blob

base
        dc.b "CHAP"
        dc.b 7,1,5,16       ; part, start room, rooms, objects
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
        dc.b 9,8
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_PCOCKPIT
        dc.b 0,0,0,0,0,2,0,0      ; cockpit
        dc.l d2-base,PIC_PAIRLOCK
        dc.b 0,0,0,0,1,0,0,0      ; airlock
        dc.l d3-base,PIC_DECK
        dc.b 0,0,0,0,0,0,0,0      ; deck
        dc.l d4-base,PIC_CABIN
        dc.b 0,3,0,0,0,0,0,0      ; cabin
        dc.l d5-base,PIC_PENGINE
        dc.b 0,0,0,3,0,0,0,0      ; pengine
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,1,2,0
        dc.l t0-base,t1-base
        dc.b 2,1,2,0
        dc.l t0-base,t2-base
        dc.b 3,2,2,0
        dc.l t0-base,t3-base
        dc.b 4,2,2,0
        dc.l t0-base,t4-base
        dc.b 4,3,2,0
        dc.l t0-base,t5-base
        dc.b 5,255,1,0
        dc.l t6-base,t7-base
        dc.b 6,3,0,0
        dc.l t8-base,t9-base
        dc.b 7,3,2,0
        dc.l t0-base,t10-base
        dc.b 8,3,2,0
        dc.l t0-base,t11-base
        dc.b 9,4,2,0
        dc.l t0-base,t12-base
        dc.b 10,4,2,0
        dc.l t0-base,t13-base
        dc.b 11,0,1,0
        dc.l t14-base,t15-base
        dc.b 12,5,2,0
        dc.l t0-base,t16-base
        dc.b 13,5,2,0
        dc.l t0-base,t17-base
        dc.b 14,5,2,0
        dc.l t0-base,t18-base
        dc.b 15,4,2,0
        dc.l t0-base,t19-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "GALL",1
        dc.b "BEAM",1
        dc.b "WIND",1
        dc.b "FLAG",1
        dc.b "THRO",2
        dc.b "CONS",2
        dc.b "ALAR",2
        dc.b "DOOR",3
        dc.b "HATC",3
        dc.b "CABL",4
        dc.b "ROPE",4
        dc.b "LINE",4
        dc.b "CHIC",5
        dc.b "PULL",5
        dc.b "GUAR",6
        dc.b "PIRA",6
        dc.b "CUTL",6
        dc.b "PARR",7
        dc.b "BIRD",7
        dc.b "POLL",7
        dc.b "POST",8
        dc.b "WANT",8
        dc.b "MAST",8
        dc.b "CAPT",9
        dc.b "LECH",9
        dc.b "BEAR",9
        dc.b "DESK",10
        dc.b "COIN",10
        dc.b "BUCK",10
        dc.b "KEY ",11
        dc.b "GENE",12
        dc.b "KEYH",12
        dc.b "MACH",12
        dc.b "CRAT",13
        dc.b "GROG",13
        dc.b "CREW",14
        dc.b "ENSI",14
        dc.b "SHIR",14
        dc.b "RICK",14
        dc.b "CAKE",15
        dc.b "COW ",16
        dc.b "HOW ",16
        dc.b "APPR",16
        dc.b "REUN",17
        dc.b "FAMI",17
        dc.b "GLAD",17
        dc.b "MONK",18
        dc.b "THRE",18
        dc.b "LOOK",18
        dc.b "SO  ",19
        dc.b "LAMP",20
        dc.b "FORC",21
        dc.b "GRAN",22
        dc.b "SHE ",22
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $19,$00,$13,$04,$05,$01,$0f,$20,$01,$23,$0f,$00,$21,$3a,$26,$05,$2b,$06,$00
        dc.b $20,$00,$0a,$04,$05,$01,$0f,$20,$02,$00
        dc.b $20,$00,$0a,$04,$05,$05,$3a,$20,$03,$00
        dc.b $2c,$16,$12,$04,$04,$05,$00,$06,$3b,$20,$04,$21,$3b,$26,$0a,$2b,$05,$00
        dc.b $2c,$09,$12,$04,$04,$05,$00,$06,$3b,$20,$04,$21,$3b,$26,$0a,$2b,$05,$00
        dc.b $2c,$00,$0e,$04,$04,$05,$00,$06,$3b,$20,$05,$2b,$04,$00
        dc.b $20,$00,$0c,$04,$04,$05,$00,$06,$3b,$20,$06,$00
        dc.b $20,$00,$0a,$04,$04,$05,$3b,$20,$07,$00
        dc.b $1d,$09,$0a,$04,$04,$05,$00,$20,$08,$00
        dc.b $1e,$0f,$08,$04,$04,$20,$09,$00
        dc.b $09,$0f,$08,$04,$04,$20,$09,$00
        dc.b $3d,$13,$06,$20,$0a,$00
        dc.b $0c,$0d,$0d,$04,$05,$06,$01,$20,$0b,$21,$01,$2c,$00
        dc.b $1c,$0d,$0d,$04,$05,$06,$01,$20,$0b,$21,$01,$2c,$00
        dc.b $08,$0d,$0d,$04,$05,$06,$01,$20,$0b,$21,$01,$2c,$00
        dc.b $33,$00,$12,$04,$01,$05,$02,$20,$0c,$26,$0a,$2b,$0a,$2d,$0c,$27,$08,$00
        dc.b $34,$00,$12,$04,$01,$05,$02,$20,$0c,$26,$0a,$2b,$0a,$2d,$0c,$27,$08,$00
        dc.b $14,$02,$12,$04,$01,$05,$02,$20,$0c,$26,$0a,$2b,$0a,$2d,$0c,$27,$08,$00
        dc.b $0f,$02,$12,$04,$01,$05,$02,$20,$0c,$26,$0a,$2b,$0a,$2d,$0c,$27,$08,$00
        dc.b $33,$00,$08,$04,$01,$20,$0d,$00
        dc.b $34,$00,$08,$04,$01,$20,$0d,$00
        dc.b $14,$02,$08,$04,$01,$20,$0d,$00
        dc.b $0f,$02,$08,$04,$01,$20,$0d,$00
        dc.b $20,$00,$0a,$04,$01,$06,$02,$20,$0e,$00
        dc.b $20,$00,$08,$04,$01,$20,$0f,$00
        dc.b $0d,$03,$10,$04,$02,$06,$03,$20,$10,$21,$03,$26,$05,$2b,$06,$00
        dc.b $26,$00,$0b,$04,$02,$05,$03,$20,$11,$29,$00
        dc.b $43,$04,$0a,$04,$02,$06,$03,$20,$12,$00
        dc.b $43,$05,$0a,$04,$02,$06,$03,$20,$12,$00
        dc.b $0f,$04,$0a,$04,$02,$06,$03,$20,$12,$00
        dc.b $0f,$05,$0a,$04,$02,$06,$03,$20,$12,$00
        dc.b $1b,$04,$0a,$04,$02,$06,$03,$20,$12,$00
        dc.b $1b,$05,$0a,$04,$02,$06,$03,$20,$12,$00
        dc.b $01,$04,$0a,$04,$02,$06,$03,$20,$12,$00
        dc.b $01,$05,$0a,$04,$02,$06,$03,$20,$12,$00
        dc.b $43,$04,$0a,$04,$02,$03,$06,$20,$13,$00
        dc.b $43,$05,$0a,$04,$02,$03,$06,$20,$13,$00
        dc.b $0f,$04,$0a,$04,$02,$03,$06,$20,$13,$00
        dc.b $0f,$05,$0a,$04,$02,$03,$06,$20,$13,$00
        dc.b $1b,$04,$0a,$04,$02,$03,$06,$20,$13,$00
        dc.b $1b,$05,$0a,$04,$02,$03,$06,$20,$13,$00
        dc.b $01,$04,$0a,$04,$02,$03,$06,$20,$13,$00
        dc.b $01,$05,$0a,$04,$02,$03,$06,$20,$13,$00
        dc.b $43,$04,$10,$04,$02,$06,$04,$20,$14,$21,$04,$26,$05,$24,$03,$00
        dc.b $43,$05,$10,$04,$02,$06,$04,$20,$14,$21,$04,$26,$05,$24,$03,$00
        dc.b $0f,$04,$10,$04,$02,$06,$04,$20,$14,$21,$04,$26,$05,$24,$03,$00
        dc.b $0f,$05,$10,$04,$02,$06,$04,$20,$14,$21,$04,$26,$05,$24,$03,$00
        dc.b $1b,$04,$10,$04,$02,$06,$04,$20,$14,$21,$04,$26,$05,$24,$03,$00
        dc.b $1b,$05,$10,$04,$02,$06,$04,$20,$14,$21,$04,$26,$05,$24,$03,$00
        dc.b $01,$04,$10,$04,$02,$06,$04,$20,$14,$21,$04,$26,$05,$24,$03,$00
        dc.b $01,$05,$10,$04,$02,$06,$04,$20,$14,$21,$04,$26,$05,$24,$03,$00
        dc.b $43,$04,$0a,$04,$02,$20,$15,$24,$03,$00
        dc.b $43,$05,$0a,$04,$02,$20,$15,$24,$03,$00
        dc.b $0f,$04,$0a,$04,$02,$20,$15,$24,$03,$00
        dc.b $0f,$05,$0a,$04,$02,$20,$15,$24,$03,$00
        dc.b $1b,$04,$0a,$04,$02,$20,$15,$24,$03,$00
        dc.b $1b,$05,$0a,$04,$02,$20,$15,$24,$03,$00
        dc.b $01,$04,$0a,$04,$02,$20,$15,$24,$03,$00
        dc.b $01,$05,$0a,$04,$02,$20,$15,$24,$03,$00
        dc.b $43,$04,$0a,$04,$03,$03,$06,$20,$13,$00
        dc.b $43,$05,$0a,$04,$03,$03,$06,$20,$13,$00
        dc.b $0f,$04,$0a,$04,$03,$03,$06,$20,$13,$00
        dc.b $0f,$05,$0a,$04,$03,$03,$06,$20,$13,$00
        dc.b $1b,$04,$0a,$04,$03,$03,$06,$20,$13,$00
        dc.b $1b,$05,$0a,$04,$03,$03,$06,$20,$13,$00
        dc.b $01,$04,$0a,$04,$03,$03,$06,$20,$13,$00
        dc.b $01,$05,$0a,$04,$03,$03,$06,$20,$13,$00
        dc.b $43,$04,$0a,$04,$03,$20,$16,$24,$02,$00
        dc.b $43,$05,$0a,$04,$03,$20,$16,$24,$02,$00
        dc.b $0f,$04,$0a,$04,$03,$20,$16,$24,$02,$00
        dc.b $0f,$05,$0a,$04,$03,$20,$16,$24,$02,$00
        dc.b $1b,$04,$0a,$04,$03,$20,$16,$24,$02,$00
        dc.b $1b,$05,$0a,$04,$03,$20,$16,$24,$02,$00
        dc.b $01,$04,$0a,$04,$03,$20,$16,$24,$02,$00
        dc.b $01,$05,$0a,$04,$03,$20,$16,$24,$02,$00
        dc.b $05,$00,$08,$04,$03,$20,$17,$00
        dc.b $02,$00,$0a,$04,$03,$06,$05,$20,$18,$00
        dc.b $04,$00,$0a,$04,$03,$06,$05,$20,$18,$00
        dc.b $2c,$10,$10,$04,$03,$06,$06,$20,$19,$21,$06,$26,$0a,$2b,$08,$00
        dc.b $2c,$11,$1d,$04,$03,$05,$06,$06,$05,$20,$1a,$23,$07,$00,$21,$05,$25,$03,$00,$04,$25,$03,$02,$05,$26,$0a,$2b,$05,$00
        dc.b $2c,$00,$0c,$04,$03,$06,$06,$20,$1b,$2b,$04,$00
        dc.b $2c,$00,$0c,$04,$03,$06,$05,$20,$1c,$2b,$04,$00
        dc.b $20,$06,$0a,$04,$03,$06,$06,$20,$1d,$00
        dc.b $20,$06,$0a,$04,$03,$06,$05,$20,$1e,$00
        dc.b $1d,$06,$0a,$04,$03,$06,$05,$20,$1f,$00
        dc.b $20,$07,$08,$04,$03,$20,$20,$00
        dc.b $3b,$00,$08,$04,$03,$20,$21,$00
        dc.b $09,$07,$06,$20,$22,$00
        dc.b $10,$08,$08,$04,$03,$20,$23,$00
        dc.b $2c,$12,$13,$04,$04,$06,$07,$20,$24,$23,$0c,$ff,$21,$07,$26,$0a,$2b,$02,$00
        dc.b $20,$00,$0a,$04,$04,$06,$07,$20,$25,$00
        dc.b $20,$00,$08,$04,$04,$20,$26,$00
        dc.b $2c,$00,$0a,$04,$04,$06,$07,$20,$27,$00
        dc.b $09,$0b,$0a,$04,$04,$06,$07,$20,$28,$00
        dc.b $09,$0a,$06,$20,$29,$00
        dc.b $1d,$09,$0b,$04,$04,$20,$2a,$2d,$06,$29,$00
        dc.b $11,$00,$14,$04,$05,$02,$0c,$06,$02,$20,$2b,$21,$02,$26,$0a,$2b,$08,$2d,$04,$00
        dc.b $15,$00,$14,$04,$05,$02,$0c,$06,$02,$20,$2b,$21,$02,$26,$0a,$2b,$08,$2d,$04,$00
        dc.b $0f,$0b,$12,$04,$05,$06,$02,$20,$2b,$21,$02,$26,$0a,$2b,$08,$2d,$04,$00
        dc.b $0a,$0b,$12,$04,$05,$06,$02,$20,$2b,$21,$02,$26,$0a,$2b,$08,$2d,$04,$00
        dc.b $15,$00,$0a,$04,$05,$06,$02,$20,$2c,$00
        dc.b $11,$00,$0a,$04,$05,$06,$02,$20,$2c,$00
        dc.b $1f,$0d,$09,$04,$05,$20,$2d,$29,$00
        dc.b $20,$00,$0a,$04,$05,$06,$02,$20,$2e,$00
        dc.b $20,$00,$08,$04,$05,$20,$2f,$00
        dc.b $37,$00,$08,$06,$03,$20,$30,$00
        dc.b $37,$00,$08,$06,$04,$20,$31,$00
        dc.b $37,$00,$08,$06,$06,$20,$32,$00
        dc.b $37,$00,$08,$06,$05,$20,$33,$00
        dc.b $37,$00,$08,$06,$07,$20,$34,$00
        dc.b $37,$00,$08,$06,$02,$20,$35,$00
        dc.b $37,$00,$06,$20,$36,$00
        dc.b $45,$00,$06,$20,$37,$00
        dc.b $46,$00,$06,$20,$38,$00
        dc.b $47,$00,$06,$20,$39,$00
        dc.b $0f,$15,$06,$20,$3a,$00
        dc.b $09,$14,$06,$20,$3b,$00
        dc.b $22,$00,$06,$20,$3c,$00
        dc.b $00,$00,$0e,$04,$03,$06,$08,$20,$3d,$21,$08,$2b,$08,$00
        dc.b $00,$00,$10,$04,$04,$05,$02,$06,$00,$20,$3e,$21,$00,$2b,$08,$00
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
        dc.l m50-base
        dc.l m51-base
        dc.l m52-base
        dc.l m53-base
        dc.l m54-base
        dc.l m55-base
        dc.l m56-base
        dc.l m57-base
        dc.l m58-base
        dc.l m59-base
        dc.l m60-base
        dc.l m61-base
        dc.l m62-base
m1
        dc.b $11,"YOU UNTIE RICKY. 'THANK YOU! FOR ONCE,",$0d,"A RED SHIRT SURVIVES! I'LL HIDE IN AN"
        dc.b $0d,"ESCAPE POD. IF YOU EVER NEED ME, I'LL",$0d,"BE THERE!' HE SNEAKS OFF."
        dc.b $0d,0
m2
        dc.b $11,"'I'M ENSIGN RICKY. THEY CAPTURED ME ON",$0d,"AN AWAY MISSION. I'M WEARING A RED"
        dc.b $0d,"SHIRT, SO... THIS PROBABLY WON'T END",$0d,"WELL. COULD YOU UNTIE ME? OH, AND A"
        dc.b $0d,"TIP: THE CAPTAIN ALWAYS BRAGS THAT HIS",$0d,"GRANDMOTHER FLIES BETTER THAN ANYONE."
        dc.b $0d,"THE PERFECT ANSWER IS: THEN SHE SHOULD",$0d,"BE CAPTAIN!'",$0d
        dc.b 0
m3
        dc.b $11,"RICKY IS GONE, HIDING IN AN ESCAPE POD.",$0d,0
m4
        dc.b $11,"'THEN SHE SHOULD BE CAPTAIN INSTEAD OF",$0d,"YOU!' YOU REPLY. LECHUCKLE'S GHOSTLY"
        dc.b $0d,"JAW DROPS. 'ARRR... NOBODY HAS EVER",$0d,"OUT-INSULTED ME. YE HAVE MY RESPECT,"
        dc.b $0d,"LANDLUBBER. MY CREW WON'T LIFT A FINGER",$0d,"FOR VEX EVER AGAIN!'"
        dc.b $0d,0
m5
        dc.b $11,"'HA! CALL THAT AN INSULT? MY",$0d,"GRANDMOTHER FLIES BETTER THAN YOU!'"
        dc.b $0d,0
m6
        dc.b $11,"'MY GRANDMOTHER FLIES BETTER THAN YOU!'",$0d,"LECHUCKLE REPEATS, WAVING HIS CUTLASS."
        dc.b $0d,0
m7
        dc.b $11,"'ARRR. RESPECT, LANDLUBBER. NOW GET OFF",$0d,"MY SHIP.'",$0d
        dc.b 0
m8
        dc.b $11,"NOT WITH FISTS. SPACE PIRATES FIGHT",$0d,"WITH INSULTS. ANSWER HIM!"
        dc.b $0d,0
m9
        dc.b $11,"IT'S A LIE. AND RATHER STALE.",$0d,0
m10
        dc.b $11,"'MAKE IT SO!' YOU ORDER, IN YOUR BEST",$0d,"STARSHIP CAPTAIN VOICE. NOVA:"
        dc.b $0d,"'ENGAGING... NOTHING, PILOT. I AM NOT",$0d,"THAT KIND OF STARSHIP.' YOU SHALL BE"
        dc.b $0d,"MISSED, SIR PATRICK STEWART - OUR",$0d,"CAPTAIN JEAN-LUC PICARD OF STAR TREK."
        dc.b $0d,"1940-2026.",$0d,0
m11
        dc.b $11,"BETWEEN TWO CRATES OF GROG SOMETHING",$0d,"GLITTERS... A TINY PIECE OF STARLIGHT!"
        dc.b $0d,0
m12
        dc.b $11,"YOU SLAM THE THROTTLE. THE STARRAVEN",$0d,"BREAKS FREE AND SHOOTS AWAY! BEHIND YOU"
        dc.b $0d,"LECHUCKLE SHAKES HIS FIST... AND FIRES",$0d,"ONE PARTING SHOT. BOOM! SMOKE FILLS THE"
        dc.b $0d,"COCKPIT. NOVA: 'MAIN POWER CRYSTAL HIT!",$0d,"WE'RE GOING DOWN, PILOT. STRAIGHT ONTO"
        dc.b $0d,"THE WORLD OF STRONKIE!'",$0d,0
m13
        dc.b $11,"THE ENGINES ROAR, BUT THE TRACTOR BEAM",$0d,"HOLDS THE STARRAVEN LIKE A FLY IN"
        dc.b $0d,"SYRUP.",$0d,0
m14
        dc.b $13,"NOVA: 'THE BEAM COMES FROM THEIR SHIP,",$0d,"PILOT. SOMEBODY HAS TO SWITCH IT OFF"
        dc.b $0d,"FROM THE INSIDE. I WONDER WHO.'",$0d,0
m15
        dc.b $13,"NOVA: 'THE BEAM IS GONE! FLY, PILOT,",$0d,"FLY!'",$0d,0
m16
        dc.b $11,"YOU CHECK YOUR HELMET AND OPEN THE",$0d,"OUTER DOOR. AIR HISSES OUT. THE MOORING"
        dc.b $0d,"CABLE STRETCHES ACROSS THE VOID TO THE",$0d,"PIRATE SHIP.",$0d
        dc.b 0
m17
        dc.b $11,"YOU PUSH OFF TOWARDS THE PIRATE SHIP...",$0d,"AND MISS. AS YOU DRIFT AWAY YOU"
        dc.b $0d,"REMEMBER THAT GUYBRUSH COULD HOLD HIS",$0d,"BREATH FOR TEN MINUTES. YOU CAN NOT."
        dc.b $0d,0
m18
        dc.b $11,"THE OUTER DOOR IS CLOSED.",$0d,0
m19
        dc.b $11,"THE CABLE IS TOO THICK AND SLIPPERY TO",$0d,"HOLD ON TO. YOU'D NEED SOMETHING TO"
        dc.b $0d,"SLIDE ALONG IT WITH.",$0d,0
m20
        dc.b $11,"YOU HOOK THE PULLEY OF THE RUBBER",$0d,"CHICKEN OVER THE CABLE, HOLD ON TIGHT"
        dc.b $0d,"AND... WHEEEE! YOU ZIP ACROSS THE VOID",$0d,"TO THE PIRATE SHIP. STAN WAS RIGHT:"
        dc.b $0d,"EVERYBODY NEEDS A RUBBER CHICKEN WITH A",$0d,"PULLEY IN THE MIDDLE."
        dc.b $0d,0
m21
        dc.b $11,"WHEEE! THE RUBBER CHICKEN CARRIES YOU",$0d,"ALONG THE CABLE."
        dc.b $0d,0
m22
        dc.b $11,"YOU HOOK THE CHICKEN OVER THE CABLE AND",$0d,"ZIP BACK TO THE STARRAVEN."
        dc.b $0d,0
m23
        dc.b $11,"THE STARRAVEN IS AT THE OTHER END OF",$0d,"THE CABLE. RIDE IT BACK."
        dc.b $0d,0
m24
        dc.b $11,"THE GUARD BLOCKS YOUR WAY WITH HIS",$0d,"LASER CUTLASS. 'EN GARDE, LANDLUBBER!'"
        dc.b $0d,0
m25
        dc.b $11,"'HOW APPROPRIATE. YOU FIGHT LIKE A",$0d,"COW!' YOU SAY. THE GUARD TURNS RED."
        dc.b $0d,"'ARRR! THEN TRY THIS ONE: I'VE SPOKEN",$0d,"WITH APES MORE POLITE THAN YOU!'"
        dc.b $0d,0
m26
        dc.b $11,"'I'M GLAD TO HEAR YOU ATTENDED YOUR",$0d,"FAMILY REUNION,' YOU REPLY. THE GUARD"
        dc.b $0d,"BURSTS INTO TEARS, DROPS HIS LASER",$0d,"CUTLASS AND RUNS BELOW DECK TO TELL HIS"
        dc.b $0d,"MOTHER.",$0d,0
m27
        dc.b $11,"'HA! IS THAT ALL YOU'VE GOT?' THE GUARD",$0d,"SNEERS. 'I SAID: YOU FIGHT LIKE A DAIRY"
        dc.b $0d,"FARMER!'",$0d,0
m28
        dc.b $11,"'PATHETIC!' THE GUARD SNEERS. 'I'VE",$0d,"SPOKEN WITH APES MORE POLITE THAN YOU!'"
        dc.b $0d,0
m29
        dc.b $11,"'YOU FIGHT LIKE A DAIRY FARMER!'",$0d,0
m30
        dc.b $11,"'I'VE SPOKEN WITH APES MORE POLITE THAN",$0d,"YOU!'",$0d,0
m31
        dc.b $11,"YOU HAVE NO SWORD. AND ANYWAY, SPACE",$0d,"PIRATES ONLY FIGHT WITH INSULTS. SAY"
        dc.b $0d,"SOMETHING!",$0d,0
m32
        dc.b $11,"SQUAWK! FAMILY REUNION! SQUAWK! GLAD",$0d,"YOU ATTENDED YOUR FAMILY REUNION!"
        dc.b $0d,"SQUAWK! POLLY WANTS A BUCKAZOID!",$0d,0
m33
        dc.b $11,"THE PARROT MUTTERS: SQUAWK! FAMILY",$0d,"REUNION! GLAD YOU ATTENDED YOUR FAMILY"
        dc.b $0d,"REUNION!",$0d,0
m34
        dc.b $11,"IT BITES YOUR GLOVE. SQUAWK!",$0d,0
m35
        dc.b $11,"WANTED: MARK STRONKS AKA STRONKIE.",$0d,"CRIME: WRITING ADVENTURE GAMES ON A"
        dc.b $0d,"COMMODORE 64 AND MAKING PIRATES READ",$0d,"ALL THIS TEXT. REWARD: 3 BUCKAZOIDS."
        dc.b $0d,0
m36
        dc.b $11,"'LOOK BEHIND YOU, A THREE-HEADED",$0d,"MONKEY!' YOU SHOUT. 'WHERE?!' LECHUCKLE"
        dc.b $0d,"SPINS AROUND. QUICK AS A FLASH YOU GRAB",$0d,"THE BIG KEY FROM HIS BELT."
        dc.b $0d,0
m37
        dc.b $11,"'ARRR! YE GOT PAST MY GUARD? NO MATTER.",$0d,"NOTHING IN THE GALAXY CAN MAKE CAPTAIN"
        dc.b $0d,"LECHUCKLE TURN AWAY FROM HIS",$0d,"BUCKAZOIDS. WELL... EXCEPT MAYBE A"
        dc.b $0d,"THREE-HEADED MONKEY. I'VE ALWAYS WANTED",$0d,"TO SEE ONE.'"
        dc.b $0d,0
m38
        dc.b $11,"'HEY! WHERE'S MY KEY?' LECHUCKLE STARTS",$0d,"COUNTING HIS POCKETS."
        dc.b $0d,0
m39
        dc.b $11,"LECHUCKLE DOESN'T EVEN LOOK UP FROM HIS",$0d,"BUCKAZOIDS. 'ARRR. BORING.'"
        dc.b $0d,0
m40
        dc.b $11,"LECHUCKLE SLAPS YOUR HAND AWAY WITHOUT",$0d,"LOOKING UP. 'HANDS OFF, LANDLUBBER!'"
        dc.b $0d,0
m41
        dc.b $11,"LECHUCKLE GROWLS. 'TOUCH MY BUCKAZOIDS",$0d,"AND YE'LL WALK THE PLANK!'"
        dc.b $0d,0
m42
        dc.b $11,"YOU SWING AT LECHUCKLE. YOUR FIST GOES",$0d,"RIGHT THROUGH HIM: HE'S A GHOST PIRATE!"
        dc.b $0d,"HIS FIST, SADLY, DOES NOT GO RIGHT",$0d,"THROUGH YOU...",$0d
        dc.b 0
m43
        dc.b $11,"YOU TURN THE KEY. THE GENERATOR WHINES,",$0d,"SPLUTTERS AND DIES. OUTSIDE, THE GREEN"
        dc.b $0d,"TRACTOR BEAM FLICKERS OUT!",$0d,0
m44
        dc.b $11,"THE GENERATOR HAS A BIG KEYHOLE. YOU'LL",$0d,"NEED THE KEY."
        dc.b $0d,0
m45
        dc.b $11,"YOU PRY OPEN A CRATE AND TAKE A SIP OF",$0d,"PIRATE GROG. YOUR INSIDES DISSOLVE IN A"
        dc.b $0d,"COLOURFUL WAY.",$0d,0
m46
        dc.b $11,"'I'M ENSIGN RICKY. THEY CAPTURED ME ON",$0d,"AN AWAY MISSION. I'M WEARING A RED"
        dc.b $0d,"SHIRT, SO... THIS PROBABLY WON'T END",$0d,"WELL FOR ME.'",$0d
        dc.b 0
m47
        dc.b $11,"'YOU DID IT! I'LL... I'LL JUST STAY",$0d,"HERE. RED SHIRTS NEVER MAKE IT TO THE"
        dc.b $0d,"NEXT CHAPTER ANYWAY.'",$0d,0
m48
        dc.b $11,"GO DOWN TO THE AIRLOCK AND OPEN THE",$0d,"OUTER DOOR.",$0d,0
m49
        dc.b $11,"RIDE THE CABLE WITH THE RUBBER CHICKEN",$0d,"WITH A PULLEY IN THE MIDDLE."
        dc.b $0d,0
m50
        dc.b $11,"ANSWER THE INSULT: HOW APPROPRIATE, YOU",$0d,"FIGHT LIKE A COW. TYPE: SAY COW."
        dc.b $0d,0
m51
        dc.b $11,"LISTEN TO THE PARROT, THEN TYPE: SAY",$0d,"REUNION.",$0d,0
m52
        dc.b $11,"TALK TO THE CAPTAIN. WHAT WOULD MAKE",$0d,"HIM LOOK AWAY? SAY MONKEY."
        dc.b $0d,0
m53
        dc.b $11,"USE THE KEY ON THE TRACTOR BEAM",$0d,"GENERATOR IN THE ENGINE ROOM."
        dc.b $0d,0
m54
        dc.b $11,"RIDE THE CABLE BACK, CLIMB UP TO THE",$0d,"COCKPIT AND FLY AWAY."
        dc.b $0d,0
m55
        dc.b $11,"A HOLLOW VOICE SAYS: WRONG GAME. THIS",$0d,"ISN'T COLOSSAL CAVE."
        dc.b $0d,0
m56
        dc.b $11,"GOD MODE? NICE TRY. THIS IS A COMMODORE",$0d,"64, NOT A 486."
        dc.b $0d,0
m57
        dc.b $11,"THAT'S THE ANSWER TO LIFE, THE UNIVERSE",$0d,"AND EVERYTHING. BUT WHAT WAS THE"
        dc.b $0d,"QUESTION?",$0d,0
m58
        dc.b $11,"YOU WAVE YOUR HAND. THESE AREN'T THE",$0d,"COMMANDS YOU'RE LOOKING FOR."
        dc.b $0d,0
m59
        dc.b $11,"THERE IS NO LAMP HERE. THIS ISN'T ZORK,",$0d,"YOU KNOW. BUT WATCH OUT FOR GRUES"
        dc.b $0d,"ANYWAY.",$0d,0
m60
        dc.b $11,"TYPE COMMANDS LIKE TAKE KEY, OPEN DOOR,",$0d,"EXAMINE MAT, N S E W U D, L = LOOK,"
        dc.b $0d,"I = INVENTORY, TAKE ALL, DROP ALL,",$0d,"G = AGAIN, SCORE, MAP, SAVE, LOAD, QUIT"
        dc.b $0d,"F1 LOAD  F3 SAVE  F5 MUSIC  F7 QUIT",$0d,"THREE SAVE SLOTS: PRESS 1, 2 OR 3."
        dc.b $0d,"HINT GIVES A CLUE BUT COSTS 3 POINTS.",$0d,"FIND THE 16 HIDDEN STAR FRAGMENTS!"
        dc.b $0d,0
m61
        dc.b $11,"THE PIRATE GUARD DRAWS HIS LASER",$0d,"CUTLASS. 'EN GARDE! YOU FIGHT LIKE A"
        dc.b $0d,"DAIRY FARMER!'",$0d,0
m62
        dc.b $11,"LECHUCKLE LEAPS UP FROM HIS DESK. 'YE",$0d,"SWITCHED OFF MY BEAM! EN GARDE,"
        dc.b $0d,"LANDLUBBER: MY GRANDMOTHER FLIES BETTER",$0d,"THAN YOU!'",$0d
        dc.b 0
t_intro
        dc.b $11,"HALFWAY TO STRONKIE, A SHIP DROPS OUT",$0d,"OF HYPERSPACE RIGHT IN FRONT OF YOU: AN"
        dc.b $0d,"OLD SAILING SHIP WITH SOLAR SAILS AND A",$0d,"BLACK FLAG. A GREEN TRACTOR BEAM GRABS"
        dc.b $0d,"THE STARRAVEN. A VOICE BOOMS OVER THE",$0d,"RADIO: 'THIS IS CAPTAIN LECHUCKLE OF"
        dc.b $0d,"THE SPACE MONKEY! HAND OVER YER STAR",$0d,"CHART, OR WALK THE SPACE PLANK!'"
        dc.b $0d,$0d,0
t_title
        dc.b $17,$0d,"CHAPTER 4: SPACE PIRATES",$0d,$0d,0
t_short
        dc.b "CHAPTER 4",0
t_quip
        dc.b $17,"CAPTAIN LECHUCKLE ADDS YOU TO HIS",$0d,"COLLECTION OF GHOSTS. ARRR!"
        dc.b $0d,0
d1
        dc.b $1d,"YOU ARE IN THE COCKPIT OF THE",$0d,"STARRAVEN. THE PIRATE SHIP FILLS THE"
        dc.b $0d,"WINDOW, AND ITS GREEN TRACTOR BEAM",$0d,"HOLDS YOU TIGHT. ALARMS BLARE. A LADDER"
        dc.b $0d,"LEADS DOWN TO THE AIRLOCK.",$0d,0
d2
        dc.b $1d,"YOU ARE IN THE AIRLOCK. THROUGH THE",$0d,"WINDOW OF THE OUTER DOOR YOU SEE A"
        dc.b $0d,"THICK MOORING CABLE: THE PIRATES HAVE",$0d,"TIED THEIR SHIP TO YOURS!"
        dc.b $0d,0
d3
        dc.b $1d,"YOU ARE ON THE DECK OF THE SPACE",$0d,"MONKEY. SOLAR SAILS CREAK IN THE"
        dc.b $0d,"STARLIGHT AND A WANTED POSTER IS NAILED",$0d,"TO THE MAST. A DOOR LEADS NORTH, A"
        dc.b $0d,"HATCH EAST. THE CABLE RUNS BACK TO THE",$0d,"STARRAVEN.",$0d
        dc.b 0
d4
        dc.b $1d,"YOU ARE IN THE CAPTAIN'S CABIN. CAPTAIN",$0d,"LECHUCKLE, A GHOSTLY GREEN SPACE PIRATE"
        dc.b $0d,"WITH A BEARD FULL OF SPACE BUGS, COUNTS",$0d,"HIS BUCKAZOIDS AT A BIG DESK. A BIG KEY"
        dc.b $0d,"HANGS FROM HIS BELT. THERE IS A CAKE ON",$0d,"THE DESK.",$0d
        dc.b 0
d5
        dc.b $1d,"YOU ARE IN THE ENGINE ROOM OF THE SPACE",$0d,"MONKEY. THE TRACTOR BEAM GENERATOR HUMS"
        dc.b $0d,"AND GLOWS GREEN. IT HAS A BIG KEYHOLE.",$0d,"CRATES OF GROG ARE STACKED EVERYWHERE,"
        dc.b $0d,"AND A CREWMAN IN A RED SHIRT SITS IN",$0d,"THE CORNER.",$0d,0
t0
        dc.b 0
t1
        dc.b $11,"THE SPACE MONKEY: A WOODEN SAILING SHIP",$0d,"IN SPACE. NOBODY KNOWS HOW IT WORKS."
        dc.b $0d,"ITS GREEN TRACTOR BEAM HOLDS YOU FAST.",$0d,0
t2
        dc.b $11,"THE THROTTLE IS AT FULL POWER. THE BEAM",$0d,"DOESN'T CARE."
        dc.b $0d,0
t3
        dc.b $11,"THE OUTER DOOR OF THE AIRLOCK. YOUR",$0d,"SPACESUIT HELMET IS ON, SO IT'S SAFE TO"
        dc.b $0d,"OPEN IT HERE.",$0d,0
t4
        dc.b $11,"A THICK, GREASY MOORING CABLE",$0d,"STRETCHING ACROSS TO THE PIRATE SHIP."
        dc.b $0d,0
t5
        dc.b $11,"THE CABLE RUNS BACK TO THE STARRAVEN.",$0d,0
t6
        dc.b "A RUBBER CHICKEN WITH A PULLEY IN THE MIDDLE",0
t7
        dc.b $11,"A RUBBER CHICKEN WITH A PULLEY IN THE",$0d,"MIDDLE. THE PULLEY WOULD FIT ON A"
        dc.b $0d,"CABLE...",$0d,0
t8
        dc.b "A PIRATE GUARD",0
t9
        dc.b $11,"A SPACE PIRATE WITH AN EYE PATCH AND A",$0d,"LASER CUTLASS. HE LOOKS VERY PROUD OF"
        dc.b $0d,"HIS INSULTS.",$0d,0
t10
        dc.b $11,"A GREEN SPACE PARROT. IT KEEPS",$0d,"MUTTERING TO ITSELF.",$0d
        dc.b 0
t11
        dc.b $11,"WANTED: MARK STRONKS AKA STRONKIE.",$0d,"CRIME: WRITING ADVENTURE GAMES ON A"
        dc.b $0d,"COMMODORE 64 AND MAKING PIRATES READ",$0d,"ALL THIS TEXT. REWARD: 3 BUCKAZOIDS."
        dc.b $0d,0
t12
        dc.b $11,"A GHOST PIRATE, GREEN AND SEE-THROUGH,",$0d,"EXCEPT FOR HIS BELT. ON THE BELT HANGS"
        dc.b $0d,"A BIG KEY.",$0d,0
t13
        dc.b $11,"PILES OF STOLEN BUCKAZOIDS. LECHUCKLE",$0d,"COUNTS THEM AGAIN AND AGAIN."
        dc.b $0d,0
t14
        dc.b "A BIG BRASS KEY",0
t15
        dc.b $11,"A BIG BRASS KEY. A TAG SAYS: TRACTOR",$0d,"BEAM. DO NOT LOSE. AGAIN."
        dc.b $0d,0
t16
        dc.b $11,"THE TRACTOR BEAM GENERATOR. IT GLOWS",$0d,"GREEN AND HAS A BIG KEYHOLE."
        dc.b $0d,0
t17
        dc.b $11,"CRATES OF GROG. SOME OF THEM ARE",$0d,"SMOKING.",$0d,0
t18
        dc.b $11,"A YOUNG CREWMAN IN A RED SHIRT. HE",$0d,"LOOKS NERVOUS. HE HAS EVERY REASON TO"
        dc.b $0d,"BE.",$0d,0
t19
        dc.b $11,"A BIRTHDAY CAKE WITH A NOTE: THE CAKE",$0d,"IS A LIE. UNDER IT, IN SMALLER LETTERS:"
        dc.b $0d,"ALSO, IT IS 300 YEARS OLD.",$0d,0
t_save
        dc.b "SAVE1-PIRATES",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$53,$50,$41,$43,$45,$20,$50,$49,$52,$41,$54,$45,$53,$0d,$1f,$20,$01,$43,$4f,$43,$4b,$50,$49,$54,$0e,$20
        dc.b $20,$20,$20,$04,$43,$41,$42,$49,$4e,$0e,$0d,$1f,$20,$20,$20,$20,$62,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$02,$41
        dc.b $49,$52,$4c,$4f,$43,$4b,$0e,$60,$60,$60,$60,$60,$03,$44,$45,$43,$4b,$0e,$60,$60,$60,$60,$60,$05,$45,$4e,$47,$49,$4e,$45,$0e,$0d
        dc.b $00
        even
song
        dc.w 3                  ; voices
        dc.b $10,$08,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$0a,$86,$06     ; waveform, attack/decay, sustain/release, pulse
        dc.b $10,$6a,$8a,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $1b,$1c,$22,$1c,$1b,$1c,$22,$1c,$19,$1c,$20,$1c,$19,$1c,$20,$1c,$17,$1c,$1e,$1c,$17,$1c,$1e,$1c,$16,$1c,$1d,$1c,$16,$1c,$26,$1c
        dc.b $1b,$1c,$22,$1c,$1b,$1c,$22,$1c,$14,$1c,$1b,$1c,$14,$1c,$1b,$1c,$16,$1c,$1d,$1c,$16,$1c,$1d,$1c,$1b,$1c,$22,$1c,$27,$38,$ff
song_v2
        dc.b $33,$0e,$33,$0e,$36,$0e,$3a,$0e,$3a,$1c,$38,$0e,$36,$0e,$35,$0e,$38,$0e,$3d,$1c,$35,$0e,$38,$0e,$3d,$1c,$3f,$1c,$3d,$0e,$3b,$0e
        dc.b $3a,$1c,$36,$1c,$35,$1c,$3a,$1c,$3e,$1c,$3a,$1c,$3f,$0e,$3f,$0e,$3d,$0e,$3a,$0e,$36,$1c,$3a,$0e,$3f,$0e,$38,$0e,$3b,$0e,$3f,$1c
        dc.b $3b,$0e,$38,$0e,$3b,$1c,$3a,$0e,$3e,$0e,$41,$1c,$44,$0e,$42,$0e,$41,$1c,$3f,$38,$00,$38,$ff
song_v3
        dc.b $2e,$70,$2c,$70,$2a,$70,$29,$70,$2e,$70,$2c,$70,$29,$70,$2a,$70,$ff
        even
actors                               ; moving sprites per room
;       room, sprites, first image, images, image delay, move delay, dx, dy
;       x, y (C64 sprite coordinates), height in lines, colours 1-3
        dc.b 1,2,0,2,6,1,-1,0
        dc.w 304,61,8,$fa4,$fe8,$fff
        dc.b 0
        even
frames                               ; offsets of the sprite images
        dc.l fr0-base
        dc.l fr1-base
fr0                              ; "comet1": 2 sprite(s), 8 lines
        dc.w $0000,$0000,$0000,$0000,$0000,$001e,$001f,$07ff,$e7ff,$1fff,$001f,$07ff,$0000,$001e,$0000,$0000
        dc.w $0000,$0000,$0000,$0400,$0300,$8f00,$ef80,$ffc0,$ffe0,$fff0,$ef80,$ffc0,$0300,$8f00,$0000,$0400
fr1                              ; "comet2": 2 sprite(s), 8 lines
        dc.w $0000,$0000,$0000,$0004,$0000,$01ef,$003f,$1fff,$e3ff,$1fff,$003f,$1fff,$0000,$01ef,$0000,$0004
        dc.w $0000,$0000,$0000,$1000,$0600,$0e00,$ef80,$ff80,$fff0,$fff8,$ef80,$ff80,$0600,$0e00,$0000,$1000
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 10,0
        dc.l $01709c             ; NOVA: Engaging... nothing, pilot. i am not tha
        dc.w 12,0
        dc.l $01a0d6             ; NOVA: Main power crystal hit! we're going down
        dc.w 14,0
        dc.l $01c612             ; NOVA: The beam comes from their ship, pilot. s
        dc.w 15,0
        dc.l $01dd3c             ; NOVA: The beam is gone! fly, pilot, fly!
        dc.w 0
card                                 ; next part: kind, name, spoken title (in the blob)
        dc.l card_k-base,card_n-base
        dc.l $0200a2             ; "Chapter 5. Landfall"
card_k
        dc.b "CHAPTER 5",0
card_n
        dc.b "LANDFALL",0
        even
        even
part_end
