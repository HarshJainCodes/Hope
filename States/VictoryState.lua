VictoryState = Class{__includes = BaseState}


function VictoryState:enter()

end

function VictoryState:mouse_pressed(x, y)
    if x > WINDOW_WIDTH/2-150 and x < WINDOW_WIDTH/2+150 and y > 500 and y < 550 then
        gStateMachine:change('title')
    end
    if x > WINDOW_WIDTH/2-50 and x < WINDOW_WIDTH/2+50 and y > 600 and y < 650 then
        love.event.quit()
    end

end


function VictoryState:init()
self.menu_bg = love.graphics.newImage('sprites/menu_bg.jpg')
end


function VictoryState:update(dt)

end

function VictoryState:render()
    love.graphics.draw(self.menu_bg, 0, 0, 0, WINDOW_WIDTH/self.menu_bg:getWidth(), WINDOW_HEIGHT/self.menu_bg:getHeight())
    --love.graphics.printf("Victory State",WINDOW_WIDTH/2-250, 10, 500, "center")
    love.graphics.printf("This game was made by Harsh Jain,Chinmay Surve,Apurv Henkare,Prajwal Pawar and Malhar Choure",WINDOW_WIDTH/2-500,200,1000,"center")
    love.graphics.rectangle("line", WINDOW_WIDTH/2-150, 500, 300, 50)
    love.graphics.printf("main menu", WINDOW_WIDTH/2-150, 500, 300, "center")
    love.graphics.rectangle("line", WINDOW_WIDTH/2-50, 600, 100, 50)
    love.graphics.printf("exit", WINDOW_WIDTH/2-50, 600, 100, "center")

end

function VictoryState:exit()

end
