-- Keymaps (leader is set in init.lua before plugins load)

local map = vim.keymap.set

map("n", "<leader>ee", ":Ex<CR>", { desc = "Open file picker in cwd" })
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })

map(
	"n",
	"<leader>sor",
	":mksession! Session.vim | restart source Session.vim<CR>",
	{ desc = "Save session and restart" }
)

map("n", "grr", vim.lsp.buf.references, { desc = "LSP references" })

map("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Quickfix next" })
map("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Quickfix prev" })

map("n", "<leader>cd", ":lcd %:p:h<CR>", { desc = "Change local dir to file path" })
map("n", "tn", ":tabnew<CR>", { desc = "New tab" })
map("n", "tq", ":tabclose<CR>", { desc = "Close tab" })
