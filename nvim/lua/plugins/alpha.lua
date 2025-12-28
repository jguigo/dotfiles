return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local dashboard = require("alpha.themes.dashboard")

		local function button(sc, txt, keybind, keybind_opts)
			local b = dashboard.button(sc, txt, keybind, keybind_opts)
			b.opts.hl_shortcut = "Include"
			return b
		end

		dashboard.section.buttons.val = {
			button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			button("SPC s p", "  Projects", ":Telescope projects<CR>"),
			button("SPC s f", "󰈞  Find file", ":Telescope find_files<CR>"),
			button("SPC s h", "󰊄  Recently opened", ":Telescope oldfiles<CR>"),
			button("SPC s g", "󰈬  Find word", ":Telescope live_grep<CR>"),

			button("q", "󰅚  Quit", ":qa<CR>"),
		}
		dashboard.section.header.val = {
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
		require("alpha").setup(dashboard.config)
	end,
}
