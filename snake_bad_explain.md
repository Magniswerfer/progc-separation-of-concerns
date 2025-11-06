# Line-by-Line Explanation of snake_bad_structure.p8

## Lines 1-2: PICO-8 Header
**Line 1:** `pico-8 cartridge // http://www.pico-8.com`
- PICO-8 cartridge file identifier and reference URL

**Line 2:** `version 41`
- Specifies this cartridge was created with PICO-8 version 41

## Line 3: Lua Code Section
**Line 3:** `__lua__`
- Marker that indicates the start of the Lua code section in the cartridge

**Line 4:** (Empty line for spacing)

## Lines 5-27: _init() Function - Game Initialization
**Line 5:** `function _init()`
- Defines the initialization function that PICO-8 calls once when the game starts

**Line 6:** `  -- snake body segments`
- Comment explaining the next line

**Line 7:** `  snake={{x=8,y=8}}`
- Creates the snake as a table containing one segment (the head) at grid position (8, 8)

**Line 8:** (Empty line)

**Line 9:** `  -- direction`
- Comment for direction variables

**Line 10:** `  dx=1`
- Current horizontal direction: 1 means moving right

**Line 11:** `  dy=0`
- Current vertical direction: 0 means not moving vertically

**Line 12:** (Empty line)

**Line 13:** `  -- next direction buffer`
- Comment explaining buffered direction (prevents multiple direction changes in one frame)

**Line 14:** `  ndx=1`
- Next horizontal direction, initially set to right

**Line 15:** `  ndy=0`
- Next vertical direction, initially set to no vertical movement

**Line 16:** (Empty line)

**Line 17:** `  -- food position`
- Comment for food variables

**Line 18:** `  food={x=16,y=16}`
- Creates food at grid position (16, 16)

**Line 19:** (Empty line)

**Line 20:** `  -- game state`
- Comment for game state variables

**Line 21:** `  score=0`
- Initializes score to 0

**Line 22:** `  gameover=false`
- Initializes game over flag to false (game is active)

**Line 23:** (Empty line)

**Line 24:** `  -- movement timer`
- Comment for timing variables

**Line 25:** `  timer=0`
- Frame counter for controlling snake movement speed

**Line 26:** `  speed=8 -- frames between moves`
- Snake moves every 8 frames (slower = higher number)

**Line 27:** `end`
- Ends the _init() function

**Line 28:** (Empty line)

## Lines 29-157: _update() Function - Game Logic AND Drawing (BAD!)
**Line 29:** `function _update()`
- Defines the update function that PICO-8 calls 30 times per second

**Line 30:** `  -- tegn game over skærm her!`
- Danish comment: "draw game over screen here!" - indicates bad practice (drawing in _update)

**Line 31:** `  if gameover then`
- Checks if the game is over

**Line 32:** `    cls(0)`
- Clears screen with color 0 (black) - DRAWING CODE in _update (bad practice!)

**Line 33:** `    print("game over!",38,50,8)`
- Prints "game over!" at position (38, 50) in color 8 (red) - DRAWING in _update!

**Line 34:** `    print("score:"..score,42,58,7)`
- Prints the score at position (42, 58) in color 7 (white) - DRAWING in _update!

**Line 35:** `    print("length:"..#snake,38,66,7)`
- Prints snake length using #snake (table length operator) - DRAWING in _update!

**Line 36:** `    print("press ❎ or 🅾️",30,80,6)`
- Prints restart instructions with PICO-8 button glyphs - DRAWING in _update!

**Line 37:** `    print("to restart",38,88,6)`
- Continues restart instructions - DRAWING in _update!

**Line 38:** (Empty line)

**Line 39:** `    if btnp(4) or btnp(5) then`
- Checks if button 4 (X) or button 5 (O) was pressed this frame

**Line 40:** `      -- restart alt her`
- Danish comment: "restart everything here" - code duplication from _init()

**Line 41:** `      snake={{x=8,y=8}}`
- Resets snake to starting position - duplicates line 7

**Line 42:** `      dx=1`
- Resets horizontal direction - duplicates line 10

**Line 43:** `      dy=0`
- Resets vertical direction - duplicates line 11

**Line 44:** `      ndx=1`
- Resets next horizontal direction - duplicates line 14

**Line 45:** `      ndy=0`
- Resets next vertical direction - duplicates line 15

**Line 46:** `      food={x=16,y=16}`
- Resets food position - duplicates line 18

**Line 47:** `      score=0`
- Resets score - duplicates line 21

**Line 48:** `      gameover=false`
- Resets game over flag - duplicates line 22

**Line 49:** `      timer=0`
- Resets timer - duplicates line 25

**Line 50:** `      speed=8`
- Resets speed - duplicates line 26

**Line 51:** `    end`
- Ends the button press check

**Line 52:** `    return`
- Exits _update() early if game is over (skips game logic below)

**Line 53:** `  end`
- Ends the game over check

**Line 54:** (Empty line)

**Line 55:** `  -- input handling`
- Comment for input section

**Line 56:** `  if btnp(0) and dx!=1 then`
- Checks if left button pressed AND not currently moving right (prevents 180° turns)

**Line 57:** `    ndx=-1`
- Sets next direction to left

**Line 58:** `    ndy=0`
- Clears vertical direction

**Line 59:** `  elseif btnp(1) and dx!=-1 then`
- Checks if right button pressed AND not currently moving left

**Line 60:** `    ndx=1`
- Sets next direction to right

**Line 61:** `    ndy=0`
- Clears vertical direction

**Line 62:** `  elseif btnp(2) and dy!=1 then`
- Checks if up button pressed AND not currently moving down

**Line 63:** `    ndx=0`
- Clears horizontal direction

**Line 64:** `    ndy=-1`
- Sets next direction to up (negative Y is up in PICO-8)

**Line 65:** `  elseif btnp(3) and dy!=-1 then`
- Checks if down button pressed AND not currently moving up

**Line 66:** `    ndx=0`
- Clears horizontal direction

**Line 67:** `    ndy=1`
- Sets next direction to down

**Line 68:** `  end`
- Ends input handling

**Line 69:** (Empty line)

**Line 70:** `  -- update movement`
- Comment for movement section

**Line 71:** `  timer+=1`
- Increments the frame counter

**Line 72:** `  if timer>=speed then`
- Checks if enough frames have passed to move the snake

**Line 73:** `    timer=0`
- Resets timer for next movement cycle

**Line 74:** (Empty line)

**Line 75:** `    -- update direction`
- Comment explaining direction update

**Line 76:** `    dx=ndx`
- Updates current horizontal direction from buffered direction

**Line 77:** `    dy=ndy`
- Updates current vertical direction from buffered direction

**Line 78:** (Empty line)

**Line 79:** `    -- get head position`
- Comment for head position calculation

**Line 80:** `    local head=snake[1]`
- Gets reference to the first segment (head) of the snake

**Line 81:** `    local newx=head.x+dx`
- Calculates new X position by adding direction

**Line 82:** `    local newy=head.y+dy`
- Calculates new Y position by adding direction

**Line 83:** (Empty line)

**Line 84:** `    -- check wall collision`
- Comment for boundary checking

**Line 85:** `    if newx<0 or newx>31 or`
- Checks if new X position is out of bounds (grid is 0-31)

**Line 86:** `       newy<0 or newy>31 then`
- Checks if new Y position is out of bounds

**Line 87:** `      gameover=true`
- Sets game over flag if snake hit a wall

**Line 88:** `      return`
- Exits _update() immediately

**Line 89:** `    end`
- Ends wall collision check

**Line 90:** (Empty line)

**Line 91:** `    -- check self collision`
- Comment for self-collision detection

**Line 92:** `    for i=1,#snake do`
- Loops through all snake segments

**Line 93:** `      if snake[i].x==newx and`
- Checks if segment's X matches new head X position

**Line 94:** `         snake[i].y==newy then`
- Checks if segment's Y matches new head Y position

**Line 95:** `        gameover=true`
- Sets game over flag if snake hit itself

**Line 96:** `        return`
- Exits _update() immediately

**Line 97:** `      end`
- Ends collision check for this segment

**Line 98:** `    end`
- Ends loop through snake segments

**Line 99:** (Empty line)

**Line 100:** `    -- create new head`
- Comment for new head creation

**Line 101:** `    local newhead={x=newx,y=newy}`
- Creates new segment table at calculated position

**Line 102:** (Empty line)

**Line 103:** `    -- check food collision`
- Comment for food collision detection

**Line 104:** `    if newx==food.x and`
- Checks if new head X matches food X

**Line 105:** `       newy==food.y then`
- Checks if new head Y matches food Y

**Line 106:** `      -- grow snake`
- Comment explaining growth behavior

**Line 107:** `      add(snake,newhead,1)`
- Adds new head to position 1 in snake table (beginning), snake grows by 1 segment

**Line 108:** `      score+=10`
- Increases score by 10 points

**Line 109:** (Empty line)

**Line 110:** `      -- spawn ny mad direkte her!`
- Danish comment: "spawn new food directly here!" - indicates inline food spawning (no function)

**Line 111:** `      local validpos=false`
- Flag to track if food position is valid (not on snake)

**Line 112:** `      local tries=0`
- Counter to prevent infinite loops

**Line 113:** (Empty line)

**Line 114:** `      while not validpos and tries<100 do`
- Loops until valid position found or 100 attempts made

**Line 115:** `        food.x=flr(rnd(32))`
- Generates random X coordinate (0-31) using floor of random

**Line 116:** `        food.y=flr(rnd(32))`
- Generates random Y coordinate (0-31)

**Line 117:** (Empty line)

**Line 118:** `        validpos=true`
- Assumes position is valid initially

**Line 119:** `        for i=1,#snake do`
- Loops through all snake segments to check overlap

**Line 120:** `          if snake[i].x==food.x and`
- Checks if segment X matches food X

**Line 121:** `             snake[i].y==food.y then`
- Checks if segment Y matches food Y

**Line 122:** `            validpos=false`
- Marks position as invalid if food overlaps snake

**Line 123:** `            break`
- Exits inner loop early

**Line 124:** `          end`
- Ends segment collision check

**Line 125:** `        end`
- Ends loop through snake segments

**Line 126:** (Empty line)

**Line 127:** `        tries+=1`
- Increments attempt counter

**Line 128:** `      end`
- Ends while loop for food spawning

**Line 129:** (Empty line)

**Line 130:** `      -- speed up slightly`
- Comment for difficulty increase

**Line 131:** `      speed=max(3,speed-0.2)`
- Decreases speed value (making snake faster), minimum of 3 frames

**Line 132:** `    else`
- If food was NOT eaten

**Line 133:** `      -- move snake`
- Comment for normal movement

**Line 134:** `      add(snake,newhead,1)`
- Adds new head to beginning of snake

**Line 135:** `      del(snake,snake[#snake])`
- Removes last segment (tail), keeping snake same length

**Line 136:** `    end`
- Ends food collision check

**Line 137:** `  end`
- Ends movement timer check

**Line 138:** (Empty line)

**Line 139:** `  -- tegn også her i _update!`
- Danish comment: "also draw here in _update!" - highlighting the bad practice

**Line 140:** `  cls(1)`
- Clears screen with color 1 (dark blue) - DRAWING in _update (bad!)

**Line 141:** (Empty line)

**Line 142:** `  -- draw border`
- Comment for border drawing

**Line 143:** `  rect(0,0,127,127,5)`
- Draws rectangle outline from (0,0) to (127,127) in color 5 (gray) - DRAWING in _update!

**Line 144:** (Empty line)

**Line 145:** `  -- draw food`
- Comment for food rendering

**Line 146-151:** `  rectfill(`
- Draws filled rectangle for food - DRAWING in _update (bad practice!)

**Line 147:** `    food.x*4,`
- Food X position multiplied by 4 (converts grid to pixel coordinates)

**Line 148:** `    food.y*4,`
- Food Y position multiplied by 4

**Line 149:** `    food.x*4+3,`
- Bottom-right X (4 pixels wide)

**Line 150:** `    food.y*4+3,`
- Bottom-right Y (4 pixels tall)

**Line 151:** `    8`
- Color 8 (red) with closing parenthesis

**Line 152:** `  )`
- Closes rectfill function call

**Line 153:** (Empty line)

**Line 154:** `  -- draw score og length her`
- Danish comment: "draw score and length here" - more drawing in _update!

**Line 155:** `  print("score:"..score,2,2,7)`
- Prints score at position (2, 2) in color 7 - DRAWING in _update!

**Line 156:** `  print("length:"..#snake,2,8,7)`
- Prints snake length at position (2, 8) in color 7 - DRAWING in _update!

**Line 157:** `end`
- Ends the _update() function

**Line 158:** (Empty line)

## Lines 159-178: _draw() Function - Partial Drawing
**Line 159:** `function _draw()`
- Defines the draw function (should contain ALL rendering, but doesn't in this bad structure)

**Line 160:** `  -- mere tegning her også`
- Danish comment: "more drawing here too" - acknowledges split rendering

**Line 161:** `  if not gameover then`
- Only draws snake when game is NOT over

**Line 162:** `    -- draw snake`
- Comment for snake rendering

**Line 163:** `    for i=1,#snake do`
- Loops through all snake segments

**Line 164:** `      local s=snake[i]`
- Gets reference to current segment

**Line 165:** `      local col=11`
- Default color 11 (light green) for body segments

**Line 166:** `      if i==1 then`
- Checks if this is the first segment (head)

**Line 167:** `        col=3`
- Changes color to 3 (dark green) for head

**Line 168:** `      end`
- Ends head color check

**Line 169-175:** `      rectfill(`
- Draws filled rectangle for snake segment

**Line 170:** `        s.x*4,`
- Segment X * 4 (grid to pixel)

**Line 171:** `        s.y*4,`
- Segment Y * 4

**Line 172:** `        s.x*4+3,`
- Bottom-right X (4x4 pixels)

**Line 173:** `        s.y*4+3,`
- Bottom-right Y

**Line 174:** `        col`
- Uses calculated color

**Line 175:** `      )`
- Closes rectfill

**Line 176:** `    end`
- Ends loop through snake segments

**Line 177:** `  end`
- Ends game-active check

**Line 178:** `end`
- Ends _draw() function

**Line 179:** (Empty line)

## Lines 180-183: Graphics and Map Sections
**Line 180:** `__gfx__`
- Marker for graphics/sprite data section (empty in this cart)

**Line 181:** `00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000`
- Empty sprite data (all zeros = transparent)

**Line 182:** `__map__`
- Marker for map data section (unused in this cart)

**Line 183:** (Empty line)

---

## Summary of Bad Practices in This Code:

1. **Drawing in _update()**: Lines 32-37, 140, 143, 146-156 all perform rendering in _update() instead of _draw()
2. **Code Duplication**: Lines 41-50 duplicate the initialization code from lines 7-26
3. **No Separation of Concerns**: Game logic, rendering, and input handling all mixed together
4. **Inline Food Spawning**: Lines 111-128 could be extracted into a separate function
5. **No Reusable Functions**: Everything is hardcoded in the main game loop
6. **Magic Numbers**: Values like 4 (pixel size), 32 (grid size), 8 (color) scattered throughout without named constants

