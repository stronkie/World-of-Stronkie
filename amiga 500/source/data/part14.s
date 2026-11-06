;======================================================================
;  THE WORLD OF STRONKIE V2.0 (Amiga) - CHAPTER 11: VEX'S FLAGSHIP
;  Created By Mark Stronks
;
;  Part file "PART14": vasm -Fbin -o part14.bin part14.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_FHANGAR     = $000000      ; picture "fhangar" in the blob
PIC_FCORR       = $0048f0      ; picture "fcorr" in the blob
PIC_BREAKROOM   = $009ac8      ; picture "breakroom" in the blob
PIC_LOCKERS     = $00e3d0      ; picture "lockers" in the blob
PIC_HOLODECK    = $0124f4      ; picture "holodeck" in the blob
PIC_LIFT        = $015010      ; picture "lift" in the blob

base
        dc.b "CHAP"
        dc.b 14,1,6,15       ; part, start room, rooms, objects
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
        dc.b 11,0
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_FHANGAR
        dc.b 0,0,2,0,0,0,0,0      ; hangar
        dc.l d2-base,PIC_FCORR
        dc.b 3,4,0,1,0,0,0,0      ; corridor
        dc.l d3-base,PIC_BREAKROOM
        dc.b 0,2,0,0,0,0,0,0      ; breakroom
        dc.l d4-base,PIC_LOCKERS
        dc.b 2,0,0,0,0,0,0,0      ; laundry
        dc.l d5-base,PIC_HOLODECK
        dc.b 0,1,0,0,0,0,0,0      ; holodeck
        dc.l d6-base,PIC_LIFT
        dc.b 0,0,0,2,0,0,0,0      ; lift
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,1,2,0
        dc.l t0-base,t1-base
        dc.b 2,1,2,0
        dc.l t0-base,t2-base
        dc.b 3,2,2,0
        dc.l t0-base,t3-base
        dc.b 3,3,2,0
        dc.l t0-base,t4-base
        dc.b 4,3,2,0
        dc.l t0-base,t5-base
        dc.b 5,3,2,0
        dc.l t0-base,t6-base
        dc.b 6,0,1,0
        dc.l t7-base,t8-base
        dc.b 7,4,2,0
        dc.l t0-base,t9-base
        dc.b 8,4,1,0
        dc.l t10-base,t11-base
        dc.b 9,4,2,0
        dc.l t0-base,t12-base
        dc.b 10,5,2,0
        dc.l t0-base,t13-base
        dc.b 7,6,0,0
        dc.l t14-base,t15-base
        dc.b 7,0,2,0
        dc.l t0-base,t16-base
        dc.b 11,0,1,0
        dc.l t17-base,t18-base
        dc.b 12,0,1,0
        dc.l t19-base,t20-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "SHUT",1
        dc.b "STAR",1
        dc.b "SHIP",1
        dc.b "DOOR",2
        dc.b "HOLL",2
        dc.b "GUAR",3
        dc.b "CHEC",3
        dc.b "TABL",3
        dc.b "ARCA",4
        dc.b "ASTR",4
        dc.b "GAME",4
        dc.b "POST",5
        dc.b "WALL",5
        dc.b "BADG",6
        dc.b "ROBO",7
        dc.b "LAUN",7
        dc.b "BOT ",7
        dc.b "UNIF",8
        dc.b "PILE",9
        dc.b "SOCK",9
        dc.b "DIRT",9
        dc.b "SAND",10
        dc.b "BEAC",10
        dc.b "PALM",10
        dc.b "GROG",10
        dc.b "INSU",7
        dc.b "TRON",7
        dc.b "GLAS",11
        dc.b "NOSE",11
        dc.b "DISG",11
        dc.b "MONK",12
        dc.b "MIRR",13
        dc.b "LOOK",13
        dc.b "DATA",14
        dc.b "TAPE",14
        dc.b "JOKE",14
        dc.b "USEF",15
        dc.b "RECY",15
        dc.b "SO  ",16
        dc.b "LAMP",17
        dc.b "FORC",18
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $3d,$10,$06,$20,$01,$00
        dc.b $0c,$09,$0d,$04,$04,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $1c,$09,$0d,$04,$04,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $08,$09,$0d,$04,$04,$06,$00,$20,$02,$21,$00,$2c,$00
        dc.b $02,$00,$16,$04,$01,$05,$3c,$06,$01,$20,$03,$21,$01,$25,$01,$00,$05,$24,$05,$2b,$06,$00
        dc.b $02,$00,$0a,$04,$01,$06,$3c,$20,$04,$00
        dc.b $0d,$02,$16,$04,$01,$05,$3c,$06,$01,$20,$03,$21,$01,$25,$01,$00,$05,$24,$05,$2b,$06,$00
        dc.b $0a,$0c,$16,$04,$01,$02,$0f,$06,$01,$20,$03,$21,$01,$25,$01,$00,$05,$24,$05,$2b,$06,$00
        dc.b $1c,$0a,$11,$04,$05,$06,$02,$20,$05,$21,$02,$26,$0a,$2e,$d8,$75,$00
        dc.b $16,$00,$11,$04,$05,$06,$02,$20,$05,$21,$02,$26,$0a,$2e,$d8,$75,$00
        dc.b $1f,$0a,$08,$04,$05,$20,$06,$00
        dc.b $04,$00,$0a,$04,$02,$06,$03,$20,$07,$00
        dc.b $2b,$0b,$16,$04,$02,$02,$0e,$06,$03,$20,$08,$21,$03,$25,$02,$02,$06,$26,$0a,$2b,$06,$00
        dc.b $40,$06,$18,$04,$02,$02,$07,$05,$04,$06,$03,$20,$09,$21,$03,$25,$02,$02,$06,$26,$0a,$2b,$06,$00
        dc.b $1a,$06,$18,$04,$02,$02,$07,$05,$04,$06,$03,$20,$09,$21,$03,$25,$02,$02,$06,$26,$0a,$2b,$06,$00
        dc.b $40,$06,$0c,$04,$02,$02,$07,$06,$03,$20,$0a,$00
        dc.b $2b,$08,$0e,$02,$09,$06,$04,$20,$0b,$21,$04,$26,$05,$00
        dc.b $09,$08,$0d,$04,$04,$03,$09,$20,$0c,$23,$09,$ff,$00
        dc.b $0f,$12,$08,$04,$02,$20,$0d,$00
        dc.b $1d,$03,$0b,$04,$02,$20,$0e,$2d,$06,$29,$00
        dc.b $20,$03,$15,$04,$03,$05,$39,$06,$05,$20,$0f,$23,$07,$ff,$21,$05,$26,$0a,$2b,$02,$00
        dc.b $20,$00,$0a,$04,$03,$06,$05,$20,$10,$00
        dc.b $2e,$04,$13,$04,$03,$06,$05,$20,$11,$23,$07,$ff,$21,$05,$26,$0a,$2b,$04,$00
        dc.b $09,$06,$0a,$04,$03,$06,$05,$20,$12,$00
        dc.b $30,$04,$08,$04,$03,$20,$13,$00
        dc.b $10,$05,$08,$04,$03,$20,$14,$00
        dc.b $20,$07,$08,$04,$04,$20,$15,$00
        dc.b $20,$00,$08,$04,$04,$20,$15,$00
        dc.b $2c,$0d,$10,$04,$06,$06,$06,$20,$16,$21,$06,$26,$0a,$2b,$08,$00
        dc.b $2c,$0e,$12,$04,$06,$05,$06,$06,$07,$20,$17,$21,$07,$26,$0a,$2b,$08,$00
        dc.b $2c,$0f,$1a,$04,$06,$05,$07,$06,$08,$20,$18,$21,$08,$23,$0c,$00,$23,$0d,$06,$26,$0a,$2b,$05,$2d,$04,$00
        dc.b $2c,$00,$0c,$04,$06,$06,$08,$20,$19,$2b,$04,$00
        dc.b $20,$00,$0a,$04,$06,$06,$06,$20,$1a,$00
        dc.b $20,$00,$0a,$04,$06,$06,$07,$20,$1b,$00
        dc.b $20,$00,$0a,$04,$06,$06,$08,$20,$1c,$00
        dc.b $1d,$07,$0a,$04,$06,$06,$08,$20,$1d,$00
        dc.b $07,$00,$0a,$04,$06,$06,$08,$20,$1e,$00
        dc.b $07,$00,$0e,$04,$06,$20,$1f,$26,$0a,$2b,$09,$27,$0f,$00
        dc.b $01,$00,$10,$04,$06,$05,$08,$20,$1f,$26,$0a,$2b,$09,$27,$0f,$00
        dc.b $14,$00,$10,$04,$06,$05,$08,$20,$1f,$26,$0a,$2b,$09,$27,$0f,$00
        dc.b $37,$00,$0c,$06,$03,$03,$0e,$06,$04,$20,$20,$00
        dc.b $37,$00,$0c,$06,$03,$03,$0e,$06,$05,$20,$21,$00
        dc.b $37,$00,$0a,$06,$03,$02,$0e,$20,$22,$00
        dc.b $37,$00,$08,$06,$03,$20,$23,$00
        dc.b $37,$00,$08,$06,$06,$20,$24,$00
        dc.b $37,$00,$08,$06,$07,$20,$25,$00
        dc.b $37,$00,$08,$06,$08,$20,$26,$00
        dc.b $37,$00,$06,$20,$27,$00
        dc.b $45,$00,$06,$20,$28,$00
        dc.b $46,$00,$06,$20,$29,$00
        dc.b $47,$00,$06,$20,$2a,$00
        dc.b $0f,$12,$06,$20,$2b,$00
        dc.b $09,$11,$06,$20,$2c,$00
        dc.b $22,$00,$06,$20,$2d,$00
        dc.b $00,$00,$0d,$05,$3d,$06,$09,$23,$0e,$ff,$21,$09,$00
        dc.b $00,$00,$0d,$05,$3c,$06,$0a,$23,$0f,$ff,$21,$0a,$00
        dc.b $00,$00,$0e,$04,$06,$06,$0b,$20,$2e,$21,$0b,$2b,$08,$00
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
m1
        dc.b $11,"'MAKE IT SO!' YOU ORDER, IN YOUR BEST",$0d,"STARSHIP CAPTAIN VOICE. NOVA:"
        dc.b $0d,"'ENGAGING... NOTHING, PILOT. I AM NOT",$0d,"THAT KIND OF STARSHIP.' YOU SHALL BE"
        dc.b $0d,"MISSED, SIR PATRICK STEWART - OUR",$0d,"CAPTAIN JEAN-LUC PICARD OF STAR TREK."
        dc.b $0d,"1940-2026.",$0d,0
m2
        dc.b $11,"UNDER A SMELLY SOCK SOMETHING",$0d,"GLITTERS... A TINY PIECE OF STARLIGHT!"
        dc.b $0d,0
m3
        dc.b $11,"YOUR WOODEN MONKEY WRIGGLES IN YOUR",$0d,"POCKET... AND FITS PERFECTLY INTO THE"
        dc.b $0d,"HOLLOW. THE DOOR SLIDES OPEN!",$0d,0
m4
        dc.b $11,"THE DOOR WITH THE MONKEY-SHAPED HOLLOW",$0d,"WILL NOT OPEN. WHAT COULD FIT IN THERE?"
        dc.b $0d,0
m5
        dc.b $11,"YOU DIG IN THE WARM SAND AND FIND A",$0d,"TREASURE CHEST! INSIDE: A T-SHIRT. IT"
        dc.b $0d,"SAYS: I FOUND THE SECRET ROOM AND ALL I",$0d,"GOT WAS THIS LOUSY T-SHIRT. SOMEWHERE A"
        dc.b $0d,"JAUNTY TUNE STARTS TO PLAY...",$0d,0
m6
        dc.b $11,"IT'S HOLO-GROG. IT TASTES OF NOTHING AT",$0d,"ALL. MUCH SAFER."
        dc.b $0d,0
m7
        dc.b $11,"THE GUARD STEPS IN FRONT OF YOU. 'HALT!",$0d,"UNIFORM AND BADGE, OR YOU DON'T GET"
        dc.b $0d,"PAST.'",$0d,0
m8
        dc.b $11,"THE GUARD SALUTES. 'OH! DOCTOR NOSE",$0d,"FROM ACCOUNTING! GO RIGHT IN, SIR!' THE"
        dc.b $0d,"GROUCHO GLASSES WORK AGAIN.",$0d,0
m9
        dc.b $11,"THE GUARD LOOKS AT YOUR BADGE AND YOUR",$0d,"UNIFORM, WHICH IS THREE SIZES TOO BIG."
        dc.b $0d,"'HUH. NEW RECRUIT? GO ON THROUGH.'",$0d,0
m10
        dc.b $11,"'NICE BADGE. AND WHERE IS YOUR UNIFORM,",$0d,"RECRUIT?'",$0d
        dc.b 0
m11
        dc.b $11,"YOU PULL THE UNIFORM ON OVER YOUR",$0d,"CLOTHES. IT IS THREE SIZES TOO BIG. YOU"
        dc.b $0d,"LOOK LIKE A TENT. A BLACK, MILITARY",$0d,"TENT.",$0d,0
m12
        dc.b $11,"THE LAUNDRY ROBOT DOESN'T EVEN NOTICE.",$0d,"TAKEN.",$0d,0
m13
        dc.b $11,"YOU WAVE YOUR HAND: 'YOU DON'T NEED TO",$0d,"SEE MY BADGE.' THE GUARD: 'NICE TRY."
        dc.b $0d,"THAT ONLY WORKS ON STORMTROOPERS, PAL.'",$0d,0
m14
        dc.b $11,"THE GUARD IS FASTER. MUCH FASTER.",$0d,0
m15
        dc.b $11,"'WAIT... ARE YOU THE ONE WHO BEAT",$0d,"STRONKIE'S HIGH SCORE ON ASTRO"
        dc.b $0d,"CHICKEN?' THE GUARDS GO WILD AND RUN",$0d,"OFF TO FIND A PEN FOR AN AUTOGRAPH. YOU"
        dc.b $0d,"POCKET THE BADGE.",$0d,0
m16
        dc.b $11,"'GO AWAY, WE'RE TRYING TO BEAT",$0d,"STRONKIE'S HIGH SCORE!' THE GUARDS"
        dc.b $0d,"DON'T EVEN LOOK UP.",$0d,0
m17
        dc.b $11,"YOU KICK THEIR ASTRO CHICKEN MACHINE.",$0d,"IT GOES HAYWIRE: THE CHICKEN SQUAWKS AT"
        dc.b $0d,"FULL VOLUME! WHILE THE GUARDS TRY TO",$0d,"SHUT IT UP, YOU POCKET THE BADGE."
        dc.b $0d,0
m18
        dc.b $11,"A GUARD SLAPS YOUR HAND WITHOUT LOOKING",$0d,"UP FROM THE GAME. 'HANDS OFF.'"
        dc.b $0d,0
m19
        dc.b $11,"'WAIT YOUR TURN!' THE GUARDS SNAP.",$0d,0
m20
        dc.b $11,"INSULT OF THE WEEK: IF A ROBOT BRAGS",$0d,"ABOUT ITS FAST CIRCUITS, TELL IT: BUT"
        dc.b $0d,"YOUR JOKES STILL LOAD FROM A DATASETTE!",$0d,0
m21
        dc.b $11,"'THAT INSULT-O-TRON BY THE LIFT,' THE",$0d,"LAUNDRY ROBOT GRUMBLES, 'ALWAYS"
        dc.b $0d,"THREATENING TO RECYCLE EVERYBODY. I",$0d,"ALWAYS SAY: AT LEAST I'D BE USEFUL"
        dc.b $0d,"THEN, UNLIKE YOU!'",$0d,0
m22
        dc.b $11,"'THEN YOU MUST HAVE BEEN LOOKING IN A",$0d,"MIRROR,' YOU REPLY. THE ROBOT'S LIGHTS"
        dc.b $0d,"FLICKER. 'ERROR... RECALCULATING. MY",$0d,"CIRCUITS ARE FASTER THAN YOUR FEET!'"
        dc.b $0d,0
m23
        dc.b $11,"'MAYBE, BUT YOUR JOKES STILL LOAD FROM",$0d,"A DATASETTE,' YOU SAY. THE INSULT-O-"
        dc.b $0d,"TRON SMOKES A LITTLE. 'WHEN I AM DONE",$0d,"WITH YOU, YOU WILL BE RECYCLED!'"
        dc.b $0d,0
m24
        dc.b $11,"'AT LEAST I'D BE USEFUL THEN, UNLIKE",$0d,"YOU,' YOU SAY. THE INSULT-O-TRON 3000"
        dc.b $0d,"SHUDDERS, SPARKS AND SHUTS DOWN WITH A",$0d,"SAD LITTLE BEEP. THE LIFT TO THE PRISON"
        dc.b $0d,"DECK IS FREE!",$0d,0
m25
        dc.b $11,"'HA! PATHETIC!' THE INSULT-O-TRON ZAPS",$0d,"YOUR TOES. THAT WAS NOT THE RIGHT"
        dc.b $0d,"ANSWER.",$0d,0
m26
        dc.b $11,"'I HAVE SEEN ASTEROIDS WITH MORE BRAINS",$0d,"THAN YOU!'",$0d
        dc.b 0
m27
        dc.b $11,"'MY CIRCUITS ARE FASTER THAN YOUR",$0d,"FEET!'",$0d,0
m28
        dc.b $11,"'WHEN I AM DONE WITH YOU, YOU WILL BE",$0d,"RECYCLED!'",$0d,0
m29
        dc.b $11,"YOU HAVE NO SWORD. THE INSULT-O-TRON",$0d,"ONLY FIGHTS WITH WORDS. ANSWER IT!"
        dc.b $0d,0
m30
        dc.b $11,"THE INSULT-O-TRON BLOCKS THE LIFT.",$0d,0
m31
        dc.b $11,"THE LIFT DROPS DOWN AND DOWN, DEEP INTO",$0d,"THE IRON RAVEN..."
        dc.b $0d,0
m32
        dc.b $11,"THE CHECKPOINT GUARD WANTS A UNIFORM",$0d,"AND A BADGE. TRY THE LAUNDRY."
        dc.b $0d,0
m33
        dc.b $11,"THE GUARDS IN THE BREAK ROOM ARE TOO",$0d,"BUSY WITH ASTRO CHICKEN. MAYBE THE"
        dc.b $0d,"MACHINE NEEDS A KICK.",$0d,0
m34
        dc.b $11,"WEAR YOUR GROUCHO GLASSES AT THE",$0d,"CHECKPOINT.",$0d,0
m35
        dc.b $11,"WEAR THE UNIFORM AND SHOW THE BADGE TO",$0d,"THE GUARD AT THE CHECKPOINT."
        dc.b $0d,0
m36
        dc.b $11,"ANSWER THE INSULT-O-TRON WITH PIP'S",$0d,"SAYING: SAY MIRROR."
        dc.b $0d,0
m37
        dc.b $11,"READ THE POSTER IN THE BREAK ROOM. THEN",$0d,"SAY DATASETTE."
        dc.b $0d,0
m38
        dc.b $11,"TALK TO THE LAUNDRY ROBOT. THEN SAY",$0d,"USEFUL.",$0d,0
m39
        dc.b $11,"GO DOWN WITH THE LIFT.",$0d,0
m40
        dc.b $11,"A HOLLOW VOICE SAYS: WRONG GAME. THIS",$0d,"ISN'T COLOSSAL CAVE."
        dc.b $0d,0
m41
        dc.b $11,"GOD MODE? NICE TRY. THIS IS A COMMODORE",$0d,"64, NOT A 486."
        dc.b $0d,0
m42
        dc.b $11,"THAT'S THE ANSWER TO LIFE, THE UNIVERSE",$0d,"AND EVERYTHING. BUT WHAT WAS THE"
        dc.b $0d,"QUESTION?",$0d,0
m43
        dc.b $11,"YOU WAVE YOUR HAND. THESE AREN'T THE",$0d,"COMMANDS YOU'RE LOOKING FOR."
        dc.b $0d,0
m44
        dc.b $11,"THERE IS NO LAMP HERE. THIS ISN'T ZORK,",$0d,"YOU KNOW. BUT WATCH OUT FOR GRUES"
        dc.b $0d,"ANYWAY.",$0d,0
m45
        dc.b $11,"TYPE COMMANDS LIKE TAKE KEY, OPEN DOOR,",$0d,"EXAMINE MAT, N S E W U D, L = LOOK,"
        dc.b $0d,"I = INVENTORY, TAKE ALL, DROP ALL,",$0d,"G = AGAIN, SCORE, MAP, SAVE, LOAD, QUIT"
        dc.b $0d,"F1 LOAD  F3 SAVE  F5 MUSIC  F7 QUIT",$0d,"THREE SAVE SLOTS: PRESS 1, 2 OR 3."
        dc.b $0d,"HINT GIVES A CLUE BUT COSTS 3 POINTS.",$0d,"FIND THE 16 HIDDEN STAR FRAGMENTS!"
        dc.b $0d,0
m46
        dc.b $11,"A ROBOT ROLLS IN FRONT OF THE LIFT. 'I",$0d,"AM THE INSULT-O-TRON 3000! EN GARDE,"
        dc.b $0d,"HUMAN: I HAVE SEEN ASTEROIDS WITH MORE",$0d,"BRAINS THAN YOU!'"
        dc.b $0d,0
t_intro
        dc.b $11,"THE STARRAVEN SLIPS INTO THE HANGAR OF",$0d,"VEX'S FLAGSHIP, THE IRON RAVEN, RIGHT"
        dc.b $0d,"BEHIND A CARGO SHUTTLE. NOVA: 'WE'RE",$0d,"IN, PILOT. UNCLE EDMUND MUST BE ON THE"
        dc.b $0d,"PRISON DECK. THE ONLY WAY DOWN IS THE",$0d,"LIFT... AND THERE ARE GUARDS"
        dc.b $0d,"EVERYWHERE.'",$0d,$0d,0
t_title
        dc.b $17,$0d,"CHAPTER 11: VEX'S FLAGSHIP",$0d,$0d,0
t_short
        dc.b "CHAPTER 11",0
t_quip
        dc.b $17,"THE IRON RAVEN ADDS ANOTHER STOWAWAY TO",$0d,"ITS LONG LIST."
        dc.b $0d,0
d1
        dc.b $1d,"YOU ARE IN THE HANGAR OF THE IRON",$0d,"RAVEN. BLACK SHUTTLES STAND IN ROWS."
        dc.b $0d,"THE STARRAVEN HIDES BEHIND A CARGO",$0d,"CRATE. IN THE NORTH WALL IS A DOOR WITH"
        dc.b $0d,"A STRANGE MONKEY-SHAPED HOLLOW. A",$0d,"CORRIDOR LEADS EAST."
        dc.b $0d,0
d2
        dc.b $1d,"YOU ARE IN A LONG BLACK CORRIDOR. A",$0d,"GUARD STANDS AT A CHECKPOINT TO THE"
        dc.b $0d,"EAST, IN FRONT OF THE LIFT. DOORS LEAD",$0d,"NORTH AND SOUTH."
        dc.b $0d,0
d3
        dc.b $1d,"YOU ARE IN THE GUARDS' BREAK ROOM. TWO",$0d,"GUARDS ARE PLAYING ASTRO CHICKEN. A"
        dc.b $0d,"BADGE LIES ON THE TABLE. A POSTER HANGS",$0d,"ON THE WALL."
        dc.b $0d,0
d4
        dc.b $1d,"YOU ARE IN THE LAUNDRY. A ROBOT FOLDS",$0d,"UNIFORMS AND MUTTERS TO ITSELF. A BIG"
        dc.b $0d,"PILE OF DIRTY LAUNDRY FILLS THE CORNER.",$0d,0
d5
        dc.b $1d,"A SECRET HOLODECK! WARM SAND, PALM",$0d,"TREES AND A GROG STAND. A SIGN SAYS:"
        dc.b $0d,"WELCOME TO MONKEY ISLAND. SOMEBODY HAS",$0d,"CROSSED THAT OUT AND WRITTEN: STRONKIE"
        dc.b $0d,"BEACH.",$0d,0
d6
        dc.b $1d,"YOU STAND BEFORE THE LIFT TO THE PRISON",$0d,"DECK.",$0d,0
t0
        dc.b 0
t1
        dc.b $11,"ROWS OF BLACK SHUTTLES WITH A RAVEN ON",$0d,"EVERY TAIL.",$0d
        dc.b 0
t2
        dc.b $11,"A STEEL DOOR. IN THE MIDDLE IS A HOLLOW",$0d,"SHAPED LIKE A SMALL MONKEY."
        dc.b $0d,0
t3
        dc.b $11,"A BIG GUARD WITH A BIG GUN. 'UNIFORM",$0d,"AND BADGE, OR YOU DON'T GET PAST,' HE"
        dc.b $0d,"GRUNTS.",$0d,0
t4
        dc.b $11,"TWO GUARDS, GLUED TO THEIR ASTRO",$0d,"CHICKEN GAME. ONE OF THEM HAS LEFT HIS"
        dc.b $0d,"BADGE ON THE TABLE.",$0d,0
t5
        dc.b $11,"AN ASTRO CHICKEN MACHINE. THE HIGH",$0d,"SCORE TABLE STILL SHOWS STRONKIE AT THE"
        dc.b $0d,"TOP.",$0d,0
t6
        dc.b $11,"INSULT OF THE WEEK: IF A ROBOT BRAGS",$0d,"ABOUT ITS FAST CIRCUITS, TELL IT: BUT"
        dc.b $0d,"YOUR JOKES STILL LOAD FROM A DATASETTE!",$0d,0
t7
        dc.b "A GUARD'S BADGE",0
t8
        dc.b $11,"A BADGE WITH A RAVEN ON IT. THE PHOTO",$0d,"COULD BE ANYBODY."
        dc.b $0d,0
t9
        dc.b $11,"A LAUNDRY ROBOT. IT FOLDS UNIFORMS AND",$0d,"GRUMBLES ABOUT THE INSULT-O-TRON."
        dc.b $0d,0
t10
        dc.b "A BLACK UNIFORM",0
t11
        dc.b $11,"A BLACK UNIFORM OF VEX'S ARMY. THREE",$0d,"SIZES TOO BIG.",$0d
        dc.b 0
t12
        dc.b $11,"DIRTY UNIFORMS AND SMELLY SOCKS.",$0d,0
t13
        dc.b $11,"WARM, SOFT SAND. SOMETHING SEEMS TO BE",$0d,"BURIED HERE.",$0d
        dc.b 0
t14
        dc.b "THE INSULT-O-TRON 3000",0
t15
        dc.b $11,"A BATTLE ROBOT WITH A LOUDSPEAKER",$0d,"INSTEAD OF A GUN. IT GUARDS THE LIFT."
        dc.b $0d,0
t16
        dc.b $11,"THE INSULT-O-TRON, SMOKING QUIETLY. IT",$0d,"HAS NO MORE COMEBACKS."
        dc.b $0d,0
t17
        dc.b "A PAIR OF GROUCHO NOSE GLASSES",0
t18
        dc.b $11,"YOUR TRUSTY GROUCHO NOSE GLASSES.",$0d,0
t19
        dc.b "A WOODEN MONKEY",0
t20
        dc.b $11,"YOUR WOODEN MONKEY. IT GRINS, AS IF IT",$0d,"KNOWS SOMETHING."
        dc.b $0d,0
t_save
        dc.b "SAVE1-FLAGSHIP",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$56,$45,$58,$27,$53,$20,$46,$4c,$41,$47,$53,$48,$49,$50,$0d,$1f,$20,$85,$48,$4f,$4c,$4f,$44,$45,$43,$4b
        dc.b $0e,$20,$20,$03,$42,$52,$45,$41,$4b,$20,$52,$4d,$0e,$0d,$1f,$20,$20,$20,$20,$85,$62,$0e,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62
        dc.b $0d,$1f,$20,$20,$01,$48,$41,$4e,$47,$41,$52,$0e,$60,$60,$60,$02,$43,$4f,$52,$52,$49,$44,$4f,$52,$0e,$60,$60,$60,$60,$06,$4c,$49
        dc.b $46,$54,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$04,$4c,$41,$55,$4e,$44,$52,$59,$0e,$0d,$00
        even
song
        dc.w 3                  ; voices
        dc.b $20,$06,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$09,$96,$06     ; waveform, attack/decay, sustain/release, pulse
        dc.b $80,$00,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l song_v1-base
        dc.l song_v2-base
        dc.l song_v3-base
song_v1
        dc.b $19,$0c,$19,$0c,$25,$0c,$19,$0c,$19,$0c,$19,$0c,$25,$0c,$19,$0c,$19,$0c,$19,$0c,$25,$0c,$19,$0c,$19,$0c,$19,$0c,$25,$0c,$19,$0c
        dc.b $21,$0c,$21,$0c,$2d,$0c,$21,$0c,$21,$0c,$21,$0c,$2d,$0c,$21,$0c,$21,$0c,$21,$0c,$2d,$0c,$21,$0c,$21,$0c,$21,$0c,$2d,$0c,$21,$0c
        dc.b $1e,$0c,$1e,$0c,$2a,$0c,$1e,$0c,$1e,$0c,$1e,$0c,$2a,$0c,$1e,$0c,$1e,$0c,$1e,$0c,$2a,$0c,$1e,$0c,$1e,$0c,$1e,$0c,$2a,$0c,$1e,$0c
        dc.b $20,$0c,$20,$0c,$2c,$0c,$20,$0c,$20,$0c,$20,$0c,$2c,$0c,$20,$0c,$20,$0c,$20,$0c,$2c,$0c,$20,$0c,$20,$0c,$20,$0c,$2c,$0c,$20,$0c
        dc.b $ff
song_v2
        dc.b $3d,$18,$3d,$0c,$3d,$0c,$40,$18,$3f,$18,$3d,$30,$38,$30,$39,$18,$39,$0c,$39,$0c,$3d,$18,$3b,$18,$39,$30,$34,$30,$36,$18,$36,$0c
        dc.b $38,$0c,$39,$18,$3d,$18,$3f,$30,$3c,$30,$38,$18,$3c,$18,$3f,$18,$42,$18,$40,$30,$3f,$30,$ff
song_v3
        dc.b $55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c
        dc.b $00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c
        dc.b $55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06
        dc.b $55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06
        dc.b $00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c
        dc.b $ff
        even
tune
        dc.w 3                  ; voices
        dc.b $20,$06,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.b $40,$09,$96,$06     ; waveform, attack/decay, sustain/release, pulse
        dc.b $80,$00,$00,$00     ; waveform, attack/decay, sustain/release, pulse
        dc.l tune_v1-base
        dc.l tune_v2-base
        dc.l tune_v3-base
tune_v1
        dc.b $38,$05,$3d,$05,$41,$0a,$44,$05,$41,$05,$00,$05,$3d,$05,$3f,$0a,$42,$05,$3f,$05,$3c,$0a,$3d,$05,$00,$05,$41,$0a,$3d,$05,$38,$05
        dc.b $3a,$0a,$3c,$05,$3d,$05,$41,$0a,$3f,$0a,$3d,$14,$fe,$19,$0c,$19,$0c,$25,$0c,$19,$0c,$19,$0c,$19,$0c,$25,$0c,$19,$0c,$19,$0c,$19
        dc.b $0c,$25,$0c,$19,$0c,$19,$0c,$19,$0c,$25,$0c,$19,$0c,$21,$0c,$21,$0c,$2d,$0c,$21,$0c,$21,$0c,$21,$0c,$2d,$0c,$21,$0c,$21,$0c,$21
        dc.b $0c,$2d,$0c,$21,$0c,$21,$0c,$21,$0c,$2d,$0c,$21,$0c,$1e,$0c,$1e,$0c,$2a,$0c,$1e,$0c,$1e,$0c,$1e,$0c,$2a,$0c,$1e,$0c,$1e,$0c,$1e
        dc.b $0c,$2a,$0c,$1e,$0c,$1e,$0c,$1e,$0c,$2a,$0c,$1e,$0c,$20,$0c,$20,$0c,$2c,$0c,$20,$0c,$20,$0c,$20,$0c,$2c,$0c,$20,$0c,$20,$0c,$20
        dc.b $0c,$2c,$0c,$20,$0c,$20,$0c,$20,$0c,$2c,$0c,$20,$0c,$ff
tune_v2
        dc.b $25,$0f,$2c,$05,$25,$0a,$2c,$0a,$20,$0f,$27,$05,$20,$0a,$24,$0a,$25,$0f,$2c,$05,$29,$0a,$2c,$0a,$25,$28,$fe,$3d,$18,$3d,$0c,$3d
        dc.b $0c,$40,$18,$3f,$18,$3d,$30,$38,$30,$39,$18,$39,$0c,$39,$0c,$3d,$18,$3b,$18,$39,$30,$34,$30,$36,$18,$36,$0c,$38,$0c,$39,$18,$3d
        dc.b $18,$3f,$30,$3c,$30,$38,$18,$3c,$18,$3f,$18,$42,$18,$40,$30,$3f,$30,$ff
tune_v3
        dc.b $55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05
        dc.b $55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05,$55,$05,$00,$05
        dc.b $fe,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55
        dc.b $0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00
        dc.b $0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55
        dc.b $06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55
        dc.b $06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00,$0c,$55,$0c,$00,$0c,$55,$06,$55,$06,$00
        dc.b $0c,$ff
        even
actors                               ; moving sprites per room
;       room, sprites, first image, images, image delay, move delay, dx, dy
;       x, y (C64 sprite coordinates), height in lines, colours 1-3
        dc.b 5,1,0,2,6,2,1,1
        dc.w 44,61,7,$112,$335,$fd6
        dc.b 5,1,2,2,7,3,1,-1
        dc.w 204,71,7,$112,$335,$fd6
        dc.b 0
        even
frames                               ; offsets of the sprite images
        dc.l fr0-base
        dc.l fr1-base
        dc.l fr2-base
        dc.l fr3-base
fr0                              ; "bird1": 1 sprite(s), 7 lines
        dc.w $c006,$0000,$600c,$0000,$3838,$0000,$1e78,$0080,$06f8,$0118,$01c0,$0000,$0000,$0000
fr1                              ; "bird2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$0000,$0000,$0600,$0080,$7ef0,$0110,$fffc,$000c,$01c0,$0000,$0000,$0000
fr2                              ; "bird1": 1 sprite(s), 7 lines
        dc.w $c006,$0000,$600c,$0000,$3838,$0000,$1e78,$0080,$06f8,$0118,$01c0,$0000,$0000,$0000
fr3                              ; "bird2": 1 sprite(s), 7 lines
        dc.w $0000,$0000,$0000,$0000,$0600,$0080,$7ef0,$0110,$fffc,$000c,$01c0,$0000,$0000,$0000
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 1,0
        dc.l $018d4a             ; NOVA: Engaging... nothing, pilot. i am not tha
        dc.w 0
card                                 ; next part: kind, name, spoken title (in the blob)
        dc.l card_k-base,card_n-base
        dc.l $01bd84             ; "Chapter 12. The Prison Deck"
card_k
        dc.b "CHAPTER 12",0
card_n
        dc.b "THE PRISON DECK",0
        even
        even
part_end
