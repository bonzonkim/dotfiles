local colors   = require("colors")
local settings = require("settings")
local Yabai    = require("yabaiapi")

local MAX_WS   = 10
local MAX_APPS = 12

Yabai.attach(Sbar)
Yabai.register_events()

---@type WsSlot[]
local slots = {}

local function name_num(i) return "yabai.ws." .. i .. ".num" end
local function name_app(i, j) return "yabai.ws." .. i .. ".app." .. j end
local function name_brk(i) return "yabai.ws." .. i .. ".bracket" end

local function make_num(i)
    local item = Sbar.add("space", name_num(i), {
        associated_space = i,
        icon = {
            string          = tostring(i),
            font            = { family = settings.font.text_round, style = "Bold", size = 12.0 },
            color           = colors.grey,
            highlight_color = colors.white,
            padding_left    = 4,
            padding_right   = 4,
            y_offset        = 1,
        },
        label = { drawing = false },
    })
    item:subscribe("mouse.clicked", function(env)
        if env.BUTTON == "right" then
            Yabai.command.create_space()
        else
            Yabai.command.focus_space(i)
        end
    end)
    item:subscribe("space_change", function(env)
        local active = env.SELECTED == "true"
        Sbar.animate("circ", 30, function()
            item:set({ icon = { highlight = active } })
            local slot = slots[i]
            if slot then
                slot.bracket:set({ background = { drawing = active } })
                for j = 1, MAX_APPS do
                    slot.apps[j]:set({ background = { image = { scale = active and 1 or 0.80 } } })
                end
            end
        end)
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
            drawing       = false,
            color         = colors.bg05,
            border_color  = colors.bg1,
            blur_radius   = 32,
            border_width  = 1,
            height        = 32,
            corner_radius = 10,
        },
    })
end

local function build_pool()
    for i = 1, MAX_WS do
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

local function paint_slot(i, apps, active)
    local slot = slots[i]
    if not slot then return end
    for j = 1, MAX_APPS do
        local app = apps[j]
        local item = slot.apps[j]
        if app then
            item:set({
                drawing    = true,
                background = {
                    drawing     = true,
                    blur_radius = 12,
                    image       = {
                        string = "app." .. app,
                        scale  = active and 1 or 0.80,
                        clip   = 0.8,
                    },
                    x_offset    = -1,
                },
            })
        else
            item:set({ drawing = false })
        end
    end
end

local function hide_slot(i)
    local slot = slots[i]
    if not slot then return end
    for j = 1, MAX_APPS do slot.apps[j]:set({ drawing = false }) end
    slot.bracket:set({ background = { drawing = false } })
end

local function refresh()
    Yabai.query.layout(function(layout, err)
        if err then print("[yabai] " .. tostring(err)); return end
        if not layout then return end
        Sbar.animate("circ", 30, function()
            for i = 1, MAX_WS do
                local s = layout[i]
                if s then
                    paint_slot(i, s.apps, s.has_focus)
                    local slot = slots[i]
                    if slot then
                        slot.bracket:set({ background = { drawing = s.has_focus } })
                    end
                else
                    hide_slot(i)
                end
            end
        end)
    end)
end

local watcher = Sbar.add("item", "yabai.watcher", {
    drawing       = false,
    updates       = true,
    padding_left  = 0,
    padding_right = 0,
})

-- Coalesce bursts of yabai events into a single refresh. On wake every window
-- re-registers and fires a storm of events; without debounce each one spawns
-- its own queries + 30-frame animation, which is the wake lag spike.
local refresh_pending = false
local function schedule_refresh()
    if IS_SYSTEM_SLEEPING then return end
    if refresh_pending then return end
    refresh_pending = true
    Sbar.delay(0.12, function()
        refresh_pending = false
        refresh()
    end)
end

-- We now draw only the focused app per space, so focus changes must re-render
-- too. The yabai_* signals are not wired into sketchybar, so rely on
-- sketchybar's native events (front_app_switched / space_windows_change /
-- space_change) which fire without any yabai signal plumbing.
local layout_events = { table.unpack(Yabai.events.for_layout_refresh) }
for _, e in ipairs(Yabai.events.for_focus) do
    table.insert(layout_events, e)
end
table.insert(layout_events, "front_app_switched")
table.insert(layout_events, "space_windows_change")
table.insert(layout_events, "space_change")
table.insert(layout_events, "forced")

watcher:subscribe(layout_events, function(_) schedule_refresh() end)

-- Wake gets dedicated handling: yabai and the displays need a moment to settle,
-- and the bar can fail to redraw. Wait, re-assert the bar, then refresh once.
watcher:subscribe("system_woke", function(_)
    Sbar.delay(1.0, function()
        Sbar.bar({ hidden = false })
        refresh()
    end)
end)

Sbar.delay(0.5, function()
    build_pool()
    refresh()
end)
