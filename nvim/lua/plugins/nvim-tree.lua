require('nvim-tree').setup {
  disable_netrw = true,
  hijack_cursor = true,
  hijack_netrw = true,
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 32,
    relativenumber = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = true,
      },
    },
  },
}

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = '[E]xplorer (NvimTree)' })
vim.keymap.set('n', '<leader>fe', ':NvimTreeFindFile<CR>', { desc = '[F]ind file in [E]xplorer' })

