--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local beginner = love.graphics.newImage('trophies/trophy-1.png')
local interm = love.graphics.newImage('trophies/trophy-2.png')
local expert = love.graphics.newImage('trophies/trophy-3.png')
local master = love.graphics.newImage('trophies/trophy-4.png')


--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    local trophy = nil
    local trophyType = nil

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    if self.score >=25 then
        trophy = master
        trophyType = "All hail the great bird master"
    elseif self.score >=15 then
        trophy = expert
        trophyType = "Whoa! We got a champion"
    elseif self.score>=8 then
        trophy = interm
        trophyType = "Brilliant. Keep flapping"
    elseif self.score>=4 then
        trophy = beginner
        trophyType = "You will learn, eventually"
    end

    love.graphics.setFont(flappyFont)

    if trophy ~= nil then
        love.graphics.printf(trophyType, 0, 64, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(trophy, VIRTUAL_WIDTH/2 - trophy:getWidth() * 0.05 , VIRTUAL_HEIGHT - trophy:getHeight()/3, 0, 0.1, 0.1)
    else
        love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    end
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter to Play Again!', 0, 200, VIRTUAL_WIDTH, 'center')
end