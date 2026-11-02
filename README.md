# The World of Stronkie
Adventure Game made for the Commodore 64

Created By Mark Stronks

**Current version: V0.02** — download `The_World_of_Stronkie_V0.02.d64`

## What is the game about

The World of Stronkie is a text and graphics adventure in the style of the classic 1980s adventure games. You explore the world by typing commands, every location has its own picture, and you solve puzzles by finding, combining and using objects.

**The story (chapters 1 and 2):** a letter from your uncle Edmund brought you to Ravenmoor Manor: *"Come to Ravenmoor at once. I have found it."* Nobody has seen him since. On a stormy night you arrive at the gates of his manor...

- **Chapter 1 – The Grounds:** search the overgrown garden, the shed, the old well and the porch, and find a way into the manor.
- **Chapter 2 – The Manor:** explore the hall, the kitchen, the dark cellar, the study and the library, and find out what happened to uncle Edmund.

### How to play

1. Attach `The_World_of_Stronkie_V0.02.d64` as drive 8 (real 1541, SD2IEC, or an emulator like VICE).
2. Type `LOAD"*",8` and then `RUN`.
3. The main menu appears while the first chapter loads. When the border flashes, press any key.

Type two-word commands, for example:

| Command | What it does |
|---|---|
| `N` `S` `E` `W` `U` `D` (or `GO NORTH`) | move around |
| `L` / `LOOK` | describe the location again |
| `I` / `INVENTORY` | show what you are carrying |
| `EXAMINE MAT`, `LOOK UNDER MAT` | look closely at things |
| `TAKE KEY`, `DROP KEY` | pick up and drop objects |
| `OPEN DOOR`, `UNLOCK DOOR`, `PULL BOOK`, `DIG`, `TURN HANDLE`, `LIGHT CANDLE` | interact with the world |
| `HELP`, `SCORE`, `QUIT` | help, your score, quit the game |

Only the first four letters of a word count, and small words like THE, WITH and UNDER are skipped. The maximum score is 100.

### Features

- Full-screen multicolour main menu picture
- A picture for every location (multicolour bitmap in the top half of the screen, text in the bottom half, using a raster split)
- Two-word command parser with about 50 verbs
- Every chapter is its own file on the disk and is loaded when you reach it, so the game can grow beyond the memory of the C64
- Score, death, quit and play-again
- Works with the normal KERNAL disk routines (no fast loader needed)

### Files on the disk

| File | Contents |
|---|---|
| `STRONKIE WORLD` | the game program (load this one, or use `LOAD"*",8`) |
| `MENU` | the main menu picture |
| `CHAPTER1` | Chapter 1: The Grounds (pictures, texts, objects and puzzles) |
| `CHAPTER2` | Chapter 2: The Manor |

## How was it created

The game is written in 6502 machine language (64tass-compatible assembler syntax).

- **Engine:** handles the screen (raster interrupt that switches between bitmap and text mode halfway down the screen), the command parser, the inventory, and a small script interpreter for the puzzles.
- **Chapters:** each chapter is a separate data file that is loaded to `$4000`. It holds the rooms, objects, words, puzzle scripts (conditions and actions), messages, and the room pictures (RLE compressed).
- **Pictures:** drawn at 160×96 pixels in the 16 C64 colours and converted to C64 multicolour bitmap format. The main menu picture was converted from Mark's artwork to a full 160×200 multicolour screen.

Memory map:

| Address | Use |
|---|---|
| `$0801-$1FFF` | game engine |
| `$2000-$3F3F` | bitmap (menu: full screen, in game: top 12 rows) |
| `$0400` / `$D800` | screen and colour memory |
| `$4000-$CFFF` | menu picture or the current chapter (BASIC ROM switched off) |

## Version numbers

| Version | Date | Notes |
|---|---|---|
| V0.02 | 2 Nov 2026 | Renamed to The World of Stronkie, new main menu picture |
| V0.01 | 2 Nov 2026 | First playable version (as "Stronkie's Quest", not published) |

## Change log

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
