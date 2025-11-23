require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "lua", "vim", "vimdoc", "query",
    "html", "css",
    "javascript", "typescript", "tsx", "json",
    "markdown", "markdown_inline",
    "bash",
    "go",
    "c",
    "diff",
  },
  auto_install = true,
  sync_install = false,
  highlight = { 
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
})