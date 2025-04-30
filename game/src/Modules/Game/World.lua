local World = {}

local function createTiles(...)
    local args = {...}
    local self = args[1]

    -- clear every single tile before rebaking it on the map --
    self.bth_ground:clear()

    -- create floor tiles --
    for y = 1, self.h, 1 do
        for x = 1, self.w, 1 do
            -- set color based on the position --
            if x >= self.w or y >= self.h then
                self.bth_ground:setColor(0.5, 0.5, 0.5, 1)
            end
            if x == self.w and y == self.h then
                self.bth_ground:setColor(0.25, 0.25, 0.25, 1)
            end
            self.bth_ground:add(self.assets.walls.quads["ground_stone"], x * self.qw, y * self.qh)

            -- reset --
            self.bth_ground:setColor(1, 1, 1, 1)
        end
    end

    -- generate walls --

    -- corner --
    self.bth_ground:add(self.assets.walls.quads["wall_corner"], 0, 0)
    for x = 1, self.w, 1 do
        -- set color based on the position --
        if x >= self.w then
            self.bth_ground:setColor(0.5, 0.5, 0.5, 1)
        end
        self.bth_ground:add(self.assets.walls.quads["wall_brick_top"], x * self.qw, 0)

        -- reset --
        self.bth_ground:setColor(1, 1, 1, 1)
    end

    for y = 1, self.h, 1 do
        -- set color based on the position --
        if y >= self.h then
            self.bth_ground:setColor(0.5, 0.5, 0.5, 1)
        end
        self.bth_ground:add(self.assets.walls.quads["wall_brick_left"], 0, y * self.qh)

        -- reset --
        self.bth_ground:setColor(1, 1, 1, 1)
    end
end

local function updateClickzones(...)
    local args = {...}
    local self = args[1]

    self.clickzones["right"].x = self.w * 32
    self.clickzones["right"].y = 32
    self.clickzones["right"].h = (self.h - 1) * 32

    self.clickzones["bottom"].x = 32
    self.clickzones["bottom"].y = self.h * 32
    self.clickzones["bottom"].w = (self.w - 1) * 32

    self.clickzones["diagonal"].x = self.w * 32
    self.clickzones["diagonal"].y = self.h * 32
end

function World:init(assets, w, h)
    self.assets = assets
    self.w = w or 16
    self.h = h or 16

    self.clickzones = {
        ["right"] = {
            x = 0,
            y = 0,
            w = 32,
            h = 32,
        },
        ["bottom"] = {
            x = 0,
            y = 0,
            w = 32,
            h = 32,
        },
        ["diagonal"] = {
            x = 0,
            y = 0,
            w = 32,
            h = 32,
        },
    }
    
    -- create spritebatches --
    self.bth_ground = love.graphics.newSpriteBatch(self.assets.walls.image, nil, "static")
    local _, _, qw, qh = self.assets.walls.quads["wall_brick"]:getViewport()
    self.qw, self.qh = qw, qh
    createTiles(self)
    updateClickzones(self)
end

function World:cursorInsideWorld(x, y)
    return collision.pointRect( { x = x, y = y }, { x = 32, y = 32, w = self.w * 32, h = self.h * 32 })
end

function World:draw()
    love.graphics.draw(self.bth_ground, 0, 0)
    for k, v in pairs(self.clickzones) do
        love.graphics.rectangle("line", v.x, v.y, v.w, v.h)
    end
end

function World:mousepressed(x, y, button)
    if button == 1 then
        -- resize shit --
        for k, v in pairs(self.clickzones) do
            --love.graphics.rectangle("line", v.x, v.y, v.w, v.h)
            if collision.pointRect( { x = x, y = y }, v) then
                if k == "right" then
                    self.w = self.w + 1
                end
                if k == "bottom" then
                    self.h = self.h + 1
                end
                if k == "diagonal" then
                    self.w = self.w + 1
                    self.h = self.h + 1
                end
                createTiles(self)
                updateClickzones(self)
            end
        end
    end
end

return World