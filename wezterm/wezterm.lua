local status, wezterm = pcall(require, "wezterm")
if (not status) then return end

local act = wezterm.action

-- nvim watches this file, so writing it here is what keeps both themes in sync
local theme_state_file = wezterm.home_dir .. "/.local/state/theme-mode"
local light_scheme = "Catppuccin Latte (Gogh)"
local dark_scheme = "kanagawabones"
--local dark_scheme = "Tokyo Night Storm"

local function read_mode()
  local f = io.open(theme_state_file, "r")
  if not f then return "dark" end
  local mode = f:read("*l")
  f:close()
  return mode == "light" and "light" or "dark"
end

local function write_mode(mode)
  local f = io.open(theme_state_file, "w")
  if not f then
    os.execute("mkdir -p " .. theme_state_file:match("(.*)/"))
    f = io.open(theme_state_file, "w")
  end
  if not f then
    wezterm.log_error("cannot write " .. theme_state_file)
    return
  end
  f:write(mode .. "\n")
  f:close()
end

local function scheme_for(mode)
  return mode == "light" and light_scheme or dark_scheme
end

function Toggle_theme (window, pane)
  local mode = read_mode() == "light" and "dark" or "light"
  write_mode(mode)
  local overrides = window:get_config_overrides() or {}
  overrides.color_scheme = scheme_for(mode)
  window:set_config_overrides(overrides)
end

-- toggle light/dark scheme with CTRL+q
wezterm.on("toggle-dark-mode", function(window,pane)
  Toggle_theme(window, pane)
end)

return {
  color_scheme = scheme_for(read_mode()),
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
      key = "q",
      mods = "CTRL",
      action = wezterm.action 
      {
        EmitEvent = "toggle-dark-mode"
      },
    },
    {
    key = 'Enter',
    mods = 'CTRL',
    -- Send a standard line feed or map to a specific action
    action = wezterm.action.SendString('\n'),
  },
  }
}
