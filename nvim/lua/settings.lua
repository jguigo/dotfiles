-- set spacebar as <leader>
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.keymap.set("v", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.have_nerd_font = true

local options = {
	number = true,
	relativenumber = true,
	mouse = "a",
	clipboard = "unnamedplus",
	showmode = false,

	signcolumn = "yes",
	cursorline = true,
	scrolloff = 10,
	softtabstop = 2,
	tabstop = 2,

	ignorecase = true,
	smartcase = true,

	breakindent = true,
	undofile = true,
	inccommand = "split",

	updatetime = 250,
	timeoutlen = 300,

	splitright = true,
	splitbelow = true,

	swapfile = false,
	confirm = true,

	termguicolors = true,
}

for k, v in pairs(options) do
	vim.o[k] = v
end
