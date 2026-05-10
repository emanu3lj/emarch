-- Plugin management via Neovim 0.12 built-in vim.pack
-- See :help vim.pack

-- Build hooks for plugins that need post-install/update steps.
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("user-pack-build", { clear = true }),
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end

		if name == "telescope-fzf-native.nvim" then
			vim.notify("Building telescope-fzf-native...", vim.log.levels.INFO)
			vim.system({ "make" }, { cwd = ev.data.path }):wait()
		elseif name == "nvim-treesitter" then
			-- Need to packadd first if not yet active so :TSUpdate exists.
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		elseif name == "blink.cmp" then
			-- blink.cmp v2 ships a native fuzzy lib that must be built/downloaded.
			vim.notify("Building blink.cmp...", vim.log.levels.INFO)
			if not ev.data.active then
				vim.cmd.packadd("blink.cmp")
			end
			require("blink.cmp").build():wait(60000)
		end
	end,
})

vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	-- Pin nvim-treesitter to the legacy `master` branch; the new `main`
	-- branch removed `nvim-treesitter.configs` and the `setup()` API.
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	-- blink.cmp v2 requires blink.lib alongside it.
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/folke/which-key.nvim",
})

-- Colorscheme
require("kanagawa").setup({
	compile = false,
	undercurl = true,
	commentStyle = { italic = true },
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	transparent = false,
	dimInactive = false,
	terminalColors = true,
	theme = "wave",
	background = { dark = "wave", light = "lotus" },
})
vim.cmd("colorscheme kanagawa")

-- Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"c_sharp",
		"css",
		"elixir",
		"erlang",
		"javascript",
		"lua",
		"markdown",
		"markdown_inline",
		"query",
		"ruby",
		"vim",
		"vimdoc",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
})

-- Completion
require("blink.cmp").setup({
	keymap = { preset = "default" },
	sources = {
		default = { "lsp", "path", "buffer" },
	},
	completion = {
		documentation = { auto_show = true },
	},
})

-- Telescope
require("telescope").setup({
	defaults = {},
	pickers = { find_files = {} },
	extensions = { fzf = {} },
})
pcall(require("telescope").load_extension, "fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
vim.keymap.set("n", "<leader>fd", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>env", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find in nvim config" })
vim.keymap.set("n", "<leader>ep", function()
	builtin.find_files({ cwd = vim.fn.stdpath("data") .. "/site/pack" })
end, { desc = "Find in installed plugins" })

require("telescope.multigrep").setup()

-- which-key
local wk = require("which-key")
wk.setup({})
wk.add({
	{ "<leader>e", group = "edit/explore" },
	{ "<leader>f", group = "find" },
	{ "<leader>t", group = "terminal/tab" },
	{ "<leader>s", group = "session/search" },
	{ "<leader>c", group = "cd" },
	{ "<leader>b", group = "build" },
	{
		"<leader>?",
		function()
			require("which-key").show({ global = false })
		end,
		desc = "Buffer-local keymaps (which-key)",
	},
})
