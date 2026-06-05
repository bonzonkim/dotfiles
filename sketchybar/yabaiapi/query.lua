-- Read-only yabai queries. All async via the bound sbar.

---@param Y YabaiAPI
return function(Y)
    Y.query = {}

    ---@param cb fun(spaces: YabaiSpace[]|nil, err?: string)
    function Y.query.spaces(cb)   Y.cli("query --spaces",   cb) end

    ---@param cb fun(windows: YabaiWindow[]|nil, err?: string)
    function Y.query.windows(cb)  Y.cli("query --windows",  cb) end

    ---@param cb fun(displays: YabaiDisplay[]|nil, err?: string)
    function Y.query.displays(cb) Y.cli("query --displays", cb) end

    ---@param w YabaiWindow
    ---@return boolean
    function Y.query.is_real_window(w)
        if not w then return false end
        if w["is-minimized"] then return false end
        if w["subrole"] and w["subrole"] ~= "AXStandardWindow" then return false end
        if not w.space or w.space < 1 then return false end
        return true
    end

    ---@param cb fun(wins: YabaiRealWindow[]|nil, err?: string)
    function Y.query.real_windows(cb)
        Y.query.windows(function(wins, err)
            if not wins then return cb(nil, err) end
            ---@type YabaiRealWindow[]
            local out = {}
            for _, w in ipairs(wins) do
                if Y.query.is_real_window(w) then
                    table.insert(out, { space = w.space, app = w.app, id = w.id })
                end
            end
            table.sort(out, function(a, b)
                if a.space ~= b.space then return a.space < b.space end
                return a.id < b.id
            end)
            cb(out)
        end)
    end

    ---@param cb fun(layout: YabaiLayout|nil, err?: string)
    function Y.query.layout(cb)
        Y.query.spaces(function(spaces, serr)
            if not spaces then return cb(nil, serr) end
            Y.query.real_windows(function(wins, werr)
                if not wins then return cb(nil, werr) end
                ---@type YabaiLayout
                local layout = {}
                for _, s in ipairs(spaces) do
                    layout[s.index] = { has_focus = s["has-focus"] == true, apps = {} }
                end
                for _, w in ipairs(wins) do
                    local slot = layout[w.space]
                    if slot then table.insert(slot.apps, w.app) end
                end
                cb(layout)
            end)
        end)
    end
end
