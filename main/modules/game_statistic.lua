local event_bus = require('main.modules.event_bus_module')
local GAME_STATE = require('main.modules.game_state')

local GAME_STATISTIC = {}

GAME_STATISTIC.EVENTS = {
    on_end_way_wagon = "on_create_wagon",
    on_done_wagon = "on_done_wagon",
    on_fail_wagon = "on_fail_wagon"
}

GAME_STATISTIC.TOTAL_WAGONS = 0
GAME_STATISTIC.DONE_WAGONS = 0
GAME_STATISTIC.FAIL_WAGONS = 0

function GAME_STATISTIC.init()
    event_bus.EVENT_BUS:subscribe(GAME_STATISTIC.EVENTS.on_end_way_wagon, GAME_STATISTIC.increase_total_wagons)
    event_bus.EVENT_BUS:subscribe(GAME_STATISTIC.EVENTS.on_done_wagon, GAME_STATISTIC.increase_done_wagons)
    event_bus.EVENT_BUS:subscribe(GAME_STATISTIC.EVENTS.on_fail_wagon, GAME_STATISTIC.increase_fail_wagons)
    event_bus.EVENT_BUS:subscribe(GAME_STATE.EVENTS.on_finish_game, GAME_STATISTIC.clear_state)
end

function GAME_STATISTIC.dispose()
    event_bus.EVENT_BUS:unsubscribe(GAME_STATISTIC.EVENTS.on_end_way_wagon, GAME_STATISTIC.increase_total_wagons)
    event_bus.EVENT_BUS:unsubscribe(GAME_STATISTIC.EVENTS.on_done_wagon, GAME_STATISTIC.increase_done_wagons)
    event_bus.EVENT_BUS:unsubscribe(GAME_STATISTIC.EVENTS.on_fail_wagon, GAME_STATISTIC.increase_fail_wagons)
    event_bus.EVENT_BUS:unsubscribe(GAME_STATE.EVENTS.on_finish_game, GAME_STATISTIC.clear_state)
end

function GAME_STATISTIC.increase_total_wagons()
    GAME_STATISTIC.TOTAL_WAGONS = GAME_STATISTIC.TOTAL_WAGONS + 1
end

function GAME_STATISTIC.increase_done_wagons()
    GAME_STATISTIC.DONE_WAGONS = GAME_STATISTIC.DONE_WAGONS + 1
end

function GAME_STATISTIC.increase_fail_wagons()
    GAME_STATISTIC.FAIL_WAGONS = GAME_STATISTIC.FAIL_WAGONS + 1
end

function GAME_STATISTIC.clear_state()
    GAME_STATISTIC.TOTAL_WAGONS = 0
    GAME_STATISTIC.DONE_WAGONS = 0
    GAME_STATISTIC.FAIL_WAGONS = 0
end

return GAME_STATISTIC