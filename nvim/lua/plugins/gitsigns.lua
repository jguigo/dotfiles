require("gitsigns").setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },

  on_attach = function(bufnr)
    local gs = require("gitsigns")

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Navegação entre hunks
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      gs.nav_hunk("next")
    end, "Next Git hunk")

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      gs.nav_hunk("prev")
    end, "Previous Git hunk")

    -- Ações
    map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
    map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
    map("n", "<leader>hS", gs.stage_buffer, "Stage entire buffer")
    map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
    map("n", "<leader>hR", gs.reset_buffer, "Reset entire buffer")
    map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
    map("n", "<leader>hb", gs.blame_line, "Blame line")
    map("n", "<leader>hd", gs.diffthis, "Diff this buffer")
    map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff vs last commit")

    -- Toggles
    map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle blame line")
    map("n", "<leader>tD", gs.toggle_deleted, "Toggle deleted lines")
  end,
})
