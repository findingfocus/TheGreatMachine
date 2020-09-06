EndState = Class{__includes = BaseState}

function EndState:init()

end 

function EndState:update(dt)
	ideaList = {}
	if love.keyboard.wasPressed('r') then
		pointCounter = 0
		gStateMachine:change('playState')
	end

end

function EndState:render()
	love.graphics.setFont(endFont)
	love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
	love.graphics.printf('Congratulations! You converted ideas into a real project!', 0, 70, VIRTUAL_WIDTH, 'center')
	love.graphics.printf('Keep up the good work and keep making things :)', 0, 260, VIRTUAL_WIDTH, 'center')
	love.graphics.setFont(mediumFont)
	love.graphics.printf('press "R" to play again', 0, 380, VIRTUAL_WIDTH, 'center')
end
