local Object = require "main.modules.class"

---@class EventBus
local EventBus = Object:extend()

function EventBus:new()
    self.bus = {}
    self.handlers = {}
end

--- Subscribe to an event.
--
-- Register an event handler.
---@param event string  the event name
---@param handler function the event handler
---@param index integer | nil the index at which to insert the handler (1 is the highest priority)
function EventBus:subscribe(event, handler, index)
    if not event then error('Invalid event name') end
    if type(handler) ~= 'function' then error('Invalid event handler') end
    if not self.handlers[event] then self.handlers[event] = {} end
    self:unsubscribe(event, handler)
    table.insert(self.handlers[event], index or #self.handlers[event] + 1, handler)
end

--- Unsubscribe from an event.
--
-- Remove a registered event handler.
---@param event string the event name
---@param handler function the event handler to unsubscribe
---@return bool whether the handler was successfully removed
function EventBus:unsubscribe(event, handler)
    local h = self.handlers[event]
    if not h then return false end
    for i = 1, #h do
        if h[i] == handler then
            table.remove(h, i)
            return true
        end
    end

    return false
end

--- Generate event.
--
-- Invokes all event handlers in the order they were registered.
-- Passes all arguments to the handler. The first handler which returns a non `nil`
-- value terminates the event propagation. The other handlers will not be called.
--
---@param event string the event name
---@param ... ... the remaining paramters are passed on to the handler
function EventBus:invoke(event, ...)
    local h = self.handlers[event]
    if not h then return end
    for i = 1, #h do
        local ret = h[i](...)
        if type(ret) ~= 'nil' then return ret end
    end
end


return EventBus