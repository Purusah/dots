return {
  "lewis6991/gitsigns.nvim",
  keys = {
    { "]h", "<Plug>(gitsigns-next-hunk)", desc = "Git: Next Hunk" },
    { "[h", "<Plug>(gitsigns-prev-hunk)", desc = "Git: Previous Hunk" },
    { "<leader>hb", "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>", desc = "Git: Toggle Line Blance" },
    { "<leader>hd", "<cmd>lua require('gitsigns').diffthis()<CR>", desc = "Git: Diff This" },
    { "<leader>hp", "<cmd>lua require('gitsigns').preview_hunk()<CR>", desc = "Git: Preview Hunk" },
    { "<leader>hr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", desc = "Git: Reset Hunk" },
    { "<leader>hs", "<cmd>lua require('gitsigns').stage_hunk()<CR>", desc = "Git: Stage Hunk" },
    { "<leader>hu", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", desc = "Git: Undo Stage Hunk" },
    { "<leader>hB", "<cmd>lua require('gitsigns').blame_line(true)<CR>", desc = "Git: Blame Line" },
    { "<leader>hD", "<cmd>lua require('gitsigns').diffthis('~')<CR>", desc = "Git: Diff Root" },
    { "<leader>hR", "<cmd>lua require('gitsigns').reset_buffer()<CR>", desc = "Git: Reset Buffer" },
    { "<leader>hS", "<cmd>lua require('gitsigns').stage_buffer()<CR>", desc = "Git: Stage Buffer" },
    {
      "<leader>hs",
      "<cmd>lua require('gitsigns').stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>",
      desc = "Git: Stage Hunk in Line",
    },
    {
      "<leader>hr",
      "<cmd>lua require('gitsigns').reset_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>",
      desc = "Git: Reset Hunk in Line",
    },
    -- map('n', '<leader>td', gs.toggle_deleted)
    -- map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "‾" },
        changedelete = { text = "|" },
        untracked = { text = "┆" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 500,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
