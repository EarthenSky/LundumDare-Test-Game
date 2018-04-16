local UI = {}

UI.score = 0

function UI.draw()
    scoreDraw = UI.score

    -- Calculate the amount of zeros
    while string.len(scoreDraw) < 4 do
        scoreDraw =  "0" .. scoreDraw
    end

    -- Print the score to the screen
    love.graphics.setColor(2, 2, 2, 255)
    love.graphics.setNewFont(42)
    love.graphics.print("Score: " .. scoreDraw, 0, 296)
end

return UI
