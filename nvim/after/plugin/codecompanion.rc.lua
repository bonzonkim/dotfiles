local status, codecompanion = pcall(require, "codecompanion")
if not status then return end

-- agent id is <plugin.json name>:<agent>; the plugin dir name does not count
local acp_as_agent = { vim.fn.stdpath("config") .. "/bin/claude-agent-acp-as", "omo-slim-agents:orchestrator" }

codecompanion.setup({
  adapters = {
    acp = {
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {
          -- yolo mirrors default: claude-agent-acp 0.23.1 ignores --yolo, and /command must not drop the agent
          commands = { default = acp_as_agent, yolo = acp_as_agent },
          -- unset env var resolves to the literal name and is sent as a bearer token (401); nil keeps the claude CLI login
          env = {
            CLAUDE_CODE_OAUTH_TOKEN = function() return nil end,
            -- the SDK bundles an older claude CLI that skips skills-dir plugins; run the installed one instead
            CLAUDE_CODE_EXECUTABLE = function() return vim.fn.exepath("claude") end,
          },
        })
      end,
    },
  },
  -- inline and cmd accept HTTP adapters only, so they stay on their defaults
  interactions = {
    chat = { adapter = "claude_code" },
  },
})

local map = vim.keymap.set

map({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "CodeCompanion: Toggle chat" })
map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion: Actions" })
map("v", "<leader>as", "<cmd>CodeCompanionChat Add<cr>", { desc = "CodeCompanion: Add selection to chat" })
