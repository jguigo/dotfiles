return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({
						async = true,
						lsp_format = "fallback",
					})
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		config = function()
			require("conform").setup({
				notify_on_error = false,

				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},

				formatters_by_ft = {
					lua = { "stylua" },

					-- JS/TS
					javascript = { "prettierd", stop_after_first = true },
					typescript = { "prettierd", stop_after_first = true },
					javascriptreact = { "prettierd", stop_after_first = true },
					typescriptreact = { "prettierd", stop_after_first = true },

					-- JSON / HTML / CSS
					json = { "prettierd", stop_after_first = true },
					html = { "prettierd", stop_after_first = true },
					css = { "prettierd", stop_after_first = true },

					-- Go
					go = { "goimports", "gofmt" },

					-- Shell
					sh = { "shfmt" },
				},
			})
		end,
	},
}
