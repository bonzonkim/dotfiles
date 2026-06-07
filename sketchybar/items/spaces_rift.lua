local colors   = require("colors")
local settings = require("settings")

---@type RiftAPI
local rift     = require("riftapi")

local MAX_WS   = 10
local MAX_APPS = 12

---@class WsSlot
---@field num     SbarItem
---@field apps    SbarItem[]
---@field bracket SbarItem

---@type WsSlot[]
local slots    = {}

local function name_num(i) return "rift.ws." .. i .. ".num" end
local function name_app(i, j) return "rift.ws." .. i .. ".app." .. j end
local function name_brk(i) return "rift.ws." .. i .. ".bracket" end

local function make_num(i)
    local item = Sbar.add("item", name_num(i), {
        drawing = false,
        icon = {
            string        = tostring(i + 1),
            font          = { family = settings.font.text_round, style = "Bold", size = 12.0 },
            color         = colors.grey,
            padding_left  = 4,
            padding_right = 4,
            y_offset      = 1,
        },
        label = { drawing = false },
    })
    item:subscribe("mouse.clicked", function(env)
        if env.BUTTON == "right" then
            rift.workspace.create()
        else
            rift.workspace.switch(i)
        end
    end)
    return item
end

local function make_app(i, j)
    return Sbar.add("item", name_app(i, j), {
        drawing       = false,
        icon          = { drawing = false },
        label         = { drawing = false },
        padding_left  = 2,
        padding_right = 2,
        background    = {
            drawing = true,
            image   = { scale = 0.80, clip = 0.8 },
        },
    })
end

local function make_bracket(i, members)
    return Sbar.add("bracket", name_brk(i), members, {
        blur_radius = 12,
        background  = {
            drawing       = true,
            color         = colors.bg05,
            border_color  = colors.bg1,
            blur_radius = 32,
            border_width  = 1,
            height        = 32,
            corner_radius = 10,
        },
    })
end

local function build_pool()
    for i = 0, MAX_WS - 1 do
        local num = make_num(i)
        local apps = {}
        local members = { num.name }
        for j = 1, MAX_APPS do
            apps[j] = make_app(i, j)
            members[#members + 1] = apps[j].name
        end
        local bracket = make_bracket(i, members)
        slots[i] = { num = num, apps = apps, bracket = bracket }
    end
end

---@param ws RiftWorkspace
---@param slot WsSlot
local function paint(ws, slot)
    local active = ws.is_active
    local wins   = ws.windows or {}

    slot.num:set({
        drawing = true,
        icon    = { color = active and colors.white or colors.grey },
    })

    for j = 1, MAX_APPS do
        local win = wins[j]
        local item = slot.apps[j]
        if win then
            local app = win.app_name or "?"
            item:set({
                drawing    = true,
                background = {
                    drawing = true,
                    blur_radius = 12,
                    image = { string = "app." .. app, scale = active and 1 or 0.80, },
                    x_offset = -1,
                },
            })
        else
            item:set({ drawing = false })
        end
    end

    slot.bracket:set({
        background = {
            drawing = active,
            -- border_color = active and colors.blue or colors.bg2,
        },
    })
end

local function hide(slot)
    slot.num:set({ drawing = false })
    for j = 1, MAX_APPS do
        slot.apps[j]:set({ drawing = false })
    end
    slot.bracket:set({ background = { drawing = false } })
end

---@param ws_list RiftWorkspace[]
local function render(ws_list)
    local seen = {}
    for _, ws in ipairs(ws_list) do
        local i = ws.index
        local slot = slots[i]
        if slot then
            paint(ws, slot)
            seen[i] = true
        else
            print(string.format("[rift] workspace index %d exceeds MAX_WS=%d", i, MAX_WS))
        end
    end
    for i = 0, MAX_WS - 1 do
        if not seen[i] then hide(slots[i]) end
    end
end

local function refresh()
    local ws_list, err = rift.query.workspaces()
    if not ws_list then
        print("[rift] " .. tostring(err))
        return
    end
    render(ws_list)
end

Sbar.delay(0.5, function()
    build_pool()

    local watcher = Sbar.add("item", "rift.watcher", {
        drawing       = false,
        padding_left  = 0,
        padding_right = 0,
    })

    watcher:subscribe(
        { "front_app_switched", "space_change", "system_woke", "forced" },
        function(_)
            Sbar.animate("circ", 30, refresh)
        end
    )

    rift.subscribe({ "*" }, function(_) Sbar.animate("circ", 30, refresh) end)

    refresh()
end)
