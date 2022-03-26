PlayState = Class{__includes = BaseState}

-- crystal={x=0,y=0,proxy_radius=800}
proxy_radius = 800


function PlayState:init()

game_music:play()
    self.particlex1 = 0
    self.particley1 = 0
    self.particley1 = 0
    self.particley2 = 0



    self.img = love.graphics.newImage('logo.png')

    self.psystem = love.graphics.newParticleSystem(self.img)

    self.psystem:setColors(255, 255, 255, 255, 255, 255, 255, 0)

    self.psystem:setParticleLifetime(0.2, 0.6)

    self.gem = false
    destroyAll()
    --self.background = love.graphics.newImage('charter yatch.png')
    self.white = love.graphics.newImage('white.png')
    map_spawn(current_level)

    self.player = {}
    self.player.x = 0
    self.player.y = 0
    self.player.width = 266
    self.player.height = 100
    self.player.isgrounded=false


--------------------------------------------------player world interaction manipulation
    self.player = world:newRectangleCollider(self.player.x, self.player.y, self.player.width, self.player.height)
    self.player:setCollisionClass('Player')
    self.player:setRestitution(0.1)
    self.player:setFriction(0.2)
    self.player:setFixedRotation(true)
---------------------------------------------------------------------temporary player platform
    -- self.platform1 = world:newRectangleCollider(0, 500, WINDOW_WIDTH, WINDOW_HEIGHT)
    -- self.platform1:setType('static')
----------------------------------------------------------------------------boost bar
    -- self.boostBar = {}
    -- self.boostBar.x = 100
    -- self.boostBar.y = 100
    -- self.boostBar.maxHp = 1000
    -- self.boostBar.currentHp = 600
    self.boostBar = {}
    self.boostBar.max = 100
    self.boostBar.current = 100
    self.boostBar.drain=10
    self.boostBar.isPossible=true
    self.boostBar.rechargeRate=5
    --self.isBoostAvailable = true
------------------------------------------------------------------------------------camera attach
    self.cameraFile = require 'libraries/hump/camera'
    self.cam = self.cameraFile()

    self.zoom_out = false
    ---------------------------------------------------------------------------------objectives
    self.objectives={"Find the Crystal","Locate the portal"}
    self.show_objective = true
    self.index_objective = 1

    --load the sprites
    self.idle_img = love.graphics.newImage('sprites/break.png')
    self.forward_img = love.graphics.newImage('sprites/forward.png')
    self.fly_img = love.graphics.newImage('sprites/fly.png')
    self.portal_img = love.graphics.newImage('sprites/portal.png')

    self.still_portal = love.graphics.newImage('sprites/still_portal.png')

    -- grid for those images
    --self.rover_grid = anim8.newGrid(1320, 495, self.rover_img:getWidth(), self.rover_img:getHeight())
    self.idle_grid = anim8.newGrid(660, 248, self.idle_img:getWidth(), self.idle_img:getHeight())
    self.forward_grid = anim8.newGrid(660, 248, self.forward_img:getWidth(), self.forward_img:getHeight())
    self.fly_grid = anim8.newGrid(660, 248, self.fly_img:getWidth(), self.fly_img:getHeight())
    self.portal_grid = anim8.newGrid(431, 290, self.portal_img:getWidth(), self.portal_img:getHeight())


    --animations
    self.animations = {}
    --self.animations.rover = anim8.newAnimation(self.rover_grid('1-24', 1), 0.8)
    self.animations.idle = anim8.newAnimation(self.idle_grid('1-24', 1), 0.016)
    self.animations.forward = anim8.newAnimation(self.forward_grid('2-14', 1), 0.016)
    self.animations.fly = anim8.newAnimation(self.fly_grid('1-14', 1), 0.08)
    self.animations.portal = anim8.newAnimation(self.portal_grid('1-60', 1), 0.016)

    -- self.current_portal_anim = self.animations.portal

    self.cam:zoom(1)
    --self.animations.boost = anim8.newAnimation(grid())

    self.currentAnimation = self.animations.fly
    self.current_image = self.fly_img

    self.last_frame = anim8.newAnimation(self.fly_grid('14-14', 1), 1)
    self.isFlying = false
    self.start_timer = false
    self.direction = 1

end





function PlayState:enter()

end
local test = 1.001
function camZoom(camera, zoom)

    camera:zoom(zoom)
    test=test*1.00001
    print(test)
end



function resetCam(camera, zoom)
    camera:zoomTo(zoom)
   -- test=test*1.001
end

local timer = 0

function PlayState:update(dt)

    self.psystem:update(1 * dt)

    timer = timer + dt

    if timer > 1.12 then
      self.isFlying = true
      self.start_timer = false

    end

    --if test<1.002 and self.player:getX()>500 then
    --    camZoom(self.cam,test)
    --end
    self.psystem:setLinearAcceleration(self.particlex1, self.particley1, self.particlex2, self.particley2)
    self.psystem:emit(30)

    if Keyboard_was_Pressed('space') == false then
        self.particlex1 = 0
        self.particley1 = 0
        self.particley1 = 0
        self.particley2 = 0
    end


    if(self.player.body)then
        local px, py = self.player:getPosition()
        collider= world:queryRectangleArea(px+5 - 266/2,py-50 + 100,250,1,{'Platforms'})
        if(#collider>0)then
           self.isFlying=false
            self.player.isgrounded=true
            self.currentAnimation=self.animations.forward
            self.current_image=self.last_frame
        else
          self.isFlying = true
          self.player.isgrounded=false
          self.currentAnimation=self.animations.fly
          self.current_image=self.fly_img
        end

        if(self.player:enter('Crystal'))then
            for k,v in pairs(crystal)do
              v:destroy()
            end
            crystal={}
            self.gem=true
            self.index_objective = self.index_objective + 1
            heartbeat:stop()
          end

        --   if(self.gem==true)then
        --     if(self.player:enter('Portal'))then
        --       ender()
        --     end
        -- end
        ---local colliders=world:queryRectangleArea(self.player.x+5,self.player.y+self.player.height,self.player.width-10,2,{Platforms})
        ---------------------------------------------------------------------------player movement
        if love.keyboard.isDown('right') or love.keyboard.isDown('d')then
            --self.currentAnimation = self.animations.forward
            --self.current_image = self.forward_img
            -- self.particlex1 = 0
            -- self.particley1 = 400
            -- self.particlex2 = 50
            -- self.particley2 = 400

            self.psystem:emit(30)
            self.direction = 1

            self.player:applyLinearImpulse(4000*dt, 0)
        end
        if love.keyboard.isDown('left') or  love.keyboard.isDown("a") then
            self.player:applyLinearImpulse(-4000*dt, 0)
            --self.currentAnimation = self.animations.forward
            --self.current_image = self.forward_img
            self.direction = 1

        end
        ----if love.keyboard.isDown('space') then
        --    self.player:applyLinearImpulse(0, -50)
        --end

        -- if self.isBoostAvailable and love.keyboard.isDown('b') then
        --     self.player:applyLinearImpulse(0, -10)
        -- end
        if(love.keyboard.isDown("space") and self.boostBar.current>0 )then
            -- self.particlex1 = -50
            -- self.particley1 = 400
            -- self.particlex2 = 50
            -- self.particley2 = 400

            self.boostBar.current=math.max(self.boostBar.current-self.boostBar.drain*dt,0)
            self.player:applyLinearImpulse(0, -20000*dt)
            self.boostBar.isPossible=self.boostBar.current==0 and false or true
            self.currentAnimation = self.animations.fly
            self.current_image = self.fly_img
            --self.psystem:setLinearAcceleration(-50, 400, 50, 400)
            --.psystem:setLinearAcceleration(self.particlex1, self.particley1, self.particlex2, self.particley2)
            --self.psystem:emit(30)
            -- timer = timer + dt
            -- if timer > 1.12 then
            --     self.isFlying = true
            --
            -- end
          else
            self.boostBar.current=math.min(self.boostBar.current+self.boostBar.rechargeRate*dt,self.boostBar.max)
          end

        ------------------------------------------------------------------------------------camera
        local px, py = self.player:getPosition()
        self.cam:lookAt(px + 400, py + 120)
        if current_level == 'level1' then
            self.cam.x = math.min(3840 - 64 * 9 + 20, self.cam.x)
            self.cam.x = math.max(self.cam.x, 780)
            self.cam.y = math.max(self.cam.y, 0)
            self.cam.y = math.min(self.cam.y, 3840 - 64 * 17)
        elseif current_level == 'level2' or current_level == 'level3' then
          self.cam.x = math.min(7680 - 128 * 4 - 20, self.cam.x)
          self.cam.x = math.max(self.cam.x, 800)
          self.cam.y = math.max(self.cam.y, 450)
          self.cam.y = math.min(self.cam.y, 7680 - 128 * 11 - 400)
        end


        if self.player.isgrounded then
            -- self.isFlying = false
            self.currentAnimation = self.animations.forward
            self.current_image = self.forward_img
        else
            self.particlex1 = -50
            self.particley1 = 400
            self.particlex2 = 50
            self.particley2 = 400
        end
        ------------------------------------------------------------------------------------sound proximity
        -- local mouse_x=love.mouse.getX()
        -- local mouse_y=love.mouse.getY()
        --  proxy=math.sqrt((math.pow(mouse_x-crystal.x,2))+(math.pow(mouse_y-crystal.y,2)))


        -- if(proxy<crystal.proxy_radius)then
        --   heartbeat:setVolume(math.min(0.2*crystal.proxy_radius/proxy,1))
        --   heartbeat:play()
        -- else
        --   heartbeat:stop()
        -- end

        for k,v in pairs(crystal)do
            local proxy=math.sqrt((math.pow(px-v:getX(),2))+(math.pow(py-v:getY(),2)))
            if(proxy<proxy_radius)then
               heartbeat:setVolume(math.min(0.3*proxy_radius/proxy,1))
               heartbeat:play()
            else
               heartbeat:stop()
            end
        end


        if self.isFlying then

            self.last_frame:update(dt)
        else
            self.currentAnimation:update(dt)

        end

        --- update the portal animations
    self.animations.portal:update(dt)
    if(self.gem==true)then
      if(self.player:enter('Portal'))then
        ender()
      end
    end
  end

end

function PlayState:render()


    self.cam:attach()


    --love.graphics.draw(self.background, 0, 0, 0,WINDOW_WIDTH/self.background:getWidth(), WINDOW_HEIGHT/self.background:getHeight())
    --love.graphics.draw(self.white, 0, 0, 0, WINDOW_WIDTH/self.white:getWidth(), WINDOW_HEIGHT/self.white:getHeight())
    gameMap:drawLayer(gameMap.layers["BG"])
    if(current_level=="level1")then
      love.graphics.printf("Use a,d or left arrow key,right arrow key to move and space bar to use booster",100,600,600,'center')
    end

    -- if self.gem then
    --   self.animations.portal:draw(self.portal_img, portal[1]:getX(), portal[1]:getY(), 0, 1, 1, 256/2 + 60, 256/2 + 20)
    -- else
    --   love.graphics.setColor(0, 0, 0)
    --   love.graphics.draw(self.still_portal, portal[1]:getX(), portal[1]:getY(), 0, 1, 1, 256/2 + 60, 256/2 + 20)
    --   love.graphics.setColor(1, 1, 1)
    -- end


    gameMap:drawLayer(gameMap.layers["Tile Layer 2"])
    if(self.gem==false)then
      gameMap:drawLayer(gameMap.layers["gem_layer"])
    end
    --love.graphics.setColor(1,1,1)
    if(current_level=="level1" and self.gem)then
      love.graphics.setColor(1, 1, 1)
      self.animations.portal:draw(self.portal_img, portal[1]:getX(), portal[1]:getY(), 0, 1, 1, 256/2 + 60, 256/2 + 20)
    else
      love.graphics.setColor(0, 0, 0)
      love.graphics.draw(self.still_portal, portal[1]:getX(), portal[1]:getY(), 0, 1, 1, 256/2 + 60, 256/2 + 20)
      love.graphics.setColor(1, 1, 1)
    end
    if(current_level=="level2" and self.gem)then
     love.graphics.setColor(1, 1, 1)
      self.animations.portal:draw(self.portal_img, portal[1]:getX(), portal[1]:getY(), 0, 1, 1, 256/2 + 60, 256/2 + 20)
    else
      love.graphics.setColor(0, 0, 0)
      love.graphics.draw(self.still_portal, portal[1]:getX(), portal[1]:getY(), 0, 1, 1, 256/2 + 60, 256/2 + 20)
      love.graphics.setColor(1, 1, 1)
    end
    if(current_level=="level3" and self.gem)then
      self.animations.portal:draw(self.portal_img, portal[1]:getX(), portal[1]:getY(), 0, 1, 1, 256/2 + 60, 256/2 + 20)
    else
      love.graphics.setColor(0, 0, 0)
      love.graphics.draw(self.still_portal, portal[1]:getX(), portal[1]:getY(), 0, 1, 1, 256/2 + 60, 256/2 + 20)
      love.graphics.setColor(1, 1, 1)
    end

    -- love.graphics.printf("PlayState", 175, 10, 500, "center")
    -- love.graphics.rectangle("line", 225, 300, 300, 50)
    --love.graphics.printf("Victory State", 225, 300, 300, "center")
    --self.cam:detach()
    --love.graphics.rectangle("line", self.boostBar.x, self.boostBar.y, self.boostBar.width, self.boostBar.height)



      local x1, y1 = self.player:getPosition()
      if self.direction == 1 then
        love.graphics.draw(self.psystem, x1 + 20 - 120, y1 + 100 - 60)
        love.graphics.draw(self.psystem, x1 + 20 - 67, y1 + 100 - 60)
        love.graphics.draw(self.psystem, x1 + 20 - 18, y1 + 100 - 60)
        love.graphics.draw(self.psystem, x1 + 20 + 30, y1 + 100 - 60)
      else
        --love.graphics.draw(self.psystem, x1 + 20 - 120, y1 + 100 - 60)
        love.graphics.draw(self.psystem, x1 + 20 - 67, y1 + 100 - 60)
        love.graphics.draw(self.psystem, x1 + 20 - 18, y1 + 100 - 60)
        love.graphics.draw(self.psystem, x1 + 20 + 30, y1 + 100 - 60)
        love.graphics.draw(self.psystem, x1 + 20 + 80, y1 + 100 - 60 )
      end


      local px, py = self.player:getPosition()
      if self.isFlying and self.player.isgrounded == false then
          self.last_frame:draw(self.current_image, px, py, 0, self.direction * 266/660, 100/248, 266/2 + 190, 100/2 + 60)
      else
        self.currentAnimation:draw(self.current_image, px, py, 0, self.direction * 266/660, 100/248, 266/2+190, 100/2+60)

      end

        gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
       --world:draw()



    self.cam:detach()

    if self.show_objective then
      love.graphics.setFont(love.graphics.newFont(30))
      love.graphics.printf(self.objectives[self.index_objective], 0, 100, WINDOW_WIDTH, "left")
    end
    -- love.graphics.print(love.timer.getFPS())
    love.graphics.rectangle("line",500,100,104,14)
    love.graphics.rectangle("fill",502,102,self.boostBar.current,12)
end
--------------------------------------------------------------------------------
function PlayState:key_released(key)
    if key == "up" then
        self.zoom_out = false
    end
end
--------------------------------------------------------------------------------

function PlayState:mouse_pressed(x,y)
    if x > 300 and x < 550 and y > 300 and y < 350 then
        gStateMachine:change("victory")
    end
end

function PlayState:key_pressed(key)
end

function PlayState:exit()

end

function ender()
    --destroyAll()
    if(current_level=="level1")then
      current_level="level2"
      game_music:stop()
      --self.player.body:destroy()
      destroyAll()
        gStateMachine:change('play')
    elseif(current_level=="level2")then
      current_level="level3"
      destroyAll()
        gStateMachine:change('play')
    elseif(current_level=="level3")then
      destroyAll()
      gStateMachine:change("victory")
    end
end
