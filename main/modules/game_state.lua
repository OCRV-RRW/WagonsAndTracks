event_bus = require("main.modules.event_bus_module")

GAME_STATE = {}

GAME_STATE.IS_PAUSED = false

---@param value boolean
GAME_STATE.set_is_paused = function (value)
    GAME_STATE.IS_PAUSED = value
    if GAME_STATE.IS_PAUSED == true then
        event_bus.EVENT_BUS:invoke("on_game_pause")
    elseif GAME_STATE.IS_PAUSED == false then
        event_bus.EVENT_BUS:invoke("on_game_resume")
    end
end

return GAME_STATE