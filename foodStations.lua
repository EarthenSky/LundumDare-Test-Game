local FoodStations = {}

-- If the station is being drawn.
local foodStationsActive = {false, false, false}
local foodStationsId = {-1, -1, -1}

local curentTick = 0

function FoodStations.draw()
    -- Draw the food stations belts
    love.graphics.setColor(150, 150, 150, 255)
    love.graphics.rectangle("fill", 32, 0, 64, 128)
    love.graphics.rectangle("fill", 256 + 32, 0, 64, 128)
    love.graphics.rectangle("fill", 512 + 32, 0, 64, 128)

    -- Draw the food that is needed.
    for i,v in ipairs(foodStationsActive) do
        if foodStationsActive[i] == true then
            -- Draw the circles.
            love.graphics.setColor(220, 220, 220, 255)
            love.graphics.circle("line", (i-1) * 256 + 64, 128 - 32, 24)
            love.graphics.circle("fill", (i-1) * 256 + 64, 128 - 32, 24)

            -- Draw the items.
            if foodStationsId[i] > -1 then
                love.graphics.setColor(255, 255, 255, 255)
                if foodStationsId[i] == 0 then
                    love.graphics.draw(cherry, (i-1) * 256 + 64 - 16 - 1, 128 - 48)
                elseif foodStationsId[i] == 1 then
                    love.graphics.draw(coffee, (i-1) * 256 + 64 - 16 - 1, 128 - 48)
                elseif foodStationsId[i] == 2 then
                    love.graphics.draw(cheese, (i-1) * 256 + 64 - 16 - 1, 128 - 48)
                elseif foodStationsId[i] == 3 then
                    love.graphics.draw(chicken, (i-1) * 256 + 64 - 16 - 1, 128 - 48)
                end
            end
        end
    end
end

-- Update function.
function FoodStations.update()
    -- Do something every 60 frames.
    curentTick = curentTick + 1
    if curentTick > 60 * love.math.random(5, 10) then
        curentTick = 0
        random_station = love.math.random(0, 3)

        -- Activate station.
        if foodStationsActive[random_station] == false then
            foodStationsActive[random_station] = true

            -- Do thing.
            foodStationsId[random_station] = love.math.random(0, 3)
        end
    end
end

return FoodStations
