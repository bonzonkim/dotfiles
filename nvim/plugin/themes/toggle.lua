-- wezterm ctrl+q writes "light"/"dark" here; nvim follows it so both switch together
local state_file = vim.fn.expand("~/.local/state/theme-mode")
local state_dir = vim.fn.fnamemodify(state_file, ":h")

local function read_mode()
  local ok, lines = pcall(vim.fn.readfile, state_file)
  if ok and lines[1] == "light" then
    return "light"
  end
  return "dark"
end

local current

local function apply(mode)
  if mode == current then
    return
  end
  current = mode
  if mode == "light" then
    vim.o.background = "light"
    vim.cmd("colorscheme PaperColor")
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme tokyonight")
  end
end

local ok, tokyonight = pcall(require, "tokyonight")
if ok then
  tokyonight.setup({
    style = "night",
    light_style = "day",
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "dark",
      floats = "dark",
    },
    sidebars = { "qf", "help" },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = false,
  })
end

apply(read_mode())

local function sync()
  apply(read_mode())
end

-- fs_event on the directory survives the file being recreated, a watch on the file itself would not
vim.fn.mkdir(state_dir, "p")
local uv = vim.uv or vim.loop
local watcher = uv.new_fs_event()
if watcher then
  watcher:start(state_dir, {}, vim.schedule_wrap(function(_, filename)
    if filename == nil or filename == vim.fn.fnamemodify(state_file, ":t") then
      sync()
    end
  end))
end

-- fallback for terminals that never deliver the fs_event (e.g. nvim running over ssh/tmux)
vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, { callback = sync })

vim.api.nvim_create_user_command("ThemeSync", sync, {})
