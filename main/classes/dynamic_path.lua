Path = require("main.classes.path")

---@class Dynamic_Path
Dynamic_Path = Path:extend()

direction_change_states = {}
direction_change_states.FORWARD = 1
direction_change_states.BACKWARD = -1
function Dynamic_Path:new(path_count, point1, point2, points)
    self.point1 = point1
    self.point2 = point2
    self.points = points
    self.state = 2
    self.path_count = path_count
    self.direction_change_state = direction_change_states.FORWARD
end

function Dynamic_Path:toggle_state()
    self.state = self.state + self.direction_change_state
    if self.state > #self.points then
        self.state = self.state - 2
        self.direction_change_state = direction_change_states.BACKWARD
    elseif self.state < 1 then
        self.state = self.state + 2
        self.direction_change_state = direction_change_states.FORWARD
    end
    self.point2 = self.points[self.state]
end

return Dynamic_Path