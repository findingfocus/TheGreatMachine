Ideas = Class{} 

ideaFallSpeed = 1

function Ideas:init()
	self.x = math.random(5, VIRTUAL_WIDTH - 50)
	self.y = -20
end

function Ideas:update(dt)
	self.dy = ideaFallSpeed + dt
	self.y = self.y + self.dy
end

function Ideas:render()
	love.graphics.setColor(255/255, 50/255, 50/255, 255/255)
	love.graphics.rectangle('fill', self.x, self.y, 70, 25)
	love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
	love.graphics.setFont(smallFont)
	love.graphics.print('IDEA', self.x + 18, self.y + 5)
end