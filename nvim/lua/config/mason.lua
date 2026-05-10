-- Mason: install LSP servers and tools
-- To add a new server: append its Mason package name below and add the
-- matching LSP config name to vim.lsp.enable() in lua/config/lsp.lua.

require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"typescript-language-server",
		"rust-analyzer",
		"gopls",
		"pyright",
		"clangd",
		"elixir-ls",
		"omnisharp",
		"stylua",
	},
	auto_update = false,
	run_on_start = true,
})
