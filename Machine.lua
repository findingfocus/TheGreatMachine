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

function Machine:init()
	self.image = love.graphics.newImage('graphics/Machine1_SpriteSheet.png')
	self.x = 300
	self.y = 100
end

function Machine:update(dt)
	animationTimer = animationTimer - dt
	if animationTimer <= 0 then
		animationTimer = 1 / fps
		frame = frame + 1
		if frame > totalFrames then frame = 1 end
		xoffset = 200 * (frame - 1)
		machineSprite:setViewport(xoffset, 0, 200, 350)
	end
end

function Machine:render()
	love.graphics.draw(machineAtlas, machineSprite, self.x, self.y)
	--love.graphics.printf('self.x = ' .. tostring(self.x), 0, 120, VIRTUAL_WIDTH, 'center')
	--love.graphics.printf('timer = ' .. tostring(animationTimer), 0, 120, VIRTUAL_WIDTH, 'center')
end 
