import "scoreDisplay"
local pd <const> = playdate
local gfx <const> = pd.graphics

class('MovableEnemy').extends(gfx.sprite)

function MovableEnemy:init(x, y, moveSpeed)
    local enemyImage = gfx.image.new("images/block")
    self:setImage(enemyImage)
    self:moveTo(x, y)
    self:add()
    self:setCollideRect(0, 0, self:getSize())
    self.moveSpeed = moveSpeed
    self.isMovingUp = true
end

function MovableEnemy:update()
    self:moveBy(-self.moveSpeed, 0)
    if self.x < -30 then
        self:remove()
        incrementScore()
    end
    if self.isMovingUp then
        -- 向上移动
        self:moveBy(0, -self.moveSpeed)
        if self.y <= 40 then
            -- 当 y 坐标达到 40 时，改变方向
            self.isMovingUp = false
        end
    else
        -- 向下移动
        self:moveBy(0, self.moveSpeed)
        if self.y >= 200 then
            -- 当 y 坐标达到 200 时，改变方向
            self.isMovingUp = true
        end
    end

end

function MovableEnemy:collisionResponse()
    return "overlap"
end