local mach = require 'src.Modules.Game.MachineObject'

local Dispenser = mach:extend("Dispenser")

function Dispenser:__construct(x, y, rot)
    Dispenser.super.new(self, "dispenser", x, y, rot)
end

function Dispenser:draw()
    
end

function Dispenser:update(elapsed)
    
end

return Dispenser