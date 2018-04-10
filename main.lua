-- Constant variables.
screenSize = {x=640, y=640}

-- The initialize function.
function love.load()
    -- Images are loaded here.
    charSpriteSheet = love.graphics.newImage("Resources/red-spritesheet.png")

    -- Set up the window.
    love.window.setMode(screenSize.x, screenSize.y, {resizable=false, vsync=true})
    love.window.setTitle("Give Me Food")
    love.graphics.setBackgroundColor(0, 0, 0, 255)

    -- Create a world for the bodies to exist in with no gravity.
    world = love.physics.newWorld(0, 0, false)
    love.physics.setMeter(64)

    -- Table to hold all our the objects
    objects = {}

    -- Create the player collision object.
    objects.player = {}
    objects.player.body = love.physics.newBody(world, 256/2, 256/2, "dynamic")
    objects.player.shape = love.physics.newRectangleShape(32, 32)
    objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape)
    objects.player.body:isFixedRotation(false)

    -- Other Modules are loaded here.
    char = require("char")
    scene = require("scene")

    -- Init goes here.
    char.load()
    scene.load()

end

-- The draw function.
function love.draw()

    --love.graphics.polygon("line", objects.player.body:getWorldPoints(objects.player.shape:getPoints()))
    --love.graphics.polygon("line", objects.wallLeft.body:getWorldPoints(objects.wallLeft.shape:getPoints()))
    --love.graphics.polygon("line", objects.wallRight.body:getWorldPoints(objects.wallRight.shape:getPoints()))

    scene.draw()
    char.draw()
end

-- The update function.
function love.update(dt)


    --objects.player.body:setAwake(true)

    char.update(dt)
    world:update(dt)
end
