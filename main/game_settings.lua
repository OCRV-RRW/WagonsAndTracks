GAME_SETTINGS = {}

GAME_SETTINGS.TIME = 60
GAME_SETTINGS.DONE_WAGONS = 20
GAME_SETTINGS.IS_PAUSED = false

---@param value boolean
GAME_SETTINGS.set_is_paused = function (value)
    GAME_SETTINGS.IS_PAUSED = value
end

return GAME_SETTINGS