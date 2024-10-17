import "enemy"
import "scoreDisplay"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer

function startSpawner()
    math.randomseed(pd.getSecondsSinceEpoch())
    createTimer()
    printTable(pd.timer.allTimers())
end

function createTimer()
    local spawnTime = math.random(1600 , 2000)
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
        createTimer()
        spawnEnemy()
    end)
end

function spawnEnemy(isGenerate)
    local spawnPosition = math.random(30, 180)
    Enemy(430, spawnPosition, 3)
end

function stopSpawner()
    if spawnTimer then
        spawnTimer:remove()
    end
end

function clearEnemies()
    local allSprites = gfx.sprite.getAllSprites()
    for index, sprite in ipairs(allSprites) do
        if sprite:isa(Enemy) then
            sprite:remove()
        end
    end
end