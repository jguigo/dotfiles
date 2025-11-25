require("nvim-autopairs").setup({
  check_ts = true,
})

require("blink.cmp").setup({
  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
  },
})
