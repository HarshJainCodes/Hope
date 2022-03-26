storyState = Class{__includes = BaseState}

function storyState:render()
  love.graphics.printf("In the year 2040 humanity was united and yet was at its wits end, the environment on earth was becoming unstable and finding an outerworldly solution was the only remaining hope. Project HOPE was launched to find a distantly observerd element which was the key to our problems 'eternium'. ",300,100,700,'center')
  love.graphics.printf("Press space to continue",500,600,300,'center')
end

function storyState:key_pressed(key)
  if(key=="space")then
    gStateMachine:change("play")
  end
end
