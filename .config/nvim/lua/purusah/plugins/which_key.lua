return {
  'folke/which-key.nvim',
  config = function()
    local wk = require("which-key")
    -- As an example, we will create the following mappings:
    --  * <leader>ff find files
    --  * <leader>fr show recent files
    --  * <leader>fb Foobar
    -- we'll document:
    --  * <leader>fn new file
    --  * <leader>fe edit file
    -- and hide <leader>1

    wk.register({
      b = {
        name = "Buffer",
        b = "Toggle",
        d = "Delete",
        h = "Horizontal Split",
        l = "List",
        n = "Next",
        p = "Previous",
        s = "List and Select",
        u = "List and Delete",
        v = "Vertical Split",
      },
      g = {
        name = "LSP",
        D = "Type Definitions",
      },
      r = {
        name = "LSP",
        n = "Rename"
      }
    }, { prefix = "<leader>" })

    wk.register({
      g = {
        name = "LSP",
        D = "Declarations",
        d = "Definitions",
        i = "Implementations",
        r = "References",
      },
    }, { prefix = "" })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
