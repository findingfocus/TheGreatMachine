push = require 'util/push'
Class = require 'util/class'
require 'states/StateMachine'
require 'states/BaseState'
require 'states/TitleScreenState'
require 'states/PlayState'
require 'states/EndState'
require 'Player'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 800

VIRTUAL_WIDTH = 800
VIRTUAL_HEIGHT = 450

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	love.window.setTitle('The Great Machine')

	smallFont = love.graphics.newFont('fonts/KronaOne.ttf', 10)
	mediumFont = love.graphics.newFont('fonts/KronaOne.ttf', 20)
	largeFont = love.graphics.newFont('fonts/KronaOne.ttf', 45)
	love.graphics.setFont(smallFont)

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = true,
		resizable = false
	})

	gStateMachine = StateMachine {
		['titleState'] = function() return TitleScreenState() end,
		['playState'] = function() return PlayState() end,
		['endState'] = function() return EndState() end
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

	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateMachine:change('playState')
	end

	Player:update(dt)

	gStateMachine:update(dt)

	love.keyboard.keysPressed = {} 
end

function love.draw()
	push:start()
	love.graphics.clear(5/255, 60/255, 5/255, 255/255)

	gStateMachine:render()

	Player:render()

	displayFPS()
	push:finish()
end

function displayFPS()
	love.graphics.setFont(smallFont)
	love.graphics.setColor(0/255, 255/255, 0/255, 255/255)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end