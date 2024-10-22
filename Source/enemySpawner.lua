import "enemy"
import "movableEnemy"
import "scoreDisplay"
import "sprintEnemy"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer

function startSpawner()
    math.randomseed(pd.getSecondsSinceEpoch())
    createTimer()  -- 只需要一个计时器来处理所有的生成
    printTable(pd.timer.allTimers())
end

function createTimer()
    local spawnTime = math.random(1900, 2450)
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
        createTimer()  -- 重新启动计时器

        -- 使用概率决定生成哪种敌人
        local rand = math.random(1, 100)  -- 随机生成 1 到 100 的整数
        if rand <= 60 then
            spawnEnemy()
        elseif rand <= 80 then
            -- 20% 概率生成 MovableEnemy
            spawnMovableEnemy()
        else
            spawnSprintEnemy()
        end
    end)
end

function spawnEnemy(isGenerate)
    local spawnPosition = math.random(30, 180)
    Enemy(430, spawnPosition, 3)
end

function spawnMovableEnemy(isGenerate)
    local spawnPosition = math.random(30, 180)
    MovableEnemy(430, spawnPosition, 3)
end

function spawnSprintEnemy(isGenerate)
    local spawnPosition = math.random(30, 180)
    SprintEnemy(430, spawnPosition, 3)
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
        if sprite:isa(MovableEnemy) then
            sprite:remove()
        end
        if sprite:isa(SprintEnemy) then
            sprite:remove()
        end
    end
end