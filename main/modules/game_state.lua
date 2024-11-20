event_bus = require("main.modules.event_bus_module")

GAME_STATE = {}

GAME_STATE.IS_PAUSED = false
GAME_STATE.FINISHED = false
GAME_STATE.STARTED = false

GAME_STATE.EVENTS = {
    on_game_pause = "on_game_pause",
    on_game_resume = "on_game_resume",
    on_finish_game = "on_finish_game",
    on_start_game = "on_start_game"
}

---@param value boolean
GAME_STATE.set_is_paused = function (value)
    GAME_STATE.IS_PAUSED = value
    if GAME_STATE.IS_PAUSED == true then
        event_bus.EVENT_BUS:invoke(GAME_STATE.EVENTS.on_game_pause)
    elseif GAME_STATE.IS_PAUSED == false then
        event_bus.EVENT_BUS:invoke(GAME_STATE.EVENTS.on_game_resume)
    end
end

---@param value boolean
GAME_STATE.set_is_finished = function (value)
    GAME_STATE.FINISHED = value
    if GAME_STATE.FINISHED == true then
        event_bus.EVENT_BUS:invoke(GAME_STATE.EVENTS.on_finish_game)
        GAME_STATE.STARTED = false
    end
end

---@param value boolean
GAME_STATE.set_is_started = function (value)
    GAME_STATE.STARTED = value
    if GAME_STATE.STARTED == true then
        event_bus.EVENT_BUS:invoke(GAME_STATE.EVENTS.on_start_game)
        GAME_STATE.FINISHED = false
    end
end

return GAME_STATE