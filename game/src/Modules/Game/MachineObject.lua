local MachineObject = class:extend("MachineObject")

function MachineObject:__construct(id, x, y, rot)
    self.id = id or ""
    self.x = x or 0
    self.y = y or 0
    self.rot = rot or 1
    self.data = {}
end

function MachineObject:draw()end

function MachineObject:update(elapsed)end

return MachineObject