# The World of Stronkie
Adventure Game made for the Commodore 64

Created By Mark Stronks

**Current version: V1.4** — download both disk sides: `The_World_of_Stronkie_V1.4_sideA.d64` and `The_World_of_Stronkie_V1.4_sideB.d64`

Older versions are in the `previous versions` folder.

## What is the game about

The World of Stronkie is a text and graphics adventure in the style of the classic 1980s adventure games. You explore the world by typing commands, every location has its own picture, and you solve puzzles by finding, combining and using objects.

### Storyline

A letter from your uncle Edmund brought you to Ravenmoor Manor: *"Come to Ravenmoor at once. I have found it."* Nobody has seen him since. What starts as a mystery in an old manor turns out to be the beginning of a journey through space, to a planet that was lost long ago: **the World of Stronkie**.

**Prologue – Ravenmoor**

- **Part 1 – The Grounds:** on a stormy night you arrive at the gates of the manor. Search the overgrown garden, the shed and the old well to find a way inside.
- **Part 2 – The Manor:** explore the hall, the kitchen, the dark cellar, the study and the library, and find the secret chamber where uncle Edmund is held prisoner. He reveals that the amulet is no jewel: it is the key to a starship hidden beneath the house.
- **Part 3 – The Launch Pad:** a hidden stairway leads to a bunker and a giant hangar carved into the rock. There stands the silver starship STARRAVEN. Find a keycard and a flight suit, power up the launch systems with the amulet, board the ship and blast off through the opening roof, while soldiers break into the manor above.

**The space adventure**

The space chapters are full of nods to the classic adventure games: Space Quest, Leisure Suit Larry, Monkey Island, The Hitchhiker's Guide to the Galaxy and Star Trek. And watch out for a certain C64 programmer called Mark Stronks AKA Stronkie...


- **Chapter 1 – Into Space:** the ship's computer NOVA wakes up. The navigation crystal cracked during the launch. Find magnetic boots for the zero-gravity cargo hold, pry open the spare-parts crate, repair the navigation and jump into hyperspace.
- **Chapter 2 – The Derelict Station:** dock at the abandoned space station KX-9. Get past the security robot, restart the generator and take the star chart that shows the way to the World of Stronkie.
- **Chapter 3 – Asteroid 42:** the hyperjump drained the fuel cells, so NOVA lands on Asteroid 42, the most wretched hive of scum and villainy this side of Andromeda. A fuel cell costs 50 buckazoids and you have none. Help Roger the janitor, find the password for Lefty's back room, outsmart the Slots-o-Death machine and do business with Stan.
- **Chapter 4 – Space Pirates:** Captain LeChuckle's pirate ship, the SPACE MONKEY, grabs you with a tractor beam. Cross to the pirate ship in a very unusual way, beat the guard at insult swordfighting, trick the captain and switch off the beam.

**The World of Stronkie**

- **Chapter 5 – Landfall:** hit by the pirates' parting shot, the STARRAVEN crash-lands in a purple jungle under two suns. Blow the jammed hatch, put out the burning engine, swing across a glowing river and break a new power crystal loose for the ship. A hungry little Stronkie guards the gate to his village...
- **Chapter 6 – The Village:** the Stronkies only chirp until you find a way to understand them. Elder Zooma tells you the truth: your amulet is the key of the Sky Temple, where the Star Heart keeps the planet alive, and Commander Vex has come to steal its power. Bix the inventor can fly you there, if you find him a sail.
- **Chapter 7 – The Crystal Mountains:** Vex has stolen the amulet from your ship! Cross an ice bridge without waking the beast in the ice cave, sneak into Vex's camp and take the amulet back.
- **Chapter 8 – The Sky Temple:** open the crystal gate, catch the sunlight with a silver mirror and make an invisible bridge appear. But behind the golden door, Vex is waiting.
- **Chapter 9 – The Star Heart:** Vex is draining the Star Heart with his machine. Use the old Stronkie legends to stop him and save the World of Stronkie. *The end... for now!*

### How to play

1. Attach `The_World_of_Stronkie_V1.4_sideA.d64` as drive 8 (real 1541, SD2IEC, or an emulator like VICE). Keep `The_World_of_Stronkie_V1.4_sideB.d64` ready: the final chapter is on side B, and the game will ask you to flip the disk.
2. Type `LOAD"*",8` and then `RUN`.
3. The main menu appears with music while the first chapter loads ("LOADING... PLEASE WAIT"). When loading is done the text changes to "N:NEW GAME  L:LOAD GAME" and the border flashes.
4. Press `N` to start a new game, or `L` to continue your saved game. If there is no saved game on the disk, a new game starts.

Type two-word commands, for example:

| Command | What it does |
|---|---|
| `N` `S` `E` `W` `U` `D` (or `GO NORTH`) | move around |
| `L` / `LOOK` | describe the location again |
| `I` / `INVENTORY` | show what you are carrying |
| `EXAMINE MAT`, `LOOK UNDER MAT` | look closely at things |
| `TAKE KEY`, `DROP KEY`, `WEAR SUIT`, `INSERT CARD` | pick up, drop, wear and use objects |
| `OPEN DOOR`, `PULL LEVER`, `DIG`, `LIGHT CANDLE`, `PRESS BUTTON`, `TALK TO NOVA` | interact with the world |
| `TAKE ALL`, `DROP ALL` | pick up or drop everything at once |
| `G` / `AGAIN` | repeat your last command |
| `HINT` | a clue for your next step (costs 3 points) |
| `SAVE`, `LOAD` (or `RESTORE`) | save your game to the disk, and continue it later |
| `HELP`, `SCORE`, `QUIT` | help, your score and star fragments, quit to the main menu |
| `MUSIC` | turn the music off or back on (sound effects keep playing) |
| `RUN/STOP` + `RESTORE` | leave the game completely (resets the C64) |

**Function keys** (work at any time while you type a command):

| Key | What it does |
|---|---|
| `F1` | load your saved game (asks first: all progress in this game will be lost) |
| `F3` | save the game, under the name of the part you are in |
| `F5` | music off / on |
| `F7` | quit to the main menu (asks first) |

Only the first four letters of a word count, and small words like THE, WITH and UNDER are skipped.

### Score

The status bar under the picture always shows the part you are in, your **score** and the number of **moves** (every command you type counts as one move). You earn points for solving puzzles, for example 10 points for digging up the handle or opening a door. Every time you score, a short jingle plays.

**Star fragments:** every part hides one star fragment, worth 10 points each. They only turn up if you search the right place carefully. The status bar shows how many you have found (`*02/12`).

**Hints:** stuck? Type `HINT` for a clue about your next step. Each hint costs 3 points.

The maximum score is 735 (610 for the story, 120 for the twelve star fragments, and a 5 point bonus for a certain arcade machine). Rumour has it that there is also something secret hidden on the planet...

Stuck? [walkthrough.txt](walkthrough.txt) is a complete walkthrough that takes you through the whole game with all 735 points, all twelve star fragments and the secret, plus a list of jokes and secret commands to try. Try to get it in as few moves as possible, without hints!

### Saving, dying and disk sides

- `SAVE` (or `F3`) writes your game to the disk under the name of the part you are in, for example `SAVE-LANDFALL` or `SAVE-SKY TEMPLE`, so the disk directory shows how far you got. A new save replaces the old one, and the disk must not be write-protected. `LOAD`, `RESTORE` or `F1` asks if you are sure, then brings you back to the exact same spot, with all your items, score and moves. You can type `LOAD` right after starting a new game.
- If you die, the game asks **TRY THIS PART AGAIN?** Press `Y` to restart the current part with the score you had when you entered it, or `N` to go back to the main menu.
- The game is on two disk sides. Side A holds the program, the menu and parts 1 to 11; side B holds the final chapter (and its own copy of the program and the menu, so either side can start the game). When the game needs a part that is not on the disk in the drive, it says **INSERT THE OTHER SIDE AND PRESS A KEY**.
- A save is written to the side that is in the drive. If you saved on side B, start the game from side A as usual, then insert side B before you press `L` in the main menu.

### Features

- Full-screen multicolour main menu picture with music, and a choice between a new game and loading a saved game
- Full-screen title cards: when you finish a part, the next part's title and picture are shown while it loads
- Animated pictures: twinkling stars, flickering lamps and candles, blinking console lights, a pulsing reactor, a glowing hologram, and screen flashes for lightning, the rocket launch and hyperspace
- New pictures sweep in from left to right when you enter a room
- Coloured text: room descriptions in green, events in white, NOVA in cyan, uncle Edmund in yellow, points and discoveries in yellow, your commands in light blue; every part has its own status bar and border colour
- Status bar with the current part, score and moves
- Music during the game: every part has its own tune, which only changes when the next part loads
- Sound effects: key clicks, taking and dropping items, errors, points, doors, thunder, rocket launch, hyperspace, robot zaps, death and a victory fanfare
- A picture for every location (multicolour bitmap in the top half of the screen, text in the bottom half, using a raster split): 65 locations in 12 parts
- Two-word command parser with about 65 verbs, TAKE ALL / DROP ALL, AGAIN, and messages that tell you which word was not understood
- Save and load, retry a part after dying, hints, and hidden star fragments
- All data files are compressed, so every part loads about twice as fast
- Every part is its own file on the disk and is loaded when you reach it, so the game can grow far beyond the memory of the C64 (each part can be up to 32 KB)
- Score, death, quit and play-again
- Works with the normal KERNAL disk routines (no fast loader needed)

### Files on the disk

| File | Contents |
|---|---|
| `STRONKIE WORLD` | the game program with the menu music (load this one, or use `LOAD"*",8`) |
| `MENU` | the main menu picture |
| `PART01` | Prologue, part 1: The Grounds (pictures, texts, objects, puzzles and music) |
| `PART02` | Prologue, part 2: The Manor |
| `PART03` | Prologue, part 3: The Launch Pad |
| `PART04` | Chapter 1: Into Space |
| `PART05` | Chapter 2: The Derelict Station |
| `PART06` | Chapter 3: Asteroid 42 |
| `PART07` | Chapter 4: Space Pirates |
| `PART08` | Chapter 5: Landfall |
| `PART09` | Chapter 6: The Village |
| `PART10` | Chapter 7: The Crystal Mountains |
| `PART11` | Chapter 8: The Sky Temple |
| `PART12` | Chapter 9: The Star Heart (on side B) |

All data files are packed. Side A holds the program, the menu and parts 1 to 11; side B holds part 12, together with a copy of the program and the menu. When you save, a file named after the part you are in (like `SAVE-THE MANOR`) is added to the disk. New chapters that no longer fit will go on side B, and the game will ask you to flip the disk when it needs them.

## How was it created

The game is written in 6502 machine language (64tass-compatible assembler syntax).

- **Engine:** handles the screen (raster interrupt that switches between bitmap and text mode halfway down the screen), the command parser, the inventory, and a small script interpreter for the puzzles.
- **Compression:** every data file on the disk is packed with a small LZ packer (to about half its size). The engine loads it and then unpacks it in place to `$4000`, which takes about a second, while the load from disk takes half as long as before.
- **Chapters:** each chapter is a separate data file that is unpacked to `$4000`. It holds the rooms, objects, words, puzzle scripts (conditions and actions), messages, and the room pictures (RLE compressed).
- **Pictures:** drawn at 160×96 pixels in the 16 C64 colours and converted to C64 multicolour bitmap format. The main menu picture was converted from Mark's artwork to a full 160×200 multicolour screen.
- **Music:** the main menu plays the SID tune "Contest Demo (part 4)", which the game calls 50 times a second from a raster interrupt. It also keeps playing while chapter 1 loads.
- **Animations:** each room can have a list of up to 16 picture cells whose colours the raster interrupt changes in turn (colour cycling), so lights and stars move without any extra pictures. The title card of the next part is stored in the file of the part before it, so it can be shown while the next part loads.
- **In-game music and sound:** the engine has its own small 3-voice music player. Each part's file contains its own tune, so the music changes only when a new part is loaded. Sound effects borrow the third SID voice for a moment, while the music keeps playing on the other two.

### Credits

- Game: Created By Mark Stronks
- Menu music: "Contest Demo (part 4)" by Sami Seppä (Rock), 1988 Finnish Gold
- In-game music: original tunes made for this game, one for each part (The Grounds, The Manor, The Launch Pad, Into Space, The Derelict Station, Landfall, The Village, The Crystal Mountains, The Sky Temple, The Star Heart)

Memory map:

| Address | Use |
|---|---|
| `$0200-$024F`, `$033C-$03DB` | input buffers, flags and music state (unused system areas) |
| `$0801-$17FF` | game engine code |
| `$1800-$280C` | menu music |
| `$2810-$3BFF` | engine texts, word lists, variables, status bar, in-game music player, sound effects, save/load |
| `$3C00-$3FFF` | in the program file: code for `$C000` (copied at start); afterwards a buffer for the menu rows, save games and the picture wipe |
| `$4000-$BFFF` | menu picture or the current part (32 KB, BASIC ROM switched off); packed files are loaded just below `$C000` and unpacked to `$4000` |
| `$C000-$C3FF` | title cards, colour cycling, flashes and the picture wipe |
| `$C400` / `$C800` | screen memory / copy of the C64 font (VIC bank 3) |
| `$D800` | colour memory |
| `$E000-$FF3F` | bitmap under the KERNAL ROM (menu: full screen, in game: top 12 rows) |

## Version numbers

| Version | Date | Notes |
|---|---|---|
| V1.4 | 2 Nov 2026 | Jokes and secret commands about other games, Sierra-style death jokes, Astro Chicken high score; the game now uses two disk sides |
| V1.3 | 2 Nov 2026 | Internal update for testing; the game itself is unchanged |
| V1.2 | 2 Nov 2026 | Two new space chapters (Asteroid 42 and Space Pirates), humour and classic adventure game references, a secret on the planet |
| V1.1 | 2 Nov 2026 | Function keys: F1 load, F3 save, F5 music on/off, F7 quit to the menu; save files named after the part |
| V1.0 | 2 Nov 2026 | **Release version.** The complete game: prologue + 7 chapters, 54 locations, 580 points, 10 star fragments |
| V0.09 | 2 Nov 2026 | Five new chapters on the planet Stronkie (the story now has 7 chapters), RUN/STOP + RESTORE leaves the game |
| V0.08 | 2 Nov 2026 | New game / load game choice, title cards, animated pictures, picture wipes, coloured text |
| V0.07 | 2 Nov 2026 | Faster loading, save/load, retry after dying, hints, star fragments, TAKE ALL and AGAIN |
| V0.06 | 2 Nov 2026 | Score and moves on screen, music for every part, sound effects |
| V0.05 | 2 Nov 2026 | Three new parts: the launch pad and the first two space chapters |
| V0.04 | 2 Nov 2026 | "Press any key to start" on the main menu |
| V0.03 | 2 Nov 2026 | Main menu music |
| V0.02 | 2 Nov 2026 | Renamed to The World of Stronkie, new main menu picture |
| V0.01 | 2 Nov 2026 | First playable version (as "Stronkie's Quest", not published) |

## Change log

### V1.4
- Secret commands that work everywhere: try XYZZY, IDDQD, 42, USE THE FORCE and GET LAMP
- Nods to classic Commodore 64 games: Impossible Mission, Paradroid, Boulder Dash, The Last Ninja, and a well-known disk command
- Nods to classic adventure games hidden in the rooms: King's Quest, Maniac Mansion, Day of the Tentacle, Zak McKracken, Indiana Jones and the Last Crusade, Portal and The Hitchhiker's Guide to the Galaxy
- Sierra-style death jokes: every part has its own funny line when you die
- Beat Stronkie's high score on the Astro Chicken arcade machine for a 5 point bonus (maximum score now 735)
- The game no longer fits on one disk side: the final chapter is on side B, and both sides can start the game
- Texts can now show double quotes and the $ sign
- The walkthrough is updated, with a list of all the jokes and secret commands

### V1.3
- Internal update for testing; the game itself is unchanged

### V1.2
- Two new chapters in space, before the landing on Stronkie: **Chapter 3 – Asteroid 42** and **Chapter 4 – Space Pirates**, with 11 new locations, new puzzles, new music and two more star fragments (12 in total, maximum score 730)
- The planet chapters are now chapters 5 to 9 (files `PART08` to `PART12`)
- Lots of humour and nods to Space Quest, Leisure Suit Larry, Monkey Island, The Hitchhiker's Guide to the Galaxy and Star Trek, and a few references to Mark Stronks AKA Stronkie
- Insult swordfighting with space pirates, a rubber chicken with a pulley in the middle, and a slot machine called Slots-o-Death
- Type `MAKE IT SO` anywhere in space, in memory of Sir Patrick Stewart (1940-2026)
- Something secret is hidden on the planet. When you find it, you will hear it...
- New verbs: RIDE / SLIDE / ZIP, ORDER, and KEN (try it in the right place)
- Engine: tunes can now play once and then hand back to the part's music; every part now has its own set of 64 game flags
- Saved games from older versions can't be loaded in V1.2, because the parts have been renumbered
- The walkthrough is updated for all 12 parts, with new bad endings and a list of fun things to try

### V1.1
- Function keys while you play: **F1** loads your saved game, **F3** saves, **F5** turns the music off and on, **F7** quits to the main menu
- Loading a saved game during play now asks first: "ALL PROGRESS IN THIS GAME WILL BE LOST. ARE YOU SURE (Y/N)?"
- The save file is named after the part you are in (`SAVE-THE GROUNDS` ... `SAVE-STAR HEART`), so you can see in the disk directory how far you got. Saving again replaces the old save. Old `SAVEGAME` files still load.
- New command `MUSIC` (or `SOUND`) turns the music off and on. When the music is off it stays off in the next parts too; sound effects keep playing
- `QUIT` now goes straight back to the main menu
- `HELP` lists the function keys

### V1.0 — release
- First release version of The World of Stronkie: the three-part prologue and seven chapters, from Uncle Edmund's manor to the Star Heart on the planet Stronkie
- Same game as V0.09, which was tested from start to finish; only the version number changed
- Complete walkthrough added: [walkthrough.txt](walkthrough.txt), with all 580 points, all 10 star fragments and a Bad Endings section that lists every way to die

### V0.09
- Five new chapters on the planet Stronkie: **Landfall**, **The Village**, **The Crystal Mountains**, **The Sky Temple** and the finale **The Star Heart** (26 new locations with pictures and animations)
- New characters: the Stronkies, Elder Zooma, Bix the inventor, and the villain Commander Vex
- Chapter 2 now continues to the World of Stronkie; the game ends after chapter 7
- Every new chapter has its own music, title card, hints, death traps and a hidden star fragment (10 in total, maximum score 580)
- New verbs: SWING, SPRAY, EXTINGUISH, LISTEN, BLOW, MAKE, FIX, WAKE, SHOW, TRADE, BUY, CROSS
- The data files on the disk are now called `PART01` to `PART10`
- RUN/STOP + RESTORE resets the C64 and leaves the game completely; RESTORE alone is ignored
- All ten parts fit on side A; side B is used automatically when the story grows further

### V0.08
- Main menu: press `N` for a new game or `L` to load your saved game
- Title cards: while the next part loads, a full-screen card shows its name and first picture (for at least 3 seconds)
- Colour-cycling animations in 24 rooms: stars, lamps, candles, fires, console lights, warning lights, the reactor, the robot's eye and the hologram
- Screen flashes for the lightning, the rocket launch, hyperspace, the generator and the electric wires
- Room pictures now sweep in from left to right
- Coloured text: descriptions green, events white, NOVA cyan, uncle Edmund yellow, points yellow, commands light blue, messages grey
- Every part has its own status bar and border colour
- Before moving on to the next part, the game waits for a key so you can read the last message

### V0.07
- All data files are compressed: every part loads about twice as fast, and the disk has 387 free blocks
- `SAVE` and `LOAD` / `RESTORE`: save the game to the disk and continue it later
- After dying you can try the current part again, with the score you had when you started it
- `HINT` gives a clue for your next step in every part, for 3 points
- Five hidden star fragments, one in each part (+10 points each, shown on the status bar); maximum score is now 270
- `TAKE ALL`, `DROP ALL`, `AGAIN` / `G`
- When a word is not understood, the game now says which word (I DON'T KNOW THE WORD 'XYZZY')
- If a part is not on the disk, the game asks you to insert the other side (ready for a side B)

### V0.06
- Status bar under the picture with the current part, the score and the number of moves
- Score is now 16-bit (room for many more chapters); a jingle plays whenever you score
- In-game music: every part has its own original tune, which keeps playing for the whole part and changes only when the next part loads
- Sound effects: key clicks, take, drop, error buzz, points, doors, thunder, rocket launch, hyperspace, computer beeps, robot zap, death and a victory fanfare
- Text window is now rows 14-23 (one row went to the status bar)

### V0.05
- The Ravenmoor story is now the **Prologue** of the game (parts 1 and 2)
- New: Prologue part 3, **The Launch Pad**: secret bunker, hangar and the starship STARRAVEN (6 locations)
- New: Chapter 1, **Into Space**: aboard the STARRAVEN with the ship's computer NOVA (6 locations)
- New: Chapter 2, **The Derelict Station**: space station KX-9 (5 locations), ending with "to be continued"
- Freeing uncle Edmund now leads to the launch pad instead of ending the game
- 17 new pictures; maximum score is now 220
- New verbs: LAUNCH, FLY, ENGAGE, SIT, TOUCH, TYPE, INSERT, BOARD, SWITCH, START
- End of the game now shows "CONGRATULATIONS!"

### V0.04
- Main menu shows "PRESS ANY KEY TO START" (in place of "LOADING... PLEASE WAIT") as soon as chapter 1 has loaded

### V0.03
- Main menu music: "Contest Demo (part 4)" by Sami Seppä (Rock), playing at the correct PAL speed
- Music keeps playing while chapter 1 loads, and stops when the game starts
- Memory layout changed so the music, the game and the pictures don't overlap (graphics now in VIC bank 3)
- Start of the game also credits the music
- Previous versions are kept in the `previous versions` folder

### V0.02
- Game renamed to **The World of Stronkie** (all game files renamed to match)
- New full-screen multicolour main menu, made from Mark's artwork
- Chapter 1 now loads in the background while the menu is on screen; the border flashes when the game is ready
- Main menu is a separate file (`MENU`) on the disk
- Start of the game shows the name, version and "Created By Mark Stronks"
- Longer `HELP` text with all the main commands
- RESTORE key no longer crashes the game

### V0.01
- First playable version: engine, two-word parser, split screen with pictures
- Chapter 1 (The Grounds) and Chapter 2 (The Manor), 11 locations with pictures
- Chapters loaded from disk as separate files
