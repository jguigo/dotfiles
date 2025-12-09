-- Inicia Mason
require('mason').setup()

local mason_lspconfig = require 'mason-lspconfig'
local lspconfig = require 'lspconfig'
local capabilities = require('blink.cmp').get_lsp_capabilities()

mason_lspconfig.setup {
  ensure_installed = {
    'lua_ls',
    'ts_ls',
    'gopls',
    'html',
    'cssls',
    'jsonls',
    'bashls',
    'pyright',
    'ruff',
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    local function map(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    local builtin = require 'telescope.builtin'

    map('n', 'grd', builtin.lsp_definitions, 'Goto Definition')
    map('n', 'grr', builtin.lsp_references, 'Goto References')
    map('n', 'gri', builtin.lsp_implementations, 'Goto Implementation')
    map('n', 'grt', builtin.lsp_type_definitions, 'Goto Type Definition')
    map('n', 'grn', vim.lsp.buf.rename, 'Rename Symbol')
    map('n', 'gra', vim.lsp.buf.code_action, 'Code Action')
    map('n', '<M-q>', vim.lsp.buf.hover, 'Hover Documentation')

    map('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, 'Format Buffer')

    if client.server_capabilities.documentHighlightProvider then
      local group = vim.api.nvim_create_augroup('UserLspHighlight', { clear = true })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = bufnr,
        group = group,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = bufnr,
        group = group,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client.server_capabilities.inlayHintProvider then
      map('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
      end, 'Toggle Inlay Hints')
    end
  end,
})

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } },
      },
    },
  },

  ts_ls = {},
  gopls = {},

  pyright = {},

  ruff = {
    init_options = {
      settings = {
        lint = true,
      },
    },
  },
}

mason_lspconfig.setup {
  handlers = {
    function(server_name)
      local opts = servers[server_name] or {}
      opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, opts.capabilities or {})
      lspconfig[server_name].setup(opts)
    end,
  },
}
