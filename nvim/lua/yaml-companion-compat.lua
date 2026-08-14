-- Compatibility shims for yaml-companion.nvim on Neovim 0.12+.
-- The plugin is unmaintained and calls LSP APIs deprecated/removed in 0.12.
-- Modules are replaced via package.preload so plugin updates are unaffected.
-- Require this BEFORE the first require("yaml-companion").

local M = {}

-- Upstream hardcodes Kubernetes schema v1.22.4; pin a newer one.
package.preload["yaml-companion.builtin.kubernetes.version"] = function()
  return "v1.36.0"
end

-- lsp/util.lua used vim.lsp.get_active_clients() and client.request_sync()
package.preload["yaml-companion.lsp.util"] = function()
  local util = {}
  local log = require("yaml-companion.log")
  local sync_timeout = 5000

  util.get_client = function(bufnr)
    return vim.lsp.get_clients({ name = "yamlls", bufnr = bufnr })[1]
  end

  util.request_sync = function(bufnr, method)
    local client = util.get_client(bufnr)
    if not client then return end

    local response, err =
      client:request_sync(method, { vim.uri_from_bufnr(bufnr) }, sync_timeout, bufnr)

    if err then
      log.fmt_error("bufnr=%d error=%s", bufnr, err)
    end
    if response and response.err then
      log.fmt_error("bufnr=%d error=%s", bufnr, response.err)
    end

    return response
  end

  return util
end

-- lsp/handler.lua used vim.lsp.get_buffers_by_client_id()
package.preload["yaml-companion.lsp.handler"] = function()
  local handler = {}
  local log = require("yaml-companion.log")

  handler.store_initialized = function(_, _, req, _)
    local client_id = req.client_id
    require("yaml-companion").ctx.initialized_client_ids[client_id] = true

    local client = vim.lsp.get_client_by_id(client_id)
    if not client then return end

    for bufnr in pairs(client.attached_buffers) do
      log.fmt_debug("client_id=%d bufnr=%d running autodiscover", client_id, bufnr)
      require("yaml-companion").ctx.autodiscover(bufnr, client)
    end
  end

  return handler
end

-- context/init.lua calls client.workspace_did_change_configuration (removed in 0.12)
M.on_attach = function(client)
  if not client.workspace_did_change_configuration then
    client.workspace_did_change_configuration = function(settings)
      return client:notify("workspace/didChangeConfiguration", { settings = settings })
    end
  end
end

-- config.lua's on_init calls the deprecated client.notify(); replace it
M.fix = function(cfg)
  cfg.on_init = function(client)
    client:notify("yaml/supportSchemaSelection", { {} })
    return true
  end
  return cfg
end

return M
