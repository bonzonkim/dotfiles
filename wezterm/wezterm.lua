local status, wezterm = pcall(require, "wezterm")
if (not status) then return end

return {
  --color_scheme = "Tokyo Night",
  enable_tab_bar = false,
  font = wezterm.font("MesloLGS Nerd Font Mono")
}

