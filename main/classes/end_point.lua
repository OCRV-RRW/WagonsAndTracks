Object = require("main.modules.class")

---@class EndPoint
EndPoint = Object:extend()

---@param color number
function EndPoint:new(color)
    self.color = color
end

---@return boolean
function EndPoint:is_valid_wagon(wagon)
    return wagon.color == self.color
end

return EndPoint