local event_bus = require('main.modules.event_bus_module')
local GAME_STATE = require('main.modules.game_state')

local ERROR_MESSAGE = "Could not add statistics to the statistics service."
local SUCCESS_MESSAGE = "Success send statistic_data to statistic service"

local GAME_STATISTIC = {}

GAME_STATISTIC.EVENTS = {
    on_end_way_wagon = "on_create_wagon",
    on_done_wagon = "on_done_wagon",
    on_fail_wagon = "on_fail_wagon"
}

GAME_STATISTIC.TOTAL_WAGONS = 0
GAME_STATISTIC.DONE_WAGONS = 0
GAME_STATISTIC.FAIL_WAGONS = 0
GAME_STATISTIC.LEVEL = GAME_STATE.LEVEL

local function create_statistic_request(statistic_data, headers, game_name)
    local statistic_url = "https://ocrv-game.ru/statistic/api/v1/statistic"
    local data = json.encode(statistic_data)
    local body = json.encode({
        Data = data,
        GameName = game_name
    })
    http.request(statistic_url, 'POST', function(self, id, response)
        if response.status == 201 then
            print(SUCCESS_MESSAGE)
        else
            print(ERROR_MESSAGE)
        end
    end, headers, body)
end

function GAME_STATISTIC.init()
    event_bus.EVENT_BUS:subscribe(GAME_STATISTIC.EVENTS.on_end_way_wagon, GAME_STATISTIC.increase_total_wagons)
    event_bus.EVENT_BUS:subscribe(GAME_STATISTIC.EVENTS.on_done_wagon, GAME_STATISTIC.increase_done_wagons)
    event_bus.EVENT_BUS:subscribe(GAME_STATISTIC.EVENTS.on_fail_wagon, GAME_STATISTIC.increase_fail_wagons)
    event_bus.EVENT_BUS:subscribe(GAME_STATE.EVENTS.on_finish_level, GAME_STATISTIC.on_finish_level)
    event_bus.EVENT_BUS:subscribe(GAME_STATE.EVENTS.on_change_level, GAME_STATISTIC.set_level)
end

function GAME_STATISTIC.dispose()
    event_bus.EVENT_BUS:unsubscribe(GAME_STATISTIC.EVENTS.on_end_way_wagon, GAME_STATISTIC.increase_total_wagons)
    event_bus.EVENT_BUS:unsubscribe(GAME_STATISTIC.EVENTS.on_done_wagon, GAME_STATISTIC.increase_done_wagons)
    event_bus.EVENT_BUS:unsubscribe(GAME_STATISTIC.EVENTS.on_fail_wagon, GAME_STATISTIC.increase_fail_wagons)
    event_bus.EVENT_BUS:unsubscribe(GAME_STATE.EVENTS.on_finish_level, GAME_STATISTIC.on_finish_level)
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

function GAME_STATISTIC.on_finish_level()
    GAME_STATISTIC:send_statistic({
        total_wagons = GAME_STATISTIC.TOTAL_WAGONS,
        done_wagons = GAME_STATISTIC.DONE_WAGONS,
        fail_wagons = GAME_STATISTIC.FAIL_WAGONS,
        level = GAME_STATISTIC.LEVEL
    })
    GAME_STATISTIC.TOTAL_WAGONS = 0
    GAME_STATISTIC.DONE_WAGONS = 0
    GAME_STATISTIC.FAIL_WAGONS = 0
end

---@param level number
function GAME_STATISTIC.set_level(level)
    GAME_STATISTIC.LEVEL = level
end

function GAME_STATISTIC:send_statistic(statistic_data)
    local game_url = "https://ocrv-game.ru/statistic/api/v1/game"
    local game_name = "wagons_way"
    local headers = {["Content-Type"] = "application/json"}

    http.request(game_url .. "/" .. game_name, 'GET', function(self, id, response) 
        if response.status == 200 then
            create_statistic_request(statistic_data, headers, game_name)
        elseif response.status == 404 then
            local game_body = json.encode({
                Name = game_name,
                Description = "_"
            })
            http.request(game_url, "POST", function (self, id, response)
                if response.status == 201 then
                    create_statistic_request(statistic_data, headers, game_name)
                else
                    print(ERROR_MESSAGE)
                end
            end, headers, game_body)
        end
    end, headers)
end

return GAME_STATISTIC