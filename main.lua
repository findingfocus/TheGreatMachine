push = require 'util/push'
Class = require 'util/class'
require 'states/StateMachine'
require 'states/BaseState'
require 'states/TitleScreenState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 800

VIRTUAL_WIDTH = 800
VIRTUAL_HEIGHT = 450

local machineAtlas
local machineSprite
local fps = 3
local animationTimer = 1 / fps
local frame = 1
local totalFrames = 3
local xoffset

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	love.window.setTitle('The Great Machine')

	machineAtlas = love.graphics.newImage('graphics/Machine1_SpriteSheet.png')
	machineSprite = love.graphics.newQuad(0, 0, 200, 350, machineAtlas:getDimensions())

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

	animationTimer = animationTimer - dt
	if animationTimer <= 0 then
		animationTimer = 1 / fps
		frame = frame + 1
		if frame > totalFrames then frame = 1 end
		xoffset = 200 * (frame - 1)
		machineSprite:setViewport(xoffset, 0, 200, 350)
	end

	gStateMachine:update(dt)

	love.keyboard.keysPressed = {} 
end

function love.draw()
	push:start()

	gStateMachine:render()

	love.graphics.draw(machineAtlas, machineSprite, VIRTUAL_WIDTH / 2 - 100, VIRTUAL_HEIGHT - 350)

	displayFPS()
	push:finish()
end

function displayFPS()
	love.graphics.setFont(smallFont)
	love.graphics.setColor(0/255, 255/255, 0/255, 255/255)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end