PlayState = {}

function PlayState:enter()
    self.world = require 'game.src.Modules.Game.World'

    self.assets = {
        ["walls"] = {}
    }

    self.assets.walls.image, self.assets.walls.quads = love.graphics.getQuadsFromHash("assets/images/map/walls_sheet")
    
    self.camera = camera.new()
    self.camera.targetZoom = 1
    self.camera.zoomSpeed = 0.03

    self.world:init(self.assets, 16, 16)
end

function PlayState:draw()
    local inside, mx, my = shove.mouseToViewport()
    local mx, my = self.camera:worldCoords(mx, my)

    self.camera:attach()
        self.world:draw()
        love.graphics.setLineWidth(3)
            love.graphics.setColor(239 / 255, 210 / 255, 81 / 255)
                love.graphics.rectangle("line", math.floor(mx / 32) * 32, math.floor(my / 32) * 32, 32, 32)
            love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(1)
    self.camera:detach()
end

function PlayState:update(elapsed)
    self.camera:zoomTo(math.lerp(self.camera.scale, self.camera.targetZoom, 0.1))

    --self.camera.pos.x =
    local speed = 300
    if love.keyboard.isDown("a") then
        self.camera.x = self.camera.x - speed * elapsed
    end
    if love.keyboard.isDown("d") then
        self.camera.x = self.camera.x + speed * elapsed
    end
    if love.keyboard.isDown("w") then
        self.camera.y = self.camera.y - speed * elapsed
    end
    if love.keyboard.isDown("s") then
        self.camera.y = self.camera.y + speed * elapsed
    end

    self.camera.zoomSpeed = love.keyboard.isDown("lctrl") and 0.3 or 0.03

    if self.camera.targetZoom < 0.5 then
        self.camera.zoom = 0.5
        self.camera.targetZoom = 0.5
    elseif self.camera.targetZoom > 2 then
        self.camera.zoom = 2
        self.camera.targetZoom = 2
    end
end

function PlayState:keypressed(k)

end

function PlayState:mousepressed(x, y, button)
    local inside, mx, my = shove.mouseToViewport()
    local mx, my = self.camera:worldCoords(mx, my)

    self.world:mousepressed(mx, my, button)
end

function PlayState:wheelmoved(x, y)
    if y < 0 then
        self.camera.targetZoom = self.camera.targetZoom - 0.03
    end
    if y > 0 then
        self.camera.targetZoom = self.camera.targetZoom + 0.03
    end
end

function PlayState:mousemoved(x, y, dx, dy)
    if love.mouse.isDown(3) then
        self.camera.x = self.camera.x - dx / self.camera.scale
        self.camera.y = self.camera.y - dy / self.camera.scale
    end
end

return PlayState