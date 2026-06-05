M.window = {}

---@return boolean|nil
---@return string|nil
function M.window.next()
    return M.execute('{"reactor":{"layout":{"next_window":{}}}}')
end

---@return boolean|nil
---@return string|nil
function M.window.prev()
    return M.execute('{"reactor":{"layout":{"prev_window":{}}}}')
end

---@param direction "left"|"right"|"up"|"down"
---@return boolean|nil
---@return string|nil
function M.window.focus(direction)
    local cmd = string.format('{"reactor":{"layout":{"move_focus":%s}}}', M._json_str(direction))
    return M.execute(cmd)
end

---@return boolean|nil
---@return string|nil
function M.window.toggle_float()
    return M.execute('{"reactor":{"layout":{"toggle_window_floating":{}}}}')
end

---@return boolean|nil
---@return string|nil
function M.window.toggle_fullscreen()
    return M.execute('{"reactor":{"layout":{"toggle_fullscreen":{}}}}')
end

---@return boolean|nil
---@return string|nil
function M.window.toggle_fullscreen_within_gaps()
    return M.execute('{"reactor":{"layout":{"toggle_fullscreen_within_gaps":{}}}}')
end

---@return boolean|nil
---@return string|nil
function M.window.resize_grow()
    return M.execute('{"reactor":{"layout":{"resize_window_grow":{}}}}')
end

---@return boolean|nil
---@return string|nil
function M.window.resize_shrink()
    return M.execute('{"reactor":{"layout":{"resize_window_shrink":{}}}}')
end

---@param amount number positive = grow, negative = shrink (fraction of current size)
---@return boolean|nil
---@return string|nil
function M.window.resize_by(amount)
    local cmd = string.format('{"reactor":{"layout":{"resize_window_by":{"amount":%.6f}}}}', amount)
    return M.execute(cmd)
end

---@param window_id string numeric or hex (e.g. "0x1234")
---@return boolean|nil
---@return string|nil
function M.window.close(window_id)
    local wsid = window_id:match("^0x") and window_id or tonumber(window_id)
    local val = type(wsid) == "number" and tostring(wsid) or M._json_str(wsid)
    local cmd = string.format('{"reactor":{"reactor":{"close_window":{"window_server_id":%s}}}}', val)
    return M.execute(cmd)
end
