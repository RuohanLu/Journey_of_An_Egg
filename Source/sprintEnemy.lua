import "scoreDisplay"
local pd <const> = playdate
local gfx <const> = pd.graphics

class('SprintEnemy').extends(gfx.sprite)

function SprintEnemy:init(x, y, moveSpeed)
    local enemyImage = gfx.image.new("images/block")
    self:setImage(enemyImage)
    self:moveTo(x, y)
    self:add()
    self:setCollideRect(0, 0, self:getSize())
    self.moveSpeed = moveSpeed
end

function SprintEnemy:update()
    if self.x < 300 then
        self:moveBy(-2*self.moveSpeed, 0)
    else
        self:moveBy(-self.moveSpeed, 0)
    end
    
    if self.x < -30 then
        self:remove()
        incrementScore()
    end
end

function SprintEnemy:collisionResponse()
    return "overlap"
end