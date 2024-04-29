return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      borderless_telescope = false,
      terminal_colors = true,
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
