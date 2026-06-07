---@class YabaiEvents
---@field application_launched         "yabai_application_launched"
---@field application_terminated       "yabai_application_terminated"
---@field application_front_switched   "yabai_application_front_switched"
---@field application_activated        "yabai_application_activated"
---@field application_deactivated      "yabai_application_deactivated"
---@field application_visible          "yabai_application_visible"
---@field application_hidden           "yabai_application_hidden"
---@field window_created               "yabai_window_created"
---@field window_destroyed             "yabai_window_destroyed"
---@field window_focused               "yabai_window_focused"
---@field window_moved                 "yabai_window_moved"
---@field window_resized               "yabai_window_resized"
---@field window_minimized             "yabai_window_minimized"
---@field window_deminimized           "yabai_window_deminimized"
---@field window_title_changed         "yabai_window_title_changed"
---@field space_created                "yabai_space_created"
---@field space_destroyed              "yabai_space_destroyed"
---@field space_changed                "yabai_space_changed"
---@field display_added                "yabai_display_added"
---@field display_removed              "yabai_display_removed"
---@field display_moved                "yabai_display_moved"
---@field display_resized              "yabai_display_resized"
---@field display_changed              "yabai_display_changed"
---@field mission_control_enter        "yabai_mission_control_enter"
---@field mission_control_exit         "yabai_mission_control_exit"
---@field dock_did_change_pref         "yabai_dock_did_change_pref"
---@field dock_did_restart             "yabai_dock_did_restart"
---@field menu_bar_hidden_changed      "yabai_menu_bar_hidden_changed"
---@field all                          string[]
---@field for_layout_refresh           string[]
---@field for_focus                    string[]
---@field for_display                  string[]

local function ev(name) return "yabai_" .. name end

local E = {
    application_launched       = ev("application_launched"),
    application_terminated     = ev("application_terminated"),
    application_front_switched = ev("application_front_switched"),
    application_activated      = ev("application_activated"),
    application_deactivated    = ev("application_deactivated"),
    application_visible        = ev("application_visible"),
    application_hidden         = ev("application_hidden"),
    window_created             = ev("window_created"),
    window_destroyed           = ev("window_destroyed"),
    window_focused             = ev("window_focused"),
    window_moved               = ev("window_moved"),
    window_resized             = ev("window_resized"),
    window_minimized           = ev("window_minimized"),
    window_deminimized         = ev("window_deminimized"),
    window_title_changed       = ev("window_title_changed"),
    space_created              = ev("space_created"),
    space_destroyed            = ev("space_destroyed"),
    space_changed              = ev("space_changed"),
    display_added              = ev("display_added"),
    display_removed            = ev("display_removed"),
    display_moved              = ev("display_moved"),
    display_resized            = ev("display_resized"),
    display_changed            = ev("display_changed"),
    mission_control_enter      = ev("mission_control_enter"),
    mission_control_exit       = ev("mission_control_exit"),
    dock_did_change_pref       = ev("dock_did_change_pref"),
    dock_did_restart           = ev("dock_did_restart"),
    menu_bar_hidden_changed    = ev("menu_bar_hidden_changed"),
}
E.all = {}

for _, v in pairs(E) do
    if type(v) == "string" then table.insert(E.all, v) end
end

table.sort(E.all)

E.for_layout_refresh = {
    E.application_launched,
    E.application_terminated,
    E.application_visible,
    E.application_hidden,
    E.window_created,
    E.window_destroyed,
    E.window_moved,
    E.window_minimized,
    E.window_deminimized,
    E.space_created,
    E.space_destroyed,
}

E.for_focus = {
    E.window_focused,
    E.application_front_switched,
    E.application_activated,
}

E.for_display = {
    E.display_added,
    E.display_removed,
    E.display_moved,
    E.display_resized,
    E.display_changed,
}

return E
