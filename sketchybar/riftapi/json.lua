function M._json_str(s)
    return string.format("%q", tostring(s))
end

function M._json_arr(strings)
    if not strings or #strings == 0 then return "[]" end
    local t = {}
    for _, v in ipairs(strings) do
        table.insert(t, M._json_str(v))
    end
    return "[" .. table.concat(t, ",") .. "]"
end

function M._json_opt_int(v)
    return v ~= nil and tostring(v) or "null"
end

function M._json_opt_bool(v)
    if v == nil then return "null" end
    return v and "true" or "false"
end
