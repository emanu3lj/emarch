-- Entry point. Order matters:
--  1. leader keys must be set before plugins load
--  2. plugins (vim.pack.add) before anything that requires them
--  3. mason after plugins so its rtp is in place
--  4. lsp after mason so binaries exist (or are queued for install)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.plugins")
require("config.mason")
require("config.lsp")
require("config.audocmd")
require("config.keymaps")
require("terminal")
