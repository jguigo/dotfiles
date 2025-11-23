require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },

{
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require("plugins.telescope")
  end,
},

  -- LSP Core
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
    },
    config = function()
      require("lsp")  -- carrega lua/lsp/init.lua
    end,
  },

  { -- Autoformat
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format {
          async = true,
          lsp_format = "fallback",
        }
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  config = function()
    require("plugins.conform")
  end,
},

  { -- Autocompletion
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "folke/lazydev.nvim",
    },
    config = function ()
      require("plugins.blink")
    end,
  },

  -- Theme
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("plugins.tokyonight")
    end,
  },
})
