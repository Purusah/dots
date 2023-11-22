return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local highlight = {
      "CursorColumn",
      "Whitespace",
    }

    require("ibl").setup({
      indent = { highlight = highlight, char = "" },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      scope = { enabled = false },
    })
    -- TODO: https://github.com/lukas-reineke/indent-blankline.nvim#rainbow-delimitersnvim-integration
  end,
}

-- vim: ts=2 sts=2 sw=2 et
