return {
  "folke/which-key.nvim",
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
      f = "Format",
      g = {
        name = "LSP",
        D = "Type Definitions",
      },
      h = {
        name = "Git",
        b = "[B]lame",
        d = "[D]iff",
        p = "[P]review Hunk",
        r = "[R]eset Hunk",
        s = "[S]tage Hunk",
        u = "[U]ndo Stage Hunk",
        B = "[B]lame Full",
        D = "[D]iff ~",
        R = "[R]eset Buffer",
        S = "[S]tage Buffer",
      },
      r = {
        name = "LSP",
        n = "Rename",
      },
      s = {
        name = "[S]earch",
        b = "File [B]rowser",
        c = "With [C]urrent Buffer Path",
        d = "[D]iagnostics",
        f = "[F]ile",
        g = "By [G]rep",
        h = "[H]elp",
        r = "[R]esume",
        w = "Current [W]ord",
      },
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
