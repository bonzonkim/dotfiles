local status, codex = pcall(require, "codex")
if not status then return end

codex.setup({
  split = "horizontal",
  size = 0.3,
  float = {
    width = 0.6,
    height = 0.6,
    border = "rounded",
    row = nil,
    col = nil,
    title = "Codex",
  },
  codex_cmd = { "codex" },
  focus_after_send = false,
  log_level = "warn",
  autostart = false,
})

local map = vim.keymap.set

map("n", "<leader>cc", function() require("codex").toggle() end, { desc = "Codex: Toggle" })
map("v", "<leader>cs", function() require("codex").actions.send_selection() end, { desc = "Codex: Send selection" })
