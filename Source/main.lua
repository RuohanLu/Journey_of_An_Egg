import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "enemySpawner"
import "scoreDisplay"
import "screenShake"

local pd <const> = playdate
local gfx <const> = pd.graphics

--Initialize play UI
local playerSprite = nil
local playerSprite2 = nil
local function initialize()
    math.randomseed(pd.getSecondsSinceEpoch())
    local playerImage = gfx.image.new("images/ball")
    playerSprite = gfx.sprite.new(playerImage)
    playerSprite2 = gfx.sprite.new(playerImage)
    playerSprite:moveTo(100, 24)
    playerSprite2:moveTo(100, 156)
    playerSprite:setCollideRect(2, 2, 20, 20)
    playerSprite2:setCollideRect(2, 2, 20, 20)
    --playerSprite:collisionResponse("overlap")
    --playerSprite2:collisionResponse("overlap")
    playerSprite:add()
    playerSprite2:add()
end

initialize()

function playerSprite:collisionResponse(other)
    return gfx.sprite.kCollisionTypeOverlap
end

function playerSprite2:collisionResponse(other)
    return gfx.sprite.kCollisionTypeOverlap
end

-- Ball rotate logic
local rotateSpeed = 1
local function calRotate()
    local distance = 70
    local angle = playdate.getCrankPosition()/180 *math.pi * rotateSpeed
    local x = distance*(math.cos(angle))
    local y = distance*(math.sin(angle))
    playerSprite:moveWithCollisions(x+100, y+120)
    playerSprite2:moveWithCollisions(100-x, 120-y)
    --playerSprite:setCollidesWithGroups(1)
    --playerSprite2:setCollidesWithGroups(1)
end

local screenShakeSprite = ScreenShake()

function resetGame()
    resetScore()
    clearEnemies()
    stopSpawner()
    startSpawner()
    setShakeAmount(10)
end

function setShakeAmount(amount)
    screenShakeSprite:setShakeAmount(amount)
end

local function checkCollision(sprite)
    local collisions = sprite:overlappingSprites()
    return #collisions > 0 -- 如果表的长度大于0，说明有碰撞发生，返回true
end

function detectCollision()
    local player1Colliding = checkCollision(playerSprite)
    local player2Colliding = checkCollision(playerSprite2)
    if player1Colliding or player2Colliding then
        resetGame()
    end
end

createScoreDisplay()
startSpawner()

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
    calRotate()
    detectCollision()
    gfx.drawText("Press B to restart", 5, 2)
    updateDisplay()
    if pd.buttonJustPressed(pd.kButtonB) then
        resetGame()  -- 调用 resetGame() 函数
    end
end