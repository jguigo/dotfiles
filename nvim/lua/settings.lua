local g = vim.g
local o = vim.o

g.mapleader = ' ' -- Set <Leader> key to space
g.maplocalleader = ' ' -- Set <LocalLeader> key to space
g.have_nerd_font = true -- Indicates Nerd Font support

o.number = true -- Show absolute line numbers
o.relativenumber = true -- Show relative line numbers
o.mouse = 'a' -- Enable mouse support
o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
o.showmode = false -- Do not show mode (-- INSERT --), statusline handles it

o.signcolumn = 'yes' -- Always show the sign column
o.cursorline = true -- Highlight the current line
o.scrolloff = 10 -- Keep lines above/below cursor when scrolling

o.ignorecase = true -- Case-insensitive search
o.smartcase = true -- Case-sensitive if uppercase is used in the search

o.breakindent = true -- Maintain indentation when wrapping lines
o.undofile = true -- Enable persistent undo history
o.inccommand = 'split' -- Live preview of substitutions in a split window

o.updatetime = 250 -- Faster update time for events like CursorHold
o.timeoutlen = 300 -- Timeout for key mappings (in ms)

o.splitright = true -- Vertical splits open to the right
o.splitbelow = true -- Horizontal splits open below

o.list = true -- Show invisible characters
vim.opt.listchars = { -- Configure how they appear
  tab = '» ',
  trail = '·',
  nbsp = '␣'
}

o.confirm = true -- Ask for confirmation when closing modified files
o.termguicolors = true -- Enable 24-bit color so themes render correctly
