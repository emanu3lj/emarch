return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      local blink = require("blink.cmp")

      blink.setup({
        keymap = { preset = "default" },
        sources = {
          default = { "lsp", "path", "buffer" },
        },
        completion = {
          documentation = { auto_show = true },
        },
      })
    end,
  },
}
