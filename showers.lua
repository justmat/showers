-- a thunderstorm
--         for norns
-- ----------
--
-- enc1 = vol
--
-- v1 @justmat
--

engine.name = "Showers"


function init()

  params:add_separator()

  params:add {
    type = 'control',
    id = 'rain',
    name = 'rain',
    controlspec = controlspec.new(0, 1, "lin", 0.01, 0.3),
    action = function(v) engine.rain(v) end
    }

  params:add {
    type = 'control',
    id = 'thunder',
    name = 'thunder',
    controlspec = controlspec.new(0, 1, "lin", 0.01, 0.5),
    action = function(v) engine.thunder(v) end
    }

  local count = 1
  -- screen metro
  screen_timer = metro.init()
  screen_timer.time = 1/15
  screen_timer.stage = 1
  screen_timer.event = function()
    count = count + 1
    redraw(count % 4)
  end
  screen_timer:start()
end


function enc(n, d)
  if n == 1 then
    --volume
    params:delta("output_level", d)
  elseif n == 2 then
    params:delta("rain", d)
  elseif n == 3 then
    params:delta("thunder", d)
  end
end


local function draw_cloud()
  screen.level(10)
  screen.circle(44, 30, 13)
  screen.fill()
  screen.circle(65, 26, 18)
  screen.fill()
  screen.circle(80, 30, 14)
  screen.fill()
  screen.level(0)
  screen.arc(80, 30, 14, -2, -1)
  screen.move(66, 47)
  screen.arc(65, 26, 18, 1, 2.7)
  screen.stroke()
end


local function draw_rain(n)
  if n then n = n + 1 end
  if n == 1 then
    screen.move(32, 62)
    screen.line_rel(-3, 6)
    screen.move(80, 58)
    screen.line_rel(-2, 4)
    
    screen.move(44, 45)
    screen.line_rel(-5, 10)
    screen.move(80, 48)
    screen.line_rel(-5, 10)
  elseif n == 2 then
    screen.move(34, 56)
    screen.line_rel(-2, 4)
    screen.move(80, 58)
    screen.line_rel(-2, 4)

    screen.move(42, 58)
    screen.line_rel(-5, 10)
    screen.move(64, 46)
    screen.line_rel(-5, 10)
    screen.move(78, 52)
    screen.line_rel(-5, 10)
  elseif n == 3 then
    screen.move(36, 50)
    screen.line_rel(-2, 4)
    screen.move(83, 48)
    screen.line_rel(-2, 4)
    
    screen.move(40, 55)
    screen.line_rel(-5, 10)
    screen.move(60, 57)
    screen.line_rel(-5, 10)
    screen.move(76, 55)
    screen.line_rel(-5, 10)
  elseif n == 4 then
    screen.move(54, 45)
    screen.line_rel(-2, 4)
    screen.move(70, 48)
    screen.line_rel(-2, 4)
    
    screen.move(38, 60)
    screen.line_rel(-5, 10)
    screen.move(58, 62)
    screen.line_rel(-5, 10)
    screen.move(74, 59)
    screen.line_rel(-5, 10)
  end
end


function redraw(count)
  screen.clear()
  screen.aa(1)

  draw_cloud()
  screen.level(math.random(2, 10))
  draw_rain(count)

  screen.stroke()
  screen.update()
end
