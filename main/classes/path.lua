Object = require("main.modules.class")

---@class Path
Path = Object:extend()

function Path:new(point1, point2, points)
    self.state = 0
    self.point1 = point1
    self.point2 = point2
    self.points = points
end

function Path:get_state()
    return self.state
end

function Path:get_destination_point(point) 
    if point == self.point1 then
        return self.point2
    elseif point == self.point2 then
        return self.point1
    end
end

return Path