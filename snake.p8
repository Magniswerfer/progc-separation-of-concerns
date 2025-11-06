pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- snake game
-- by cursor ai

function _init()
  init_game()
end

function init_game()
  -- snake body segments
  snake={{x=8,y=8}}
  
  -- direction
  dx=1
  dy=0
  
  -- next direction buffer
  ndx=1
  ndy=0
  
  -- food position
  food={x=16,y=16}
  
  -- game state
  score=0
  gameover=false
  
  -- movement timer
  timer=0
  speed=8 -- frames between moves
end

function _update()
  if gameover then
    if btnp(4) or btnp(5) then
      init_game()
    end
    return
  end
  
  -- input handling
  if btnp(0) and dx!=1 then
    ndx=-1
    ndy=0
  elseif btnp(1) and dx!=-1 then
    ndx=1
    ndy=0
  elseif btnp(2) and dy!=1 then
    ndx=0
    ndy=-1
  elseif btnp(3) and dy!=-1 then
    ndx=0
    ndy=1
  end
  
  -- update movement
  timer+=1
  if timer>=speed then
    timer=0
    
    -- update direction
    dx=ndx
    dy=ndy
    
    -- get head position
    local head=snake[1]
    local newx=head.x+dx
    local newy=head.y+dy
    
    -- check wall collision
    if newx<0 or newx>31 or
       newy<0 or newy>31 then
      gameover=true
      return
    end
    
    -- check self collision
    for i=1,#snake do
      if snake[i].x==newx and
         snake[i].y==newy then
        gameover=true
        return
      end
    end
    
    -- create new head
    local newhead={x=newx,y=newy}
    
    -- check food collision
    if newx==food.x and
       newy==food.y then
      -- grow snake
      add(snake,newhead,1)
      score+=10
      spawn_food()
      -- speed up slightly
      speed=max(3,speed-0.2)
    else
      -- move snake
      add(snake,newhead,1)
      del(snake,snake[#snake])
    end
  end
end

function _draw()
  cls(1) -- dark blue bg
  
  if gameover then
    draw_gameover()
    return
  end
  
  -- draw grid
  draw_grid()
  
  -- draw food
  rectfill(
    food.x*4,
    food.y*4,
    food.x*4+3,
    food.y*4+3,
    8 -- red
  )
  
  -- draw snake
  for i=1,#snake do
    local s=snake[i]
    local col=11 -- green
    if i==1 then
      col=3 -- darker green head
    end
    rectfill(
      s.x*4,
      s.y*4,
      s.x*4+3,
      s.y*4+3,
      col
    )
  end
  
  -- draw score
  print("score:"..score,2,2,7)
  
  -- draw length
  print("length:"..#snake,2,8,7)
end

function draw_grid()
  -- draw border
  rect(0,0,127,127,5)
end

function draw_gameover()
  cls(0)
  print("game over!",38,50,8)
  print("score:"..score,42,58,7)
  print("length:"..#snake,38,66,7)
  print("press ❎ or 🅾️",30,80,6)
  print("to restart",38,88,6)
end

function spawn_food()
  local validpos=false
  local tries=0
  
  while not validpos and tries<100 do
    food.x=flr(rnd(32))
    food.y=flr(rnd(32))
    
    validpos=true
    for i=1,#snake do
      if snake[i].x==food.x and
         snake[i].y==food.y then
        validpos=false
        break
      end
    end
    
    tries+=1
  end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
