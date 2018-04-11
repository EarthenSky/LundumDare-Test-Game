local FoodManager = {}

local food = require("food")
local foodList = { food:new( {x=40, y=525}, 1 ) }

local currentId = 2

-- Create a food object with a certain value at the new id.
function FoodManager.addFood(value)
    foodList[currentId] = food:new( {x=0, y=525}, value )
    currentId = currentId + 1
end

--[[ Remove and item from the food list via it's instance id.
function FoodManager.removeFood(instanceId)
    foodList[instanceId] = nul
end]]

-- Draws all food objects.
function FoodManager.draw()
    for i,v in ipairs(foodList) do
        foodList[i]:draw()
        love.graphics.polygon("line", foodList[i].m_food.body:getWorldPoints(foodList[i].m_food.shape:getPoints()))
    end
end

--updates all food objects.
function FoodManager.update(dt)
    -- Garbage list, holds variables to destroy.
    garbList = {}

    for i,v in ipairs(foodList) do
        foodList[i]:update(dt)
        if foodList[i].m_destroy == true then
            garbList[i] = i
        end
    end

    -- Empty the garbage list.
    for i,v in ipairs(garbList) do
        foodList[i] = nul
    end
end

return FoodManager
