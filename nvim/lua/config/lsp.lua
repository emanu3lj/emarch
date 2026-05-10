-- LSP configuration using Neovim 0.11+ vim.lsp.config / vim.lsp.enable
--
-- Per-server overrides live in lsp/<name>.lua at the config root.
-- nvim-lspconfig provides default lsp/<name>.lua files which are merged
-- under ours (after/lsp/ has higher priority but plain lsp/ in our config
-- wins over the plugin's because of runtimepath ordering for the user
-- config). See :help lsp-config-merge.

-- Global defaults applied to every server.
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink and blink.get_lsp_capabilities then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Format-on-save (only when the server supports formatting and does not
-- already provide willSaveWaitUntil).
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    if
        client:supports_method("textDocument/formatting")
        and not client:supports_method("textDocument/willSaveWaitUntil")
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("user-lsp-format-" .. ev.buf, { clear = true }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-- Enable servers. Each name matches an lsp/<name>.lua file (ours or
-- nvim-lspconfig's preset).
vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "rust_analyzer",
  "gopls",
  "pyright",
  "clangd",
  "elixirls",
  "omnisharp",
})
