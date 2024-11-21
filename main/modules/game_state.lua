event_bus = require("main.modules.event_bus_module")

GAME_STATE = {}

GAME_STATE.IS_PAUSED = false
GAME_STATE.FINISHED = false
GAME_STATE.STARTED = false
GAME_STATE.LEVEL = 1

GAME_STATE.EVENTS = {
    on_level_pause = "on_level_pause",
    on_level_resume = "on_level_resume",
    on_finish_level = "on_finish_level",
    on_start_level = "on_start_level",
    on_change_level = "on_change_level"
}

---@param value boolean
GAME_STATE.set_is_paused = function (value)
    GAME_STATE.IS_PAUSED = value
    if GAME_STATE.IS_PAUSED == true then
        event_bus.EVENT_BUS:invoke(GAME_STATE.EVENTS.on_level_pause)
    elseif GAME_STATE.IS_PAUSED == false then
        event_bus.EVENT_BUS:invoke(GAME_STATE.EVENTS.on_level_resume)
    end
end

---@param value boolean
GAME_STATE.set_is_finished = function (value)
    GAME_STATE.FINISHED = value
    if GAME_STATE.FINISHED == true then
        event_bus.EVENT_BUS:invoke(GAME_STATE.EVENTS.on_finish_level)
        GAME_STATE.STARTED = false
    end
end

---@param value boolean
GAME_STATE.set_is_started = function (value)
    GAME_STATE.STARTED = value
    if GAME_STATE.STARTED == true then
        event_bus.EVENT_BUS:invoke(GAME_STATE.EVENTS.on_start_level)
        GAME_STATE.FINISHED = false
    end
end

GAME_STATE.set_level = function (value)
    GAME_STATE.LEVEL = value
    event_bus.EVENT_BUS:invoke(GAME_STATE.EVENTS.on_change_level, GAME_STATE.LEVEL)
end

return GAME_STATE