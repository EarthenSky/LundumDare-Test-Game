local Char = {}

-- moveType controls the direction and animation of the player.
-- 0 is no movement, 1 is up, 2 is right, 3 is down, 4 is left.
local moveType = 0

local SPEED = 120

-- Keyboard Varibles.
local startButtonPress = false

-- The position of the image, by intervals of 1, not 32.
local quadDrawIndex = {x=0, y=0}

-- Animation variables
local frame_counter = 0
local animation_value = {0, 1, 2, 1}
local is_animation_playing = false

function collision_check()
    -- Screen Bounds Collision
    if objects.player.body:getX() < 0 then
        objects.player.body:setX(0)
    elseif objects.player.body:getX() > screenSize.x - 32 then
        objects.player.body:setX(screenSize.x - 32)
    end

    -- Screen Bounds Collision
    if objects.player.body:getY() < 0 then
        objects.player.body:setY(0)
    elseif objects.player.body:getY() > screenSize.y - 32 then
        objects.player.body:setY(screenSize.y - 32)
    end
end

function Char.load()
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

    frame_counter = frame_counter + 1

    -- If the frame counter hits 15 frames, change to the next frame.
    if is_animation_playing == true then
        quadDrawIndex.x = animation_value[(math.floor(frame_counter / 8) % 4) + 1]
    end

    -- Check for player and screen bounds collision.
    collision_check()

end

return Char
