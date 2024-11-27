return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "j-hui/fidget.nvim", opts = {} },
  },
  event = "BufEnter",
  keys = {
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    { "<leader>la", vim.lsp.buf.code_action, desc = "LSP: Code [A]ction" },
    { "<leader>ld", vim.lsp.buf.definition, desc = "LSP: [D]efinition" },
    { "<leader>lh", vim.lsp.buf.hover, desc = "LSP: [H]over Documentation" },
    { "<leader>li", vim.lsp.buf.implementation, desc = "LSP: [I]mplementaion" },
    {
      "<leader>ln",
      function()
        vim.lsp.buf.rename()
      end,
      desc = "LSP: Re[n]ame",
    },
    { "[d", vim.diagnostic.goto_prev, desc = "Diagnostic: Goto Previous" },
    { "]d", vim.diagnostic.goto_next, desc = "Diagnostic: Goto Next" },
    -- { "<C-k>", vim.lsp.buf.signature_help, desc = "LSP: Signature Help" },
    -- { "gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
    -- { "<leader>D", vim.lsp.buf.type_definition, desc = "Type [D]efinition" },
    -- { "<leader>e", vim.diagnostic.open_float, desc = "Open Diagnostic" },
    -- { "<leader>q", vim.diagnostic.setloclist, desc = "Diagnostic ?" },
    -- {"<leader>f", function() vim.lsp.buf.format({ async = true }) end, desc = "[F]ormat"}
    -- {"<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder"},
    -- {"<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder"},
    -- {"<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "[W]orkspace [L]ist Folders"},
    -- {'<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols'},
    -- {'<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols'},
  },
  config = function()
    local on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    end

    require("lspconfig").ts_ls.setup({
      on_attach = on_attach,
      root_dir = require("lspconfig").util.root_pattern("package.json"),
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      single_file_support = false,
    })

    require("lspconfig").denols.setup({
      on_attach = on_attach,
      root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      single_file_support = true,
    })

    require("lspconfig").lua_ls.setup({
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                },
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
              },
            },
          })

          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
      end,
      on_attach = on_attach,
      settings = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
      filetypes = { "lua" },
    })

    require("lspconfig").rust_analyzer.setup({
      cmd = { "rust-analyzer" },
      on_attach = on_attach,
      filetypes = { "rust" },
      root_dir = require("lspconfig").util.root_pattern("Cargo.toml"),
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importEnforceGranularity = true,
            importPrefix = "crate",
          },
          cargo = {
            allFeatures = true,
          },
          checkOnSave = {
            -- default: `cargo check`
            command = "clippy",
          },
          inlayHints = {
            lifetimeElisionHints = {
              enable = true,
              useParameterNames = true,
            },
          },
        },
      },
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
