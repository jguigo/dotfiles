return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			require("mini.move").setup()

			require("mini.indentscope").setup({
				symbol = "│",
				draw = { animation = require("mini.indentscope").gen_animation.none() }, -- Opcional: remove animação
			})

			local misc = require("mini.misc")
			misc.setup()
			misc.setup_auto_root()
			misc.setup_restore_cursor()

			local ascii = {
				"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*:.-#%%%%%%%",
				"%%%%%%%%####%%%%%%%%%%%%%%%%..#%%%+ -%%%%%",
				"%%%%   :=+***+=-.    :=*%%%.:%%=  #% +%%%%",
				"%%%%+          =#%%%%%%%=   -%% - =%=-%%%%",
				"%%%%%=              :#%%%%%%#. *%%%% *%%%%",
				"%%%%%%*         +%%%%*: -#%%%%%+   :#%%%%%",
				"%%%%%%%%:     -. %%%%%%%#. -%%%%%: #%%%%%%",
				"%%%%%%%%%%:  :   %%+  +%%#    *%%%# *%%%%%",
				"%-   =%*  *  *%#%%%.  #%%+      -%%%.=%%%%",
				"*  -  + %#   =%%%%%%#%%%#         :%%.:%%%",
				"%-    %-  *+  +%%%%%%%%*            *%.=%%",
				"%%      *   =    -+*=                -# *%",
				"%*  =%--%+ :                           = %",
				"%=  #% *%%                  *=.          *",
				"%:  %% +%* #  *%#            +%%%%#+-...+%",
				"%   %%%   #*  %%%%            :%%%%%%%%%%%",
				"%  =%%%%%%%+  +%%%:                *%%%%%%",
				"%  *%%%%%%%#   #%%#               .%%%%%%%",
				"%==%%%%%%%%*    =%%*            .#%%%%%%%%",
				"%%%%%%%%%%%               :   .=#%%%%%%%%%",
				"%%%%%%%%%%%%%%%#.  +%%*  .%%%%%%%%%%%%%%%%",
				"%%%%%%%%%%%%%%%%%  %%%# :%%%%%%%%%%%%%%%%%",
				"%%%%%%%%%%%%%%%%%* *%%# =%%%%%%%%%%%%%%%%%",
				"%%%%%%%%%%%%%%%%%%*#%%%+%%%%%%%%%%%%%%%%%%",
			}
			local starter = require("mini.starter")
			starter.setup({
				header = table.concat(ascii, "\n"),
				items = {
					starter.sections.recent_files(5, false),
					starter.sections.recent_files(5, true),
					starter.sections.builtin_actions(),
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(),
					starter.gen_hook.aligning("center", "center"),
				},
			})
		end,
	},
}
