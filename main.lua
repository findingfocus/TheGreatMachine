push = require 'util/push'
Class = require 'util/class'
require 'states/StateMachine'
require 'states/BaseState'
require 'states/TitleScreenState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 800

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	love.window.setTitle('The Great Machine')

	smallFont = love.graphics.newFont('fonts/KronaOne.ttf', 40)
	mediumFont = love.graphics.newFont('fonts/KronaOne.ttf', 60)
	largeFont = love.graphics.newFont('fonts/KronaOne.ttf', 90)
	love.graphics.setFont(smallFont)

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = true,
		resizable = false
	})

	gStateMachine = StateMachine {
		['titleState'] = function() return TitleScreenState() end
	}

	gStateMachine:change('titleState')

	love.keyboard.keysPressed = {}

end

function love.resize(w, h)
	push:resize(w,h)
end

function love.keypressed(key)
	love.keyboard.keysPressed[key] = true

	if key == 'escape' then
		love.event.quit()
	end
end

function love.keyboard.wasPressed(key)
	if love.keyboard.keysPressed[key] then
		return true
	else
		return false
	end
end

function love.update(dt)
	gStateMachine:update(dt)

	love.keyboard.keysPressed = {} 
end

function love.draw()
	push:start()
	gStateMachine:render()
	displayFPS()
	push:finish()
end

function displayFPS()
	love.graphics.setFont(smallFont)
	love.graphics.setColor(0/255, 255/255, 0/255, 255/255)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end