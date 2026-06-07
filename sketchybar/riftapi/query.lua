M.query = {}

---@param space_id? integer
---@return RiftWorkspace[]|nil
---@return string|nil
function M.query.workspaces(space_id)
    local p = string.format('{"get_workspaces":{"space_id":%s}}', M._json_opt_int(space_id))
    return M.request(p)
end

---@param space_id? integer
---@return table[]|nil windows
---@return string|nil err
function M.query.windows(space_id)
    local p = string.format('{"get_windows":{"space_id":%s}}', M._json_opt_int(space_id))
    return M.request(p)
end

---@return RiftDisplay[]|nil
---@return string|nil
function M.query.displays()
    return M.request('{"get_displays":{}}')
end

---@param window_id string e.g. `WindowId { pid: 123, idx: 456 }`
---@return table|nil
---@return string|nil
function M.query.window_info(window_id)
    local p = string.format('{"get_window_info":{"window_id":%s}}', M._json_str(window_id))
    return M.request(p)
end

---@param space_id integer
---@return RiftLayoutState|nil
---@return string|nil
function M.query.layout_state(space_id)
    local p = string.format('{"get_layout_state":{"space_id":%s}}', tostring(space_id))
    return M.request(p)
end

---@param space_id? integer
---@param workspace_id? integer
---@return table|nil
---@return string|nil
function M.query.workspace_layouts(space_id, workspace_id)
    local p = string.format(
        '{"get_workspace_layouts":{"space_id":%s,"workspace_id":%s}}',
        M._json_opt_int(space_id), M._json_opt_int(workspace_id)
    )
    return M.request(p)
end

---@return RiftApplication[]|nil
---@return string|nil
function M.query.applications()
    return M.request('{"get_applications":{}}')
end

---@return RiftMetrics|nil
---@return string|nil
function M.query.metrics()
    return M.request('{"get_metrics":{}}')
end

---@return RiftConfig|nil
---@return string|nil
function M.query.config()
    return M.request('{"get_config":{}}')
end
