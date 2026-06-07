---@meta
---yabai integration module

require("yabaiapi.types")

---@type YabaiAPI
local Y = {}

---@type SbarModule|nil
Y._sbar = nil

---@param sbar SbarModule
function Y.attach(sbar)
    Y._sbar = sbar
end

---@return SbarModule
local function sbar()
    if not Y._sbar then error("yabai: call yabai.attach(sbar) before using the module", 3) end
    return Y._sbar
end
Y._sbar_get = sbar

---@param args string
---@param cb   fun(result: any, err?: string)
function Y.cli(args, cb)
    sbar().exec("yabai -m " .. args, function(result, exit_code)
        if exit_code and exit_code ~= 0 then
            return cb(nil, "yabai exited " .. tostring(exit_code))
        end
        if result == nil then return cb(nil, "empty yabai output") end
        cb(result)
    end)
end

require("yabaiapi.query")(Y)
require("yabaiapi.command")(Y)
Y.events = require("yabaiapi.events")

function Y.register_events()
    local s = sbar()
    for _, name in ipairs(Y.events.all) do
        s.add("event", name)
    end
end

return Y
