local Scene = {}

function Scene.load()

    -- Create the collision objects.
    objects.wallLeft = {}
    objects.wallLeft.body = love.physics.newBody(world, 0 + 128, (256-64) + 128, "static")
    objects.wallLeft.shape = love.physics.newRectangleShape(256, 256)
    objects.wallLeft.fixture = love.physics.newFixture(objects.wallLeft.body, objects.wallLeft.shape)
    objects.wallLeft.body:isFixedRotation(false)


    objects.wallRight = {}
    objects.wallRight.body = love.physics.newBody(world, 256 + 128 + 128, 256-64 + 128, "static")
    objects.wallRight.shape = love.physics.newRectangleShape(256, 256)
    objects.wallRight.fixture = love.physics.newFixture(objects.wallRight.body, objects.wallRight.shape)
    objects.wallRight.body:isFixedRotation(false)

end

function Scene.draw()
    love.graphics.rectangle("fill", objects.wallLeft.body:getX()-128, objects.wallLeft.body:getY()-128, 256, 256)
    love.graphics.rectangle("fill", objects.wallRight.body:getX()-128, objects.wallRight.body:getY()-128, 256, 256)
end

return Scene
