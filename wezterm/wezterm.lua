local status, wezterm = pcall(require, "wezterm")
if (not status) then return end

local act = wezterm.action

return {
--  color_scheme = "Solarized (dark) (terminal.sexy)",
  color_scheme = "TokyoNight (dark)",
  enable_tab_bar = false,
  font = wezterm.font("MesloLGS Nerd Font", {weight="Bold", stretch="Normal", style="Normal"}),
  font_size = 15.0,

  -- Transparency and blur settings
  window_background_opacity = 0.8,
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
  }
}
