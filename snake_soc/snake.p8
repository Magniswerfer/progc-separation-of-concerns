pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

-- ==================
-- data structures
-- ==================

snake_state={
  body={},
  dx=0,
  dy=0,
  next_dx=0,
  next_dy=0
}

game_state={
  score=0,
  gameover=false,
  timer=0,
  speed=8
}

food={x=0,y=0}

-- ==================
-- initialization
-- ==================

function _init()
  reset_game()
end

function reset_game()
  snake_state.body={{x=8,y=8}}
  snake_state.dx=1
  snake_state.dy=0
  snake_state.next_dx=1
  snake_state.next_dy=0
  
  food.x=16
  food.y=16
  
  game_state.score=0
  game_state.gameover=false
  game_state.timer=0
  game_state.speed=8
end

-- ==================
-- game logic
-- ==================

function _update()
  if game_state.gameover then
    handle_restart_input()
    return
  end
  
  handle_input()
  update_game_timer()
end

function handle_restart_input()
  if btnp(4) or btnp(5) then
    reset_game()
  end
end

function handle_input()
  if btnp(0) and snake_state.dx!=1 then
    snake_state.next_dx=-1
    snake_state.next_dy=0
  elseif btnp(1) and snake_state.dx!=-1 then
    snake_state.next_dx=1
    snake_state.next_dy=0
  elseif btnp(2) and snake_state.dy!=1 then
    snake_state.next_dx=0
    snake_state.next_dy=-1
  elseif btnp(3) and snake_state.dy!=-1 then
    snake_state.next_dx=0
    snake_state.next_dy=1
  end
end

function update_game_timer()
  game_state.timer+=1
  if game_state.timer>=game_state.speed then
    game_state.timer=0
    update_snake_movement()
  end
end

function update_snake_movement()
  -- update direction
  snake_state.dx=snake_state.next_dx
  snake_state.dy=snake_state.next_dy
  
  -- calculate new head position
  local head=snake_state.body[1]
  local newx=head.x+snake_state.dx
  local newy=head.y+snake_state.dy
  
  -- check collisions
  if check_wall_collision(newx,newy) or
     check_self_collision(newx,newy) then
    game_state.gameover=true
    return
  end
  
  -- create new head
  local newhead={x=newx,y=newy}
  
  -- check food collision
  if check_food_collision(newx,newy) then
    grow_snake(newhead)
    spawn_food()
    increase_speed()
  else
    move_snake(newhead)
  end
end

-- ==================
-- collision detection
-- ==================

function check_wall_collision(x,y)
  return x<0 or x>31 or
         y<0 or y>31
end

function check_self_collision(x,y)
  for i=1,#snake_state.body do
    if snake_state.body[i].x==x and
       snake_state.body[i].y==y then
      return true
    end
  end
  return false
end

function check_food_collision(x,y)
  return x==food.x and y==food.y
end

-- ==================
-- snake movement
-- ==================

function move_snake(newhead)
  add(snake_state.body,newhead,1)
  del(snake_state.body,
      snake_state.body[#snake_state.body])
end

function grow_snake(newhead)
  add(snake_state.body,newhead,1)
  game_state.score+=10
end

-- ==================
-- food management
-- ==================

function spawn_food()
  local validpos=false
  local tries=0
  
  while not validpos and tries<100 do
    food.x=flr(rnd(32))
    food.y=flr(rnd(32))
    
    validpos=true
    for i=1,#snake_state.body do
      if snake_state.body[i].x==food.x and
         snake_state.body[i].y==food.y then
        validpos=false
        break
      end
    end
    
    tries+=1
  end
end

function increase_speed()
  game_state.speed=max(3,game_state.speed-0.2)
end

-- ==================
-- rendering
-- ==================

function _draw()
  cls(1)
  
  if game_state.gameover then
    draw_game_over()
  else
    draw_game()
  end
end

function draw_game()
  draw_border()
  draw_food()
  draw_snake()
  draw_ui()
end

function draw_border()
  rect(0,0,127,127,5)
end

function draw_food()
  rectfill(
    food.x*4,
    food.y*4,
    food.x*4+3,
    food.y*4+3,
    8
  )
end

function draw_snake()
  for i=1,#snake_state.body do
    local s=snake_state.body[i]
    local col=11
    if i==1 then
      col=3
    end
    rectfill(
      s.x*4,
      s.y*4,
      s.x*4+3,
      s.y*4+3,
      col
    )
  end
end

function draw_ui()
  print("score:"..game_state.score,2,2,7)
  print("length:"..#snake_state.body,2,8,7)
end

function draw_game_over()
  cls(0)
  print("game over!",38,50,8)
  print("score:"..game_state.score,42,58,7)
  print("length:"..#snake_state.body,38,66,7)
  print("press ❎ or 🅾️",30,80,6)
  print("to restart",38,88,6)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
