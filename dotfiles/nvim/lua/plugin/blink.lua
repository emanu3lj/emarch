return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      local cmp = require("blink.cmp")

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        },
        completion = {
          documentation = true, -- show docs popup
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}
