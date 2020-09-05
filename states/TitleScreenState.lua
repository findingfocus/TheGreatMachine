TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()

end

function TitleScreenState:update(dt)

end

function TitleScreenState:render()
	love.graphics.setFont(largeFont)
	love.graphics.printf('The Great Machine', 0, 25, VIRTUAL_WIDTH, 'center')
	love.graphics.setFont(mediumFont)
	love.graphics.printf('press "enter" to begin', 0, 90, VIRTUAL_WIDTH, 'center')
end