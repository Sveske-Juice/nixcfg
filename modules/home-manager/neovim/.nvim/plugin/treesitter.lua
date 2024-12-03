require("nvim-treesitter.configs").setup ({
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- Overrides '=' operator for language grammar
  indent = {
    enable = true
  }

})

require'treesitter-context'.setup{
  enable = true,
  multiwindow = true,
}
