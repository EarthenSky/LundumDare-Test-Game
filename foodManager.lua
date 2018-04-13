local FoodManager = {}

local food = require("food")
FoodManager.foodList = {}

local currentId = 1

local curentTick = 0

-- Create a food object with a certain value at the new id.
function FoodManager.addFood(value)
    FoodManager.foodList[currentId] = food:new( {x=-16, y=560}, value )
    currentId = currentId + 1
end

--[[ Remove and item from the food list via it's instance id.
function FoodManager.removeFood(instanceId)
    foodList[instanceId] = nul
end]]

-- Draws all food objects.
function FoodManager.draw()
    for k,v in pairs(FoodManager.foodList) do
        FoodManager.foodList[k]:draw()
        love.graphics.polygon("line", FoodManager.foodList[k].m_food.body:getWorldPoints(FoodManager.foodList[k].m_food.shape:getPoints()))
    end
end

-- Updates all food objects.
function FoodManager.update(dt)
    -- Garbage list, holds variables to destroy.
    garbList = {}

    for k,v in pairs(FoodManager.foodList) do
        FoodManager.foodList[k]:update(dt)
        if FoodManager.foodList[k].m_destroy == true then
            garbList[k] = true
        end
    end

    -- Empty the garbage list.
    for k,v in pairs(garbList) do
        FoodManager.foodList[k].m_food.body:destroy()
        FoodManager.foodList[k] = nul
    end

    -- Spawn a food every 120 frames.
    curentTick = curentTick + 1
    if curentTick > 120 then
        curentTick = 0
        FoodManager.addFood(love.math.random(0, 3))
    end
end

return FoodManager
