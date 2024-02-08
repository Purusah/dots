-- Fuzzy Finder (files, lsp, etc)
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    }, -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  event = "VeryLazy",
  keys = {
    { "<leader><leader>", "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "Show Open Buffers" },
    { "<leader>lD", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", desc = "LSP: [D]iagnostics" },
    { "<leader>lr", ":Telescope lsp_references<CR>", desc = "LSP: [R]eferences" }, -- vim.lsp.buf.references
    {
      "<leader>fc",
      ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
      desc = "[F]ind File from [C]urrent Path",
    },
    { "<leader>ff", ":Telescope file_browser<CR>", desc = "[F]ind [F]ile" },
    {
      "<leader>fg",
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      desc = "[F]ind by [G]rep",
    },
    { "<leader>vs", "<cmd>lua require('telescope.builtin').git_status()<CR>", desc = "VCS: [S]tatus" },
    { "<leader>?", "<cmd> lua require('telescope.builtin').oldfiles()<CR>", desc = "[?] Recently Opened Files" },

    -- { "<leader>sw", "<cmd>lua require('telescope.builtin').grep_string()<CR>", desc = "[S]earch Current [W]ord" },
    -- { "<leader>sr", "<cmd>lua require('telescope.builtin').resume()<CR>", desc = "[S]earch [R]resume" },
    -- { "gI", "<cmd>require('telescope.builtin').lsp_implementations<CR>", desc = "[G]oto [I]mplementation" },
    -- { "<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", desc = "[S]earch [H]elp" },
    -- { "<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "[S]earch [F]ile" },
    -- { "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "[S]earch by [G]rep" },
    {
      "<leader>/",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end,
      desc = "[/] Fuzzily search in current buffer",
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions
    local lga_actions = require("telescope-live-grep-args.actions")
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    telescope.setup({
      defaults = {
        theme = "center",
        layout_strategy = "center",
        layout_config = {
          center = {
            width = 0.9,
            prompt_position = "bottom",
          },
        },
        mappings = {
          n = {
            ["q"] = actions.close,
          },
        },
      },
      extensions = {
        file_browser = {
          path = vim.loop.cwd(),
          cwd = vim.loop.cwd(),
          cwd_to_path = false,
          grouped = true,
          files = true,
          add_dirs = true,
          auto_depth = true,
          select_buffer = true,
          hidden = { file_browser = false, folder_browser = false },
          -- respect_gitignore = vim.fn.executable "fd" == 1,
          follow_symlinks = false,
          -- browse_files = require("telescope._extensions.file_browser.finders").browse_files,
          -- browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
          hide_parent_dir = false,
          collapse_dirs = false,
          prompt_path = false,
          quiet = false,
          -- dir_icon = "",
          dir_icon_hl = "Default",
          display_stat = { date = true, size = true, mode = false },
          use_fd = true,
          git_status = true,
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              ["<A-c>"] = fb_actions.create,
              ["<S-CR>"] = fb_actions.create_from_prompt,
              ["<A-r>"] = fb_actions.rename,
              ["<A-m>"] = fb_actions.move,
              ["<A-y>"] = fb_actions.copy,
              ["<A-d>"] = fb_actions.remove,
              ["<C-o>"] = fb_actions.open,
              ["<C-g>"] = fb_actions.goto_parent_dir,
              ["<C-e>"] = fb_actions.goto_home_dir,
              ["<C-w>"] = fb_actions.goto_cwd,
              -- ["<C-w>"] = function() vim.cmd('normal vbd') end,
              ["<C-t>"] = fb_actions.change_cwd,
              ["<C-f>"] = fb_actions.toggle_browser,
              ["<C-h>"] = fb_actions.toggle_hidden,
              ["<C-s>"] = fb_actions.toggle_all,
              ["<bs>"] = fb_actions.backspace,
            },
            ["n"] = {
              ["c"] = fb_actions.create,
              ["r"] = fb_actions.rename,
              ["m"] = fb_actions.move,
              ["y"] = fb_actions.copy,
              ["d"] = fb_actions.remove,
              ["o"] = fb_actions.open,
              ["g"] = fb_actions.goto_parent_dir,
              ["e"] = fb_actions.goto_home_dir,
              ["w"] = fb_actions.goto_cwd,
              ["t"] = fb_actions.change_cwd,
              ["f"] = fb_actions.toggle_browser,
              ["h"] = fb_actions.toggle_hidden,
              ["s"] = fb_actions.toggle_all,
            },
          },
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
          -- ... also accepts theme settings, for example:
          -- theme = "dropdown", -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })
    telescope.load_extension("file_browser")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("ui-select")
  end,
}

-- vim: ts=2 sts=2 sw=2 et
