---internal singleton state
---@type RiftClientHandle|nil
local _client = nil

---ensure underlying Mach client exists
---@return RiftClientHandle|nil handle
---@return string|nil err
function M._connect()
    if _client then return _client end
    local c, err = Rift.connect()
    if not c then return nil, err end
    _client = c
    return _client
end

---@return boolean
function M.is_connected()
    return _client ~= nil
end

---get or create mach client
---@return RiftClientHandle|nil handle
---@return string|nil err
function M.get_client()
    if _client then
        local ok, err = _client:reconnect()
        if not ok then return nil, err end
        return ok
    end
    return M._connect()
end

function M.disconnect()
    if _client then
        _client:disconnect()
        _client = nil
    end
end

---send raw json payload and unwrap data / error
---@param json_payload string
---@param await? boolean defaults true
---@return any|nil data
---@return string|nil err
function M.request(json_payload, await)
    local c, err = M.get_client()
    if not c then return nil, err end
    if await == nil then await = true end
    local resp, req_err = c:send_request(json_payload, await)
    if not resp then return nil, req_err end
    if resp.error then
        local info = type(resp.error) == "table" and resp.error.message or tostring(resp.error)
        return nil, info
    end
    return resp.data, nil
end

---send an `execute_command` request
---@param command string must be a json-serialized RiftCommand string.
---@param args? string[]
---@return boolean|nil
---@return string|nil
function M.execute(command, args)
    local p = string.format(
        '{"execute_command":{"command":%s,"args":%s}}',
        M._json_str(command), M._json_arr(args or {})
    )
    local data, err = M.request(p)
    if not data then return nil, err end
    return true
end
