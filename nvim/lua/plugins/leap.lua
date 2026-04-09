return {
	url = "https://codeberg.org/andyg/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
		vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
		-- require("leap").opts.special_keys.prev_target = "<s-cr>"
		-- require("leap").opts.special_keys.prev_group = "<s-cr>"
		-- require("leap.user").set_repeat_keys("<cr>", "<s-cr>")
	end,
}
