TitleScreenState = Class{__includes = BaseState}



function TitleScreenState:mouse_pressed(x,y)
  if(x> WINDOW_WIDTH/2 and x <  WINDOW_WIDTH/2 + 375 and y>400 and y<497)then
    gStateMachine:change('story')
  end
  -- if(x>WINDOW_WIDTH/2 - 125 and x< WINDOW_WIDTH/2 + 125 and y>400 and y<450)then
  --   gStateMachine:change('instruction')
  -- end
  if(x>WINDOW_WIDTH/2 and x<WINDOW_WIDTH/2 + 375 and y>580 and y<677)then
    love.event.quit()
  end
  -- if(x>200 and x<500 and y>500 and y<550)then
  --   gStateMachine:change('level select')
  -- end
end


function TitleScreenState:enter()

end

function TitleScreenState:init()
  self.ishover_play = false
  self.ishover_quit = false
  self.button_inactive = love.graphics.newImage('sprites/button_1.png')
  self.button_active = love.graphics.newImage('sprites/button_2.png')
  self.quit_inactive = love.graphics.newImage('sprites/button_3.png')
  self.quit_active = love.graphics.newImage('sprites/button_4.png')
  self.menu_bg = love.graphics.newImage('sprites/menu_bg.jpg')

  self.hpe = love.graphics.newImage('sprites/hpe.png')
  self.o = love.graphics.newImage('sprites/o.png')

  self.o_rotate = 0
  self.t = 0
end

function TitleScreenState:update(dt)
  self.t = self.t + dt

  local m1, m2 = love.mouse.getPosition()
  mx, my = push:toGame(m1, m2)
  if mx > WINDOW_WIDTH/2 and mx < WINDOW_WIDTH/2 + 375 and my >380 and my < 477 then
    self.ishover_play = true
  else
    self.ishover_play = false
  end
  if mx > WINDOW_WIDTH/2 and mx < WINDOW_WIDTH/2 + 375 and my > 580 and my < 667 then
    self.ishover_quit = true
  else
    self.ishover_quit = false
  end

  self.o_rotate = self.o_rotate + dt
end

function TitleScreenState:render()
  --love.graphics.clear(0,0,0)
    --love.graphics.printf("TitleScreenState",0,10,WINDOW_WIDTH,"center")
    -- love.graphics.rectangle("line",WINDOW_WIDTH/2 ,400,375,50)
    -- love.graphics.printf("play",WINDOW_WIDTH/2,400, 375,"center")
    --love.graphics.rectangle("line",WINDOW_WIDTH/2 - 125,400,250,50)
    --love.graphics.printf("instructions",WINDOW_WIDTH/2 - 125,400,250,"center")
    --love.graphics.rectangle("line",200,500,300,50)
    --love.graphics.printf("level select",200,500,300,"center")
    -- love.graphics.rectangle("line",WINDOW_WIDTH/2 - 50,500,100,50)
    -- love.graphics.printf("exit",WINDOW_WIDTH/2 - 50,500,100,"center")
    love.graphics.draw(self.menu_bg, 0, 0, 0, WINDOW_WIDTH/self.menu_bg:getWidth(), WINDOW_HEIGHT/self.menu_bg:getHeight())
    love.graphics.draw(self.hpe, WINDOW_WIDTH/2, 100, 0, 580/self.hpe:getWidth(), 1)
    love.graphics.draw(self.o, WINDOW_WIDTH/2 + 233, 190, self.t, 1, 1, self.o:getWidth()/2, self.o:getHeight()/2)

    if not self.ishover_play then
      love.graphics.draw(self.button_inactive, WINDOW_WIDTH/2, 380, 0, 375/self.button_inactive:getWidth(), 97/self.button_inactive:getHeight())
    else
      love.graphics.draw(self.button_active, WINDOW_WIDTH/2, 380, 0, 375/self.button_inactive:getWidth(), 97/self.button_inactive:getHeight())
    end

    if not self.ishover_quit then
      love.graphics.draw(self.quit_active, WINDOW_WIDTH/2, 580, 0, 375/self.quit_inactive:getWidth(), 97/self.quit_inactive:getHeight())
    else
      love.graphics.draw(self.quit_inactive, WINDOW_WIDTH/2, 580, 0, 375/self.quit_inactive:getWidth(), 97/self.quit_inactive:getHeight())
    end
end

function TitleScreenState:exit()

end
