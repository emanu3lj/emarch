return 
{
  { "nvim-treesitter/nvim-treesitter", 
  branch = 'master', 
  lazy = false,
  build = ":TSUpdate",
  config = function()
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline","javascript","css", "c_sharp", "erlang", "elixir", "ruby"},
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    }
  end,
  }
}
