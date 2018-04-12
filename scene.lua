local Scene = {}

function Scene.load()
    foodStations = require "foodStations"

    -- Create the collision objects.
    objects.wallLeft = {}
    objects.wallLeft.body = love.physics.newBody(world, 0 + 128, (256-64) + 128, "static")
    objects.wallLeft.shape = love.physics.newRectangleShape(256, 256)
    objects.wallLeft.fixture = love.physics.newFixture(objects.wallLeft.body, objects.wallLeft.shape)
    objects.wallLeft.body:setFixedRotation(false)

    objects.wallRight = {}
    objects.wallRight.body = love.physics.newBody(world, 256 + 128 + 128, 256-64 + 128, "static")
    objects.wallRight.shape = love.physics.newRectangleShape(256, 256)
    objects.wallRight.fixture = love.physics.newFixture(objects.wallRight.body, objects.wallRight.shape)
    objects.wallRight.body:setFixedRotation(false)

end

function Scene.draw()
    -- Draw the walls
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle("fill", objects.wallLeft.body:getX()-128, objects.wallLeft.body:getY()-128, 256, 256)
    love.graphics.rectangle("fill", objects.wallRight.body:getX()-128, objects.wallRight.body:getY()-128, 256, 256)

    -- Draw the conveyor belt
    love.graphics.setColor(150, 150, 150, 150)
    love.graphics.rectangle("fill", 0, 512 + 64 + 16, screenSize.x, 512-(640-64))

    -- Draw food stations
    foodStations.draw()
end

function Scene.update()
    foodStations.update()
end

return Scene
