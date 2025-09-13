require("lazy-init")
-- Settings --

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false

vim.opt.swapfile = false -- dont use swapfile
 

-- TAB WIDTH
local tabWidth = 2

vim.opt.softtabstop = tabWidth -- use spaces in place of tabs
vim.opt.shiftwidth = tabWidth -- << >> tabWidth
vim.opt.tabstop = tabWidth -- how wide is tabs displayed?
vim.opt.expandtab = true --insert spaces instead of tabs

vim.opt.scrolloff = 30 -- alwas leaves 30 lines when scroll up and down

--- KEY MAP ---
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>ee', ':Ex<CR>', {desc = "Open file picker in cwd"})
vim.keymap.set('n', '<leader>w', ':w', {desc ="Save file"})

vim.keymap.set('n', '<leader>sor', ':mksession! Session.vim | restart source Session.vim<CR>')



