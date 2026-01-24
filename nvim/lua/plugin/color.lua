return
{
{
  "rebelot/kanagawa.nvim",
  lazy = false,       -- or true if you want to load on command / event
  priority = 1000,    -- so colorscheme loads early
  config = function()
    require("kanagawa").setup({
      -- your options here; these are the defaults:
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        return {}
      end,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
    })

    -- Set the colourscheme
    vim.cmd("colorscheme kanagawa")
  end,
}
}
