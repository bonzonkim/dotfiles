M.display = {}

---@param direction? "left"|"right"|"up"|"down"
---@param index? integer
---@param uuid? string
---@return boolean|nil
---@return string|nil
function M.display.focus(direction, index, uuid)
    local sel
    if direction then
        sel = string.format('{"direction":%s}', M._json_str(direction))
    elseif index then
        sel = string.format('{"index":%d}', index)
    elseif uuid then
        sel = string.format('{"uuid":%s}', M._json_str(uuid))
    else
        return nil, "display.focus requires direction, index, or uuid"
    end
    local cmd = string.format('{"reactor":{"reactor":{"focus_display":%s}}}', sel)
    return M.execute(cmd)
end

---@param index integer
---@return boolean|nil
---@return string|nil
function M.display.move_mouse_to_index(index)
    local cmd = string.format('{"reactor":{"reactor":{"move_mouse_to_display":{"index":%d}}}}', index)
    return M.execute(cmd)
end

---@param uuid string
---@return boolean|nil
---@return string|nil
function M.display.move_mouse_to_uuid(uuid)
    local cmd = string.format('{"reactor":{"reactor":{"move_mouse_to_display":{"uuid":%s}}}}', M._json_str(uuid))
    return M.execute(cmd)
end

---@param direction? "left"|"right"|"up"|"down"
---@param index? integer one of
---@param uuid? string one of
---@param window_id? integer one of
---@return boolean|nil
---@return string|nil
function M.display.move_window(direction, index, uuid, window_id)
    local sel
    if direction then
        sel = string.format('{"direction":%s}', M._json_str(direction))
    elseif index then
        sel = string.format('{"index":%d}', index)
    elseif uuid then
        sel = string.format('{"uuid":%s}', M._json_str(uuid))
    else
        return nil, "display.move_window requires direction, index, or uuid"
    end
    local wid = window_id ~= nil and string.format(',"window_id":%d', window_id) or ""
    local cmd = string.format('{"reactor":{"reactor":{"move_window_to_display":{"selector":%s%s}}}}', sel, wid)
    return M.execute(cmd)
end
