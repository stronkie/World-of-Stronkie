;======================================================================
;  THE WORLD OF STRONKIE V2.2 (Amiga) - PROLOGUE, PART 2: THE MANOR
;  Created By Mark Stronks
;
;  Part file "PART02": vasm -Fbin -o part02.bin part02.s
;  On the disk it is packed (zxpack); the engine unpacks it into its part buffer.
;  All pointers are offsets from the start of the file.
;======================================================================
PIC_HALL        = $000000      ; picture "hall" in the blob
PIC_LIBRARY     = $00566c      ; picture "library" in the blob
PIC_KITCHEN     = $00a448      ; picture "kitchen" in the blob
PIC_CELLAR      = $00f93c      ; picture "cellar" in the blob
PIC_STUDY       = $015798      ; picture "study" in the blob
PIC_SECRET      = $01a494      ; picture "secret" in the blob

base
        dc.b "CHAP"
        dc.b 2,1,6,22       ; part, start room, rooms, objects
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
        dc.b 8,9
        dc.w 0
        dc.l speech-base                ; speech: message number -> sample (picture blob)
rooms                                ; description, picture, exits N S E W U D
        dc.l d1-base,PIC_HALL
        dc.b 0,0,3,2,0,0,0,0      ; hall
        dc.l d2-base,PIC_LIBRARY
        dc.b 0,0,1,0,0,0,0,0      ; library
        dc.l d3-base,PIC_KITCHEN
        dc.b 0,0,0,1,0,4,0,0      ; kitchen
        dc.l d4-base,PIC_CELLAR
        dc.b 0,0,0,0,3,0,0,0      ; cellar
        dc.l d5-base,PIC_STUDY
        dc.b 0,1,0,0,0,0,0,0      ; study
        dc.l d6-base,PIC_SECRET
        dc.b 0,0,2,0,0,0,0,0      ; secret
objects                              ; noun, place, flags, 0, name, examine text
        dc.b 1,1,2,0
        dc.l t0-base,t1-base
        dc.b 2,1,2,0
        dc.l t0-base,t2-base
        dc.b 3,1,2,0
        dc.l t0-base,t3-base
        dc.b 4,1,2,0
        dc.l t0-base,t4-base
        dc.b 5,2,2,0
        dc.l t0-base,t5-base
        dc.b 6,2,2,0
        dc.l t0-base,t6-base
        dc.b 7,3,1,0
        dc.l t7-base,t8-base
        dc.b 7,0,1,0
        dc.l t9-base,t10-base
        dc.b 8,3,1,0
        dc.l t11-base,t12-base
        dc.b 9,3,1,0
        dc.l t13-base,t14-base
        dc.b 10,3,2,0
        dc.l t0-base,t15-base
        dc.b 11,4,1,0
        dc.l t16-base,t17-base
        dc.b 12,4,2,0
        dc.l t0-base,t18-base
        dc.b 13,5,2,0
        dc.l t0-base,t19-base
        dc.b 14,5,1,0
        dc.l t20-base,t21-base
        dc.b 15,5,2,0
        dc.l t0-base,t22-base
        dc.b 16,6,2,0
        dc.l t0-base,t23-base
        dc.b 17,6,2,0
        dc.l t0-base,t24-base
        dc.b 18,6,2,0
        dc.l t0-base,t25-base
        dc.b 19,6,2,0
        dc.l t0-base,t26-base
        dc.b 20,3,2,0
        dc.l t0-base,t27-base
        dc.b 21,5,2,0
        dc.l t0-base,t28-base
nouns                                ; four letters + noun number, 0 = end
        dc.b "STAI",1
        dc.b "PORT",2
        dc.b "PAIN",2
        dc.b "PICT",2
        dc.b "DOOR",3
        dc.b "LOCK",3
        dc.b "CHAN",4
        dc.b "BOOK",5
        dc.b "RED ",5
        dc.b "SHEL",6
        dc.b "CAND",7
        dc.b "MATC",8
        dc.b "BOX ",8
        dc.b "KNIF",9
        dc.b "STOV",10
        dc.b "POTS",10
        dc.b "KEY ",11
        dc.b "BARR",12
        dc.b "WINE",12
        dc.b "DESK",13
        dc.b "PAPE",13
        dc.b "DIAR",14
        dc.b "JOUR",14
        dc.b "WIND",15
        dc.b "UNCL",16
        dc.b "EDMU",16
        dc.b "MAN ",16
        dc.b "ROPE",17
        dc.b "KNOT",17
        dc.b "AMUL",18
        dc.b "CIRC",19
        dc.b "SYMB",19
        dc.b "MICR",20
        dc.b "OVEN",20
        dc.b "JAR ",21
        dc.b "TENT",21
        dc.b "CELL",22
        dc.b "LAMP",23
        dc.b "FORC",24
        dc.b 0
actions                              ; verb, noun, length, conditions, actions, 0 ... $ff
        dc.b $0d,$14,$08,$04,$03,$20,$01,$00
        dc.b $0f,$14,$08,$04,$03,$20,$01,$00
        dc.b $09,$15,$08,$04,$05,$20,$02,$00
        dc.b $0d,$15,$08,$04,$05,$20,$02,$00
        dc.b $09,$17,$08,$04,$04,$20,$03,$00
        dc.b $0c,$0c,$0d,$04,$04,$06,$00,$20,$04,$21,$00,$2c,$00
        dc.b $1c,$0c,$0d,$04,$04,$06,$00,$20,$04,$21,$00,$2c,$00
        dc.b $08,$0c,$0d,$04,$04,$06,$00,$20,$04,$21,$00,$2c,$00
        dc.b $17,$07,$08,$02,$08,$20,$05,$00
        dc.b $17,$07,$12,$02,$07,$02,$09,$20,$06,$23,$07,$00,$23,$08,$ff,$26,$0a,$00
        dc.b $17,$07,$08,$02,$07,$20,$07,$00
        dc.b $17,$07,$08,$01,$07,$20,$08,$00
        dc.b $17,$08,$08,$02,$09,$20,$09,$00
        dc.b $07,$00,$0a,$04,$03,$03,$08,$20,$0a,$00
        dc.b $01,$16,$0a,$04,$03,$03,$08,$20,$0a,$00
        dc.b $01,$16,$08,$04,$03,$24,$04,$00
        dc.b $0a,$07,$0a,$04,$04,$02,$08,$20,$0b,$00
        dc.b $11,$03,$0a,$04,$01,$05,$01,$20,$0c,$00
        dc.b $11,$03,$14,$04,$01,$02,$0c,$20,$0d,$21,$01,$25,$01,$00,$05,$26,$0a,$2b,$06,$00
        dc.b $11,$03,$08,$04,$01,$20,$0e,$00
        dc.b $0d,$03,$0a,$04,$01,$05,$01,$20,$0f,$00
        dc.b $0d,$03,$14,$04,$01,$02,$0c,$20,$0d,$21,$01,$25,$01,$00,$05,$26,$0a,$2b,$06,$00
        dc.b $0d,$03,$08,$04,$01,$20,$10,$00
        dc.b $0f,$0b,$16,$04,$01,$02,$0c,$06,$01,$20,$0d,$21,$01,$25,$01,$00,$05,$26,$0a,$2b,$06,$00
        dc.b $02,$00,$0a,$04,$01,$06,$01,$20,$11,$00
        dc.b $06,$00,$08,$04,$01,$20,$12,$00
        dc.b $1b,$00,$08,$04,$01,$20,$12,$00
        dc.b $03,$00,$08,$04,$01,$20,$13,$00
        dc.b $0d,$03,$08,$04,$01,$20,$14,$00
        dc.b $10,$0e,$0e,$01,$0f,$06,$02,$20,$15,$21,$02,$26,$05,$00
        dc.b $0d,$0e,$08,$01,$0f,$20,$15,$00
        dc.b $0c,$0d,$0a,$04,$05,$06,$02,$20,$16,$00
        dc.b $13,$05,$0a,$04,$02,$05,$03,$20,$17,$00
        dc.b $13,$05,$12,$04,$02,$20,$18,$21,$03,$25,$02,$03,$06,$26,$0f,$2b,$06,$00
        dc.b $14,$05,$08,$04,$02,$20,$19,$00
        dc.b $09,$05,$0a,$04,$02,$06,$03,$20,$1a,$00
        dc.b $10,$05,$08,$04,$02,$20,$1b,$00
        dc.b $18,$00,$0e,$04,$06,$02,$0a,$20,$1c,$26,$14,$27,$03,$00
        dc.b $19,$00,$0e,$04,$06,$02,$0a,$20,$1c,$26,$14,$27,$03,$00
        dc.b $0f,$09,$0e,$04,$06,$02,$0a,$20,$1c,$26,$14,$27,$03,$00
        dc.b $19,$00,$08,$04,$06,$20,$1d,$00
        dc.b $18,$00,$08,$04,$06,$20,$1e,$00
        dc.b $20,$00,$08,$04,$06,$20,$1f,$00
        dc.b $09,$12,$08,$04,$06,$20,$20,$00
        dc.b $09,$10,$08,$04,$06,$20,$21,$00
        dc.b $37,$00,$0a,$03,$08,$03,$07,$20,$22,$00
        dc.b $37,$00,$0a,$03,$08,$03,$09,$20,$23,$00
        dc.b $37,$00,$08,$03,$08,$20,$24,$00
        dc.b $37,$00,$0a,$06,$01,$03,$0c,$20,$25,$00
        dc.b $37,$00,$08,$06,$01,$20,$26,$00
        dc.b $37,$00,$0a,$06,$03,$06,$02,$20,$27,$00
        dc.b $37,$00,$08,$06,$03,$20,$28,$00
        dc.b $37,$00,$08,$03,$0a,$20,$29,$00
        dc.b $37,$00,$06,$20,$2a,$00
        dc.b $45,$00,$06,$20,$2b,$00
        dc.b $46,$00,$06,$20,$2c,$00
        dc.b $47,$00,$06,$20,$2d,$00
        dc.b $0f,$18,$06,$20,$2e,$00
        dc.b $09,$17,$06,$20,$2f,$00
        dc.b $22,$00,$06,$20,$30,$00
        dc.b $00,$00,$0c,$04,$06,$06,$04,$20,$31,$21,$04,$00
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
        dc.b $11,"PING! NOTHING HAPPENS. AND THAT IS",$0d,"PROBABLY FOR THE BEST."
        dc.b $0d,0
m2
        dc.b $11,"THE TENTACLE GLARES AT YOU. YOU DECIDE",$0d,"TO LEAVE IT FOR SOME OTHER HERO."
        dc.b $0d,0
m3
        dc.b $11,"IT IS PITCH BLACK. YOU ARE LIKELY TO BE",$0d,"EATEN BY A GRUE... LUCKILY, YOU HAVE A"
        dc.b $0d,"CANDLE.",$0d,0
m4
        dc.b $11,"BETWEEN TWO OLD BARRELS SOMETHING",$0d,"GLITTERS... A TINY PIECE OF STARLIGHT!"
        dc.b $0d,0
m5
        dc.b $11,"IT IS ALREADY BURNING.",$0d,0
m6
        dc.b $11,"YOU STRIKE A MATCH AND LIGHT THE",$0d,"CANDLE. A WARM GLOW SURROUNDS YOU."
        dc.b $0d,0
m7
        dc.b $11,"YOU HAVE NOTHING TO LIGHT IT WITH.",$0d,0
m8
        dc.b $11,"YOU ARE NOT HOLDING IT.",$0d,0
m9
        dc.b $11,"THE MATCH FLARES UP AND BURNS OUT. WHAT",$0d,"A WASTE.",$0d,0
m10
        dc.b $11,"IT IS PITCH BLACK DOWN THERE. YOU DARE",$0d,"NOT GO DOWN WITHOUT A LIGHT."
        dc.b $0d,0
m11
        dc.b $11,"BETTER NOT. YOU WOULD BE LEFT IN THE",$0d,"DARK.",$0d,0
m12
        dc.b $11,"IT IS ALREADY UNLOCKED.",$0d,0
m13
        dc.b $11,"THE SILVER KEY FITS! THE SMALL DOOR",$0d,"SWINGS OPEN.",$0d,0
m14
        dc.b $11,"YOU HAVE NOTHING TO UNLOCK IT WITH.",$0d,0
m15
        dc.b $11,"IT IS ALREADY OPEN.",$0d,0
m16
        dc.b $11,"THE SMALL DOOR IS LOCKED. IT HAS A",$0d,"SILVER LOCK.",$0d,0
m17
        dc.b $11,"THE SMALL DOOR IS LOCKED.",$0d,0
m18
        dc.b $11,"BROKEN BEAMS BLOCK THE STAIRS.",$0d,0
m19
        dc.b $11,"THE FRONT DOOR WILL NOT BUDGE.",$0d,0
m20
        dc.b $11,"IT IS LOCKED.",$0d,0
m21
        dc.b $11,"THE LAST ENTRY READS: 'THEY ARE COMING",$0d,"FOR THE AMULET. IF ANYTHING HAPPENS TO"
        dc.b $0d,"ME, PULL THE RED BOOK.'",$0d,0
m22
        dc.b $11,"AMONG THE PAPERS LIES UNCLE EDMUND'S",$0d,"DIARY.",$0d,0
m23
        dc.b $11,"NOTHING MORE HAPPENS.",$0d,0
m24
        dc.b $11,"YOU PULL THE RED BOOK. WITH A GRINDING",$0d,"NOISE THE SHELF SWINGS ASIDE, REVEALING"
        dc.b $0d,"A PASSAGE TO THE WEST!",$0d,0
m25
        dc.b $11,"IT WON'T GO IN ANY FURTHER. MAYBE PULL",$0d,"IT?",$0d,0
m26
        dc.b $11,"IT WON'T COME OFF THE SHELF. IT SEEMS",$0d,"TO BE ATTACHED TO SOMETHING."
        dc.b $0d,0
m27
        dc.b $11,"THE PAGES ARE GLUED TOGETHER. ODD.",$0d,0
m28
        dc.b $11,"YOU CUT THROUGH THE ROPES. UNCLE EDMUND",$0d,"PULLS OFF HIS GAG: 'YOU FOUND ME!"
        dc.b $0d,"LISTEN: THE AMULET IS NO JEWEL. IT IS",$0d,"THE KEY TO A STARSHIP HIDDEN BENEATH"
        dc.b $0d,"THIS HOUSE, AND THEY WANT IT. FOLLOW",$0d,"ME!' HE PULLS A LEVER AND A STAIRWAY"
        dc.b $0d,"OPENS IN THE FLOOR.",$0d,0
m29
        dc.b $11,"THE KNOTS ARE FAR TOO TIGHT. YOU NEED",$0d,"SOMETHING SHARP."
        dc.b $0d,0
m30
        dc.b $11,"YOU NEED SOMETHING SHARP.",$0d,0
m31
        dc.b $11,"UNCLE EDMUND MUMBLES THROUGH HIS GAG:",$0d,"'MMPH! CUT! MMPH!'"
        dc.b $0d,0
m32
        dc.b $11,"AS YOU REACH FOR IT, THE CIRCLE FLARES",$0d,"UP AND THROWS YOU BACK. FIRST FREE YOUR"
        dc.b $0d,"UNCLE.",$0d,0
m33
        dc.b $11,"HE IS TIED TO THE CHAIR.",$0d,0
m34
        dc.b $11,"THE KITCHEN HAS SOMETHING TO LIGHT YOUR",$0d,"WAY.",$0d,0
m35
        dc.b $11,"YOU NEED SOMETHING TO LIGHT THE CANDLE",$0d,"WITH.",$0d,0
m36
        dc.b $11,"LIGHT THE CANDLE.",$0d,0
m37
        dc.b $11,"WITH A LIGHT YOU CAN EXPLORE THE CELLAR",$0d,"BELOW THE KITCHEN."
        dc.b $0d,0
m38
        dc.b $11,"THE SILVER KEY OPENS THE SMALL DOOR IN",$0d,"THE HALL.",$0d,0
m39
        dc.b $11,"READ THE DIARY IN THE STUDY.",$0d,0
m40
        dc.b $11,"PULL THE RED BOOK IN THE LIBRARY.",$0d,0
m41
        dc.b $11,"YOU WILL NEED SOMETHING SHARP. THE",$0d,"KITCHEN HAS A KNIFE."
        dc.b $0d,0
m42
        dc.b $11,"CUT THE ROPES IN THE HIDDEN CHAMBER.",$0d,0
m43
        dc.b $11,"A HOLLOW VOICE SAYS: WRONG GAME. THIS",$0d,"ISN'T COLOSSAL CAVE."
        dc.b $0d,0
m44
        dc.b $11,"GOD MODE? NICE TRY. THIS IS A COMMODORE",$0d,"64, NOT A 486."
        dc.b $0d,0
m45
        dc.b $11,"THAT'S THE ANSWER TO LIFE, THE UNIVERSE",$0d,"AND EVERYTHING. BUT WHAT WAS THE"
        dc.b $0d,"QUESTION?",$0d,0
m46
        dc.b $11,"YOU WAVE YOUR HAND. THESE AREN'T THE",$0d,"COMMANDS YOU'RE LOOKING FOR."
        dc.b $0d,0
m47
        dc.b $11,"THERE IS NO LAMP HERE. THIS ISN'T ZORK,",$0d,"YOU KNOW. BUT WATCH OUT FOR GRUES"
        dc.b $0d,"ANYWAY.",$0d,0
m48
        dc.b $11,"TYPE COMMANDS LIKE TAKE KEY, OPEN DOOR,",$0d,"EXAMINE MAT, N S E W U D, L = LOOK,"
        dc.b $0d,"I = INVENTORY, TAKE ALL, DROP ALL,",$0d,"G = AGAIN, SCORE, MAP, SAVE, LOAD, QUIT"
        dc.b $0d,"F1 LOAD  F3 SAVE  F5 MUSIC  F7 QUIT",$0d,"THREE SAVE SLOTS: PRESS 1, 2 OR 3."
        dc.b $0d,"HINT GIVES A CLUE BUT COSTS 3 POINTS.",$0d,"FIND THE 16 HIDDEN STAR FRAGMENTS!"
        dc.b $0d,0
m49
        dc.b $17,"UNCLE EDMUND LOOKS UP AND STRUGGLES",$0d,"AGAINST HIS ROPES."
        dc.b $0d,0
t_intro
        dc.b $11,"THE FRONT DOOR WILL NOT BUDGE. YOU ARE",$0d,"TRAPPED INSIDE RAVENMOOR MANOR."
        dc.b $0d,"SOMEWHERE IN THIS HOUSE IS UNCLE",$0d,"EDMUND.",$0d,$0d,0
t_title
        dc.b $17,$0d,"PROLOGUE, PART 2: THE MANOR",$0d,$0d,0
t_short
        dc.b "PROLOGUE 2",0
t_quip
        dc.b $17,"UNCLE EDMUND WILL HAVE TO RESCUE",$0d,"HIMSELF NOW. THANKS A LOT."
        dc.b $0d,0
d1
        dc.b $1d,"YOU ARE IN THE GRAND HALL. A CHANDELIER",$0d,"SWAYS ABOVE A CHEQUERED FLOOR. THE"
        dc.b $0d,"STAIRS ARE BLOCKED. DOORS LEAD WEST AND",$0d,"EAST, AND A SMALL DOOR LEADS NORTH."
        dc.b $0d,0
d2
        dc.b $1d,"YOU ARE IN THE LIBRARY. OLD BOOKS REACH",$0d,"TO THE CEILING. ONE RED BOOK STICKS OUT"
        dc.b $0d,"FURTHER THAN THE OTHERS.",$0d,0
d3
        dc.b $1d,"YOU ARE IN A COLD KITCHEN. POTS HANG",$0d,"ABOVE AN IRON STOVE. STEPS LEAD DOWN TO"
        dc.b $0d,"THE CELLAR. AN OLD MICROWAVE STANDS IN",$0d,"THE CORNER.",$0d
        dc.b 0
d4
        dc.b $1d,"YOU ARE IN THE WINE CELLAR. BY",$0d,"CANDLELIGHT YOU SEE BARRELS ALONG THE"
        dc.b $0d,"DAMP STONE WALLS.",$0d,0
d5
        dc.b $1d,"YOU ARE IN UNCLE EDMUND'S STUDY. PAPERS",$0d,"LIE SCATTERED ACROSS A LARGE OAK DESK."
        dc.b $0d,"MOONLIGHT FALLS THROUGH A TALL WINDOW.",$0d,"ON A SHELF STANDS A JAR WITH SOMETHING"
        dc.b $0d,"PURPLE IN IT.",$0d,0
d6
        dc.b $1d,"YOU ARE IN A HIDDEN CHAMBER. A CIRCLE",$0d,"OF SYMBOLS GLOWS ON THE FLOOR. UNCLE"
        dc.b $0d,"EDMUND IS TIED TO A CHAIR IN THE",$0d,"MIDDLE!",$0d,0
t0
        dc.b 0
t1
        dc.b $11,"BROKEN BEAMS BLOCK THE TOP OF THE",$0d,"STAIRS.",$0d,0
t2
        dc.b $11,"A PORTRAIT OF UNCLE EDMUND. HE IS",$0d,"HOLDING A RED BOOK."
        dc.b $0d,0
t3
        dc.b $11,"A SMALL DOOR WITH A SILVER LOCK.",$0d,0
t4
        dc.b $11,"IT IS THICK WITH DUST AND COBWEBS.",$0d,0
t5
        dc.b $11,"A RED LEATHER BOOK. IT SEEMS STUCK TO",$0d,"THE SHELF.",$0d,0
t6
        dc.b $11,"HUNDREDS OF DUSTY BOOKS. ONE RED BOOK",$0d,"STICKS OUT.",$0d
        dc.b 0
t7
        dc.b "A WAX CANDLE",0
t8
        dc.b $11,"AN UNLIT WAX CANDLE.",$0d,0
t9
        dc.b "A BURNING CANDLE",0
t10
        dc.b $11,"THE FLAME FLICKERS IN THE DRAUGHT.",$0d,0
t11
        dc.b "A BOX OF MATCHES",0
t12
        dc.b $11,"A SMALL BOX WITH A FEW MATCHES LEFT.",$0d,0
t13
        dc.b "A KITCHEN KNIFE",0
t14
        dc.b $11,"A SHARP KITCHEN KNIFE.",$0d,0
t15
        dc.b $11,"COLD AND RUSTY. NOBODY HAS COOKED HERE",$0d,"FOR DAYS.",$0d,0
t16
        dc.b "A SILVER KEY",0
t17
        dc.b $11,"A SMALL SILVER KEY.",$0d,0
t18
        dc.b $11,"OLD WINE BARRELS. THEY ARE ALL EMPTY.",$0d,0
t19
        dc.b $11,"AMONG THE PAPERS LIES UNCLE EDMUND'S",$0d,"DIARY.",$0d,0
t20
        dc.b "A LEATHER DIARY",0
t21
        dc.b $11,"THE LAST ENTRY READS: 'THEY ARE COMING",$0d,"FOR THE AMULET. IF ANYTHING HAPPENS TO"
        dc.b $0d,"ME, PULL THE RED BOOK.'",$0d,0
t22
        dc.b $11,"THE WINDOW IS BARRED. NO WAY OUT THERE.",$0d,0
t23
        dc.b $11,"HE IS GAGGED AND TIED UP WITH THICK",$0d,"ROPES, BUT ALIVE!"
        dc.b $0d,0
t24
        dc.b $11,"THICK ROPES WITH TIGHT KNOTS.",$0d,0
t25
        dc.b $11,"A GOLDEN AMULET WITH A RED STONE. IT",$0d,"GLOWS FAINTLY.",$0d
        dc.b 0
t26
        dc.b $11,"THE SYMBOLS PULSE WITH A COLD BLUE",$0d,"LIGHT.",$0d,0
t27
        dc.b $11,"AN OLD MICROWAVE. A NOTE ON IT SAYS:",$0d,"DON'T EVEN THINK ABOUT PUTTING ANYTHING"
        dc.b $0d,"SMALL AND FURRY IN HERE.",$0d,0
t28
        dc.b $11,"A PURPLE TENTACLE FLOATS IN A JAR OF",$0d,"GREEN GOO. IT LOOKS LIKE IT WANTS TO"
        dc.b $0d,"TAKE OVER THE WORLD. NOT TODAY.",$0d,0
t_save
        dc.b "SAVE1-MANOR",0
map_data                             ; 1-8 / $81-$88 = room label, $0e = label end, $60/$62 lines
        dc.b $17,$4d,$41,$50,$3a,$20,$54,$48,$45,$20,$4d,$41,$4e,$4f,$52,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$20,$20,$20,$20,$20,$20,$05,$53,$54,$55,$44,$59,$0e,$0d,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f,$20,$20,$86,$53,$45,$43,$52,$45,$54,$60,$60,$60,$0e,$02,$4c,$49,$42,$52,$41,$52,$59
        dc.b $0e,$60,$60,$60,$60,$60,$01,$48,$41,$4c,$4c,$0e,$60,$60,$60,$60,$03,$4b,$49,$54,$43,$48,$45,$4e,$0e,$0d,$1f,$20,$20,$20,$20,$20
        dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$62,$0d,$1f
        dc.b $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
        dc.b $04,$43,$45,$4c,$4c,$41,$52,$0e,$0d,$00
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
        dc.b 0
        even
frames                               ; offsets of the sprite images
speech                               ; message number, 0, offset of the sample in the blob
        dc.w 0
card                                 ; next part: kind, name, spoken title (in the blob)
        dc.l card_k-base,card_n-base
        dc.l $01fc2a             ; "Prologue, Part 3. The Launch Pad"
card_k
        dc.b "PROLOGUE, PART 3",0
card_n
        dc.b "THE LAUNCH PAD",0
        even
        even
part_end
