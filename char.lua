local Char = {}

-- moveType controls the direction and animation of the player.
-- 0 is no movement, 1 is up, 2 is right, 3 is down, 4 is left.
local moveType = 0

local SPEED = 160

-- Keyboard Varibles.
local startButtonPress = false

-- The position of the image, by intervals of 1, not 32.
local quadDrawIndex = {x=0, y=0}

-- Animation variables
local frame_counter = 0
local animation_value = {0, 1, 2, 1}
local is_animation_playing = false

local space_key = false

local food_is_picked_up = false
Char.grabbed_objects = {}

-- Find distance between two points.
function distance ( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end

function collision_check()
    -- Screen Bounds Collision
    if objects.player.body:getX() < 16 then
        objects.player.body:setX(16)
    elseif objects.player.body:getX() > screenSize.x - 16 then
        objects.player.body:setX(screenSize.x - 16)
    end

    -- Screen Bounds Collision
    if objects.player.body:getY() < 16 then
        objects.player.body:setY(16)
    elseif objects.player.body:getY() > screenSize.y - 16 then
        objects.player.body:setY(screenSize.y - 16)
    end
end

function Char.load()
    -- Create the player collision object.
    objects.player = {}
    objects.player.body = love.physics.newBody(world, 256/2, 256/2, "dynamic")
    objects.player.shape = love.physics.newRectangleShape(32, 32)
    objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape)
    objects.player.body:setFixedRotation(true)
end

function Char.draw()
    -- Check which animation to draw.
    if startButtonPress == true then
        if moveType == 1 then
            quadDrawIndex.y = 3
        elseif moveType == 2 then
            quadDrawIndex.y = 2
        elseif moveType == 3 then
            quadDrawIndex.y = 0
        elseif moveType == 4 then
            quadDrawIndex.y = 1
        end
    end

    -- Draw the character with the quad.
    love.graphics.setColor(255, 255, 255, 255)
    drawQuad = love.graphics.newQuad(quadDrawIndex.x * 32, quadDrawIndex.y * 32, 32, 32, charSpriteSheet:getWidth(), charSpriteSheet:getHeight())
    love.graphics.draw(charSpriteSheet, drawQuad, objects.player.body:getX()-16, objects.player.body:getY()-16)
end

function Char.update(dt)
    --TODO fix speed.
    if love.keyboard.isDown( "w" ) then
        moveType = 1
        startButtonPress = true
        is_animation_playing = true
        objects.player.body:setY(objects.player.body:getY() - SPEED * dt)

        if food_is_picked_up == true then
            -- Loop food.  Drop these food.
            for k, val in pairs(Char.grabbed_objects) do
                if val == true then
                    foodManager.foodList[k].m_food.body:setY(foodManager.foodList[k].m_food.body:getY() - SPEED * dt)
                end
            end
        end

    elseif love.keyboard.isDown( "a" ) then
        moveType = 4
        startButtonPress = true
        is_animation_playing = true
        objects.player.body:setX(objects.player.body:getX() - SPEED * dt)

    elseif love.keyboard.isDown( "s" ) then
        moveType = 3
        startButtonPress = true
        is_animation_playing = true
        objects.player.body:setY(objects.player.body:getY() + SPEED * dt)

    elseif love.keyboard.isDown( "d" ) then
        moveType = 2
        startButtonPress = true
        is_animation_playing = true
        objects.player.body:setX(objects.player.body:getX() + SPEED * dt)

    else
        -- Stop moving.
        moveType = 0
        is_animation_playing = false
        frame_counter = 0
        quadDrawIndex.x = 1

    end

    -- If player is picking up cubes.
    if love.keyboard.isDown( "space" ) then
        if space_key == false then
            space_key = true

            food_is_picked_up = not food_is_picked_up

            if food_is_picked_up == true then
                -- Loop food.  Drop these food.
                for k, val in pairs(foodManager.foodList) do
                    if distance( val.m_food.body:getX(), val.m_food.body:getY(), objects.player.body:getX(), objects.player.body:getY() ) < 64 then
                        Char.grabbed_objects[k] = false
                    end
                end
            else
                -- Loop food.  Add these food.
                for k, val in pairs(foodManager.foodList) do
                    if distance( val.m_food.body:getX(), val.m_food.body:getY(), objects.player.body:getX(), objects.player.body:getY() ) < 64 then
                        Char.grabbed_objects[k] = true
                    end
                end
            end
        end
    elseif love.keyboard.isDown( "space" ) == false then
        space_key = false
    end

    frame_counter = frame_counter + 1

    -- If the frame counter hits 15 frames, change to the next frame.
    if is_animation_playing == true then
        quadDrawIndex.x = animation_value[(math.floor(frame_counter / 8) % 4) + 1]
    end

    -- Move this objects if on the conveyor belt.
    if objects.player.body:getY() > 512 and objects.player.body:getY() < 640 - 32 then
        objects.player.body:setX(objects.player.body:getX() + 50 * dt)
    elseif objects.player.body:getX() > 16 and objects.player.body:getX() < 128 - 16 and objects.player.body:getY() < 128 + 16 then
        objects.player.body:setY(objects.player.body:getY() - 50 * dt)
    elseif objects.player.body:getX() > 16 + 256 and objects.player.body:getX() < 128 - 16 + 256 and objects.player.body:getY() < 128 + 16 then
        objects.player.body:setY(objects.player.body:getY() - 50 * dt)
    elseif objects.player.body:getX() > 16 + 512 and objects.player.body:getX() < 128 - 16 + 512 and objects.player.body:getY() < 128 + 16 then
        objects.player.body:setY(objects.player.body:getY() - 50 * dt)
    end

    -- Check for player and screen bounds collision.
    collision_check()

end

return Char
