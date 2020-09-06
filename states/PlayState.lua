PlayState = Class{__includes = BaseState}

function PlayState:init()

end

function PlayState:update(dt)
	machine:update(dt)
end

function PlayState:render()
	love.graphics.printf('hello play state', 0, 10, VIRTUAL_WIDTH, 'center')
	machine:render()
end