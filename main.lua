push = require 'util/push'
Class = require 'util/class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 800

VIRTUAL_WIDTH = 800
VIRTUAL_HEIGHT = 450

require 'states/StateMachine'
require 'states/BaseState'
require 'states/TitleScreenState'
require 'states/PlayState'
require 'states/EndState'
require 'Machine'
require 'Ideas'

machine = Machine()

ideas = Ideas()

ideaSpawnTimer = 2

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	love.window.setTitle('The Great Machine')

	math.randomseed(os.time())

	smallFont = love.graphics.newFont('fonts/KronaOne.ttf', 10)
	mediumFont = love.graphics.newFont('fonts/KronaOne.ttf', 20)
	largeFont = love.graphics.newFont('fonts/KronaOne.ttf', 45)
	endFont = love.graphics.newFont('fonts/KronaOne.ttf', 30)
	love.graphics.setFont(smallFont)

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = true,
		resizable = false
	})

	sounds = {
		['point'] = love.audio.newSource('sounds/point.wav','static')
	}

	gStateMachine = StateMachine {
		['titleState'] = function() return TitleScreenState() end,
		['playState'] = function() return PlayState() end,
		['endState'] = function() return EndState() end
	}

	gStateMachine:change('endState')

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

	gStateMachine:update(dt)

	love.keyboard.keysPressed = {} 
end

function love.draw()
	push:start()
	love.graphics.clear(5/255, 60/255, 5/255, 255/255)
	gStateMachine:render()
	--love.graphics.print('spawnTimer = ' .. tostring(ideaSpawnTimer), 10, 10)
	displayFPS()
	push:finish()
end

function displayFPS()
	love.graphics.setFont(smallFont)
	love.graphics.setColor(0/255, 255/255, 0/255, 255/255)
	--love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end