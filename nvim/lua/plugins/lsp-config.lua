local servers = {
	lua_ls = {
		settings = {
			Lua = { diagnostics = { globals = { "vim" } } },
		},
	},
	tailwindcss = {},
	ts_ls = {},
	html = {},
	cssls = {},
	jsonls = {},
	bashls = {},
	gopls = {
		settings = {
			gopls = {
				gofumpt = true,
				staticcheck = true,
				analyses = { unusedparams = true, shadow = true },
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	},
}

return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
				callback = function(ev)
					local bufnr = ev.buf
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
					end
					local builtin = require("telescope.builtin")

					map("grd", builtin.lsp_definitions, "Goto Definition")
					map("grr", builtin.lsp_references, "Goto References")
					map("gri", builtin.lsp_implementations, "Goto Implementation")
					map("grt", builtin.lsp_type_definitions, "Goto Type Definition")
					map("grn", vim.lsp.buf.rename, "Rename Symbol")
					map("gra", vim.lsp.buf.code_action, "Code Action")
					map("<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, "Format Buffer")

					if client.server_capabilities.inlayHintProvider then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
						end, "Toggle Inlay Hints")
					end
				end,
			})

			vim.lsp.config("tailwindcss", {
				capabilities = capabilities,
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								"tw`([^`]*)",
								'tw="([^"]*)',
								'tw={"([^"}]*)',
								"tw\\.\\w+`([^`]*)",
								"tw\\(.*?\\)`([^`]*)",
								{ "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								{ "classnames\\(([^)]*)\\)", "'([^']*)'" },
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							},
						},
					},
				},
			})
			vim.lsp.enable("tailwindcss")

			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				},
				-- ADICIONE ISSO AQUI PARA O TEXTO APARECER:
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●", -- Um iconezinho antes da mensagem
					-- Garante que vai mostrar a mensagem de erro
					format = function(diagnostic)
						return diagnostic.message
					end,
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					local params = vim.lsp.util.make_range_params()
					params.context = { only = { "source.organizeImports" } }
					local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
					for cid, res in pairs(result or {}) do
						for _, r in pairs(res.result or {}) do
							if r.edit then
								local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
								vim.lsp.util.apply_workspace_edit(r.edit, enc)
							end
						end
					end
					vim.lsp.buf.format({ async = false })
				end,
			})

			mason_lspconfig.setup({
				handlers = {
					function(server_name)
						local opts = servers[server_name] or {}
						opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
						lspconfig[server_name].setup(opts)
					end,
				},
			})
		end,
	},
}
