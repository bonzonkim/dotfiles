local status, wezterm = pcall(require, "wezterm")
if (not status) then return end

local act = wezterm.action

function Toggle_theme (window, pane)
  local light_scheme = "Catppuccin Latte (Gogh)"
  local dark_scheme = "kanagawabones"
  local overrides = window:get_config_overrides() or {}
  wezterm.log_info("Current color scheme is: ", overrides.color_scheme)

  if (overrides.color_scheme == light_scheme) then
    wezterm.log_info("Current color scheme is: ", overrides.color_scheme)
    overrides.color_scheme = dark_scheme

  else
    wezterm.log_info("Setting to Light ", overrides.color_scheme)
    overrides.color_scheme = light_scheme
  end
  window:set_config_overrides(overrides)
end

-- toggle light/dark scheme with CTRL+l
wezterm.on("toggle-dark-mode", function(window,pane)
  Toggle_theme(window, pane)
end)

return {
  color_scheme = "kanagawabones",
  enable_tab_bar = false,
  font = wezterm.font("MesloLGS Nerd Font", {weight="Bold", stretch="Normal", style="Normal"}),
  font_size = 18.0,

  -- Transparency and blur settings
  window_background_opacity = 0.9,
  text_background_opacity = 1.0,
  macos_window_background_blur = 18,

  window_decorations = "RESIZE",

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  -- Keybindings
  keys = {
    -- Jump cursor by word
    -- Rebind OPT-Left as ALT-b to match Terminal.app behavior
    {
      key = 'LeftArrow',
      mods = 'OPT',
      action = act.SendKey {
        key = 'b',
        mods = 'ALT',
      },
    },
    -- Rebind OPT-Right as ALT-f to match Terminal.app behavior
    {
      key = 'RightArrow',
      mods = 'OPT',
      action = act.SendKey {
        key = 'f',
        mods = 'ALT',
      },
    },
    {
      key="q", mods="CTRL", action=wezterm.action{EmitEvent="toggle-dark-mode"},
    },
  }
}
