EndState = Class{__includes = BaseState}

function EndState:init()

end 

function EndState:update(dt)

end

function EndState:render()
	love.graphics.printf('hello end state', 0, 10, VIRTUAL_WIDTH, 'center')
end
