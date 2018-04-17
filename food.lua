Food = {}

function Food:new(pos, typeId)
    -- Add member variables here.
    thisObj = {_typeId = -1, m_food = {}, m_destroy = false}

    -- Init private variables here
    thisObj._typeId = typeId

    -- Create the player collision object.
    thisObj.m_food.body = love.physics.newBody(world, pos.x, pos.y, "dynamic")
    thisObj.m_food.shape = love.physics.newRectangleShape(32, 32)
    thisObj.m_food.fixture = love.physics.newFixture(thisObj.m_food.body, thisObj.m_food.shape, 0.1)
    thisObj.m_food.body:setFixedRotation(true)

    -- Make this a class.
    self.__index = self
    return setmetatable(thisObj, self)
end

function Food:getType()
    return _typeId
end

-- Draw the sprite equal to this object's type
function Food:draw()
    love.graphics.setColor(255, 255, 255, 255)
    if self._typeId == 0 then
        love.graphics.draw(cherry, self.m_food.body:getX() - cherry:getWidth()/2, self.m_food.body:getY() - cherry:getHeight()/2)
    elseif self._typeId == 1 then
        love.graphics.draw(coffee, self.m_food.body:getX() - coffee:getWidth()/2, self.m_food.body:getY() - coffee:getHeight()/2)
    elseif self._typeId == 2 then
        love.graphics.draw(cheese, self.m_food.body:getX() - cheese:getWidth()/2, self.m_food.body:getY() - cheese:getHeight()/2)
    elseif self._typeId == 3 then
        love.graphics.draw(chicken, self.m_food.body:getX() - chicken:getWidth()/2, self.m_food.body:getY() - chicken:getHeight()/2)
    end
end

Food.on_belt = false

-- Update this sprite.
function Food:update(dt)

    -- Move the sprite if on the conveyor belt.  Also assign a value to the flag.
    self.on_belt = true
    if self.m_food.body:getY() > 512 and self.m_food.body:getY() < 640 - 32 then
        self.m_food.body:setX(self.m_food.body:getX() + 50 * dt)
    elseif self.m_food.body:getX() > 16 and self.m_food.body:getX() < 128 - 16 and self.m_food.body:getY() < 128 + 16 then
        self.m_food.body:setY(self.m_food.body:getY() - 50 * dt)
    elseif self.m_food.body:getX() > 16 + 256 and self.m_food.body:getX() < 128 - 16 + 256 and self.m_food.body:getY() < 128 + 16 then
        self.m_food.body:setY(self.m_food.body:getY() - 50 * dt)
    elseif self.m_food.body:getX() > 16 + 512 and self.m_food.body:getX() < 128 - 16 + 512 and self.m_food.body:getY() < 128 + 16 then
        self.m_food.body:setY(self.m_food.body:getY() - 50 * dt)
    else
        self.on_belt = false
    end

    -- Destroy object.
    if self.m_food.body:getX() < -64 or self.m_food.body:getX() > 700 then
        self.m_destroy = true
        return
    end

    -- Screen Bounds Collision
    if self.m_food.body:getY() < -32 then
        self.m_destroy = true
        return
    elseif self.m_food.body:getY() > screenSize.y - 16 then
        self.m_food.body:setY(screenSize.y - 16)
    end
    --maths here
end

return Food
