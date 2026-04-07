return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"lua",
				"vim",
				"vimdoc",
				"query",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"markdown",
				"markdown_inline",
				"bash",
				"go",
				"c",
				"diff",
			})
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
