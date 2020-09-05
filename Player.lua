Player = Class{}

local machineAtlas
local machineSprite
local fps = 3
local animationTimer = 1 / fps
local frame = 1
local totalFrames = 3
local xoffset
machineAtlas = love.graphics.newImage('graphics/Machine1_SpriteSheet.png')
machineSprite = love.graphics.newQuad(0, 0, 200, 350, machineAtlas:getDimensions())

function Player:init()
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()

	self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
	self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
end

function Player:update(dt)
	animationTimer = animationTimer - dt
	if animationTimer <= 0 then
		animationTimer = 1 / fps
		frame = frame + 1
		if frame > totalFrames then frame = 1 end
		xoffset = 200 * (frame - 1)
		machineSprite:setViewport(xoffset, 0, 200, 350)
	end
end 

function Player:render()
	love.graphics.draw(machineAtlas, machineSprite, VIRTUAL_WIDTH / 2 - 100, VIRTUAL_HEIGHT - 400, 0)
end