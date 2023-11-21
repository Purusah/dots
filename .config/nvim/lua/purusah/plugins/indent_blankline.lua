return {

  -- Add indentation guides even on blank lines
  "lukas-reineke/indent-blankline.nvim",
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help indent_blankline.txt`
  opts = {
    char = "┊",
    show_trailing_blankline_indent = false,

    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  },
  config = function()
    vim.opt.list = true
    -- vim.opt.listchars:append "space:⋅"
    -- vim.opt.listchars:append "eol:↴"
  end,
}

-- vim: ts=2 sts=2 sw=2 et
