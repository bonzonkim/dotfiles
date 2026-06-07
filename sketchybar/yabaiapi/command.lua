---@param Y YabaiAPI
return function(Y)
    Y.command = {}

    local function exec(s) Y._sbar_get().exec(s) end

    ---@param idx integer
    function Y.command.focus_space(idx)
        exec("yabai -m space --focus " .. tostring(idx))
    end

    function Y.command.create_space()
        exec("yabai -m space --create")
    end

    ---@param idx? integer
    function Y.command.destroy_space(idx)
        if idx then exec("yabai -m space " .. tostring(idx) .. " --destroy")
        else exec("yabai -m space --destroy") end
    end

    ---@param id integer
    function Y.command.focus_window(id)
        exec("yabai -m window --focus " .. tostring(id))
    end
end
