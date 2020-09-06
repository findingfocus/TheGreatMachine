Machine = Class{}

local machineAtlas
local machineSprite
local fps = 3
local animationTimer = 1 / fps
local frame = 1
local totalFrames = 3
local xoffset
machineAtlas = love.graphics.newImage('graphics/Machine1_SpriteSheet.png')
machineSprite = love.graphics.newQuad(0, 0, 200, 350, machineAtlas:getDimensions())

local machineSpeed = 150

function Machine:init()
	self.image = love.graphics.newImage('graphics/Machine1_SpriteSheet.png')
	self.x = 300
	self.y = 100
	self.dx = 0
end

function Machine:update(dt)
	--animation
	animationTimer = animationTimer - dt
	if animationTimer <= 0 then
		animationTimer = 1 / fps
		frame = frame + 1
		if frame > totalFrames then frame = 1 end
		xoffset = 200 * (frame - 1)
		machineSprite:setViewport(xoffset, 0, 200, 350)
	end

	--input handling
	if love.keyboard.isDown('left') then
		self.dx = -machineSpeed * dt
		self.x = math.max(self.x + self.dx, -20)
	end

	if love.keyboard.isDown('right') then
		self.dx = machineSpeed * dt
		self.x = math.min(self.x + self.dx, VIRTUAL_WIDTH - 180)
	end

	if love.keyboard.wasPressed('r') then
		self.x = 300
		self.y = 100
		self.dx = 0
	end
end

function Machine:render()
	love.graphics.draw(machineAtlas, machineSprite, self.x, self.y)
end 
