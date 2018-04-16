local FoodStations = {}

-- If the station is being drawn.
local foodStationsActive = {false, false, false}
-- What is drawn at the station.
local foodStationsId = {-1, -1, -1}
-- What the value of the timer at each station is.
local foodStationsTimer = {0, 0, 0}

local curentTick = 0
local station_time = 24  -- 24s

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

            -- Draw the completion circle.
            completion_percent = foodStationsTimer[i] / 24
            love.graphics.setColor(150, 250, 150, 255)
            love.graphics.circle("line", (i-1) * 256 + 64, 128 - 32, 24 * completion_percent)
            love.graphics.circle("fill", (i-1) * 256 + 64, 128 - 32, 24 * completion_percent)

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
function FoodStations.update(dt)
    -- Make timer circle grow.
    for i,v in ipairs(foodStationsActive) do
        if foodStationsActive[i] == false and foodStationsTimer[i] > 0 then
            foodStationsTimer[i] = 0
        elseif foodStationsActive[i] == true then
            foodStationsTimer[i] = foodStationsTimer[i] + dt
        end

        -- Case: food station has been active too long.
        if foodStationsTimer[i] > 24 then
            -- Lose 10 points.
            ui.score = ui.score - 10
            if ui.score < 0 then
                ui.score = 0
            end

            -- Deactivate the food station.
            foodStationsActive[i] = false
        end
    end

    -- Loop stations.
    for i,v in ipairs(foodStationsActive) do
        if foodStationsActive[i] == true then
            -- Loop food.
            for k2,v2 in pairs(foodManager.foodList) do
                -- If the food is off the screen, but on the conveyor belt.
                if v2._typeId == tonumber(foodStationsId[i]) then
                    if v2.m_food.body:getX() > 16 + (i-1) * 256 and v2.m_food.body:getX() < 128 - 16 + (i-1) * 256 and v2.m_food.body:getY() < -16 then
                        -- Destroy food.
                        v2.m_destroy = true

                        -- Get 15 points.
                        ui.score = ui.score + 15

                        -- Deactivate the food stations.
                        foodStationsActive[i] = false
                    end
                end
            end
        end
    end

    -- Do something every 60 frames.
    curentTick = curentTick + 1
    if curentTick > 60 * love.math.random(4, 7) then
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
