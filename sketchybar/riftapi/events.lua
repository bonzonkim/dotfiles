---subscribe to Mach IPC events
---@param events string[]
---@param callback fun(env: RiftEvent)
---@return boolean|nil
---@return string|nil
function M.subscribe(events, callback)
    local c, err = M._connect()
    if not c then return nil, err end
    return c:subscribe(events, callback)
end

---unsubscribe from a single event.
---@param event string
---@return boolean|nil
---@return string|nil
function M.unsubscribe(event)
    local c, err = M._connect()
    if not c then return nil, err end
    return c:unsubscribe(event)
end
