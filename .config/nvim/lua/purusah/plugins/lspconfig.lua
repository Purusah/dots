return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    local on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
      end

      -- Mappings
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
      nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
      nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementaion")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
      nmap("<leader>K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition") --
      -- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      -- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      -- nmap("<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "[W]orkspace [L]ist Folders")
      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      nmap("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "[F]ormat")
      nmap("<leader>rn", function() vim.lsp.buf.rename() end, "[R]e[n]ame") --
      nmap('<space>e', vim.diagnostic.open_float, "Open Diagnostic")
      nmap('[d', vim.diagnostic.goto_prev, "Goto Previous Diagnostic")
      nmap(']d', vim.diagnostic.goto_next, "Goto Next Diagnostic")
      nmap('<space>q', vim.diagnostic.setloclist, "Diagnostic ?")
      --   nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      --   nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      --   nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      --   nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    end

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

    require("lspconfig").tsserver.setup({
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
  end,
}

-- vim: ts=2 sts=2 sw=2 et
