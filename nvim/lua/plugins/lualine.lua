return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					icons_enabled = true,
				},

				sections = {
					lualine_a = { "mode" }, -- NORMAL / INSERT / VISUAL
					lualine_b = { "branch", "diff", "diagnostics" }, -- git info
					lualine_c = { "filename" }, -- current file

					lualine_x = { "encoding", "filetype" },
					lualine_y = { "progress" }, -- progress %
					lualine_z = { "location" }, -- line:column
				},
			})
		end,
	},
}
