---@return boolean|nil
---@return string|nil
function M.save_and_exit()
    return M.execute('{"reactor":{"reactor":{"save_and_exit":{}}}}')
end

---@return boolean|nil
---@return string|nil
function M.debug_layout_tree()
    return M.execute('{"reactor":{"reactor":{"debug":{}}}}')
end

---@return boolean|nil
---@return string|nil
function M.serialize_state()
    return M.execute('{"reactor":{"reactor":{"serialize":{}}}}')
end

---@return boolean|nil
---@return string|nil
function M.toggle_space_activated()
    return M.execute('{"reactor":{"reactor":{"toggle_space_activated":{}}}}')
end

---@return boolean|nil
---@return string|nil
function M.show_timing()
    return M.execute('{"reactor":{"metrics":{"show_timing":{}}}}')
end
