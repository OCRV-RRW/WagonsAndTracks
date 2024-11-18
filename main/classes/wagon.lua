Object = require("main.modules.class")

---@class Wagon
Wagon = Object:extend()

function Wagon:new(color)
    self.color = color
    self.start_path_point = nil
    self.end_path_point = nil
    self.destination_pos = vmath.vector3()
end

---@return vector3
function Wagon:get_destination_pos()
    return self.destination_pos
end

function Wagon:set_destination_pos(new_pos)
    self.destination_pos = new_pos
end

return Wagon