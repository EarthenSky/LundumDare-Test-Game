-- Constant variables.
screenSize = {x=640, y=640}

-- The initialize function.
function love.load()
    -- Images are loaded here.
    charSpriteSheet = love.graphics.newImage("Resources/red-spritesheet.png")
    cherry = love.graphics.newImage("Resources/Cherry.png")
    cheese = love.graphics.newImage("Resources/Cheese.png")
    coffee = love.graphics.newImage("Resources/Coffee.png")
    chicken = love.graphics.newImage("Resources/Chicken.png")

    -- Set up the window.
    love.window.setMode(screenSize.x, screenSize.y, {resizable=false, vsync=true})
    love.window.setTitle("Give Me Food")
    love.graphics.setBackgroundColor(0, 0, 0, 255)

    -- Create a world for the bodies to exist in with no gravity.
    world = love.physics.newWorld(0, 0, false)
    love.physics.setMeter(64)

    -- Table to hold all our the objects
    objects = {}

    -- Other Modules are loaded here.
    char = require("char")
    scene = require("scene")
    foodManager = require("foodManager")
    ui = require("ui")

    -- Init goes here.
    char.load()
    scene.load()

end

-- The draw function.
function love.draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.polygon("line", objects.player.body:getWorldPoints(objects.player.shape:getPoints()))
    --love.graphics.polygon("line", objects.wallLeft.body:getWorldPoints(objects.wallLeft.shape:getPoints()))
    --love.graphics.polygon("line", objects.wallRight.body:getWorldPoints(objects.wallRight.shape:getPoints()))

    scene.draw()
    char.draw()
    foodManager.draw()
    ui.draw()
end

-- The update function.
function love.update(dt)
    scene.update(dt)
    char.update(dt)
    foodManager.update(dt)
    world:update(dt)
end
