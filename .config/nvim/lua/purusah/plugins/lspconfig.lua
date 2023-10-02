return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  config = function()
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- -- In this case, we create a function that lets us more easily define mappings specific
      -- -- for LSP related items. It sets the mode, buffer and description for us each time.
      -- local nmap = function(keys, func, desc)
      --   if desc then
      --     desc = 'LSP: ' .. desc
      --   end
      --
      --   vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      -- end
      --
      -- -- Create a command `:Format` local to the LSP buffer
      -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      --   vim.lsp.buf.format()
      -- end, { desc = 'Format current buffer with LSP' })
      -- Mappings
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      -- See `:help K` for why this keymap
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)  -- [G]oto [D]eclaration
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)   -- [G]oto [D]efinition
      vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, bufopts) -- Hover Documentation
      --   nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)               --
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)    -- [W]orkspace [A]dd Folder
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts) -- [W]orkspace [R]emove Folder
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)                                                                   -- [W]orkspace [L]ist Folders
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)          -- Type [D]efinition
      vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, bufopts) -- [R]e[n]ame
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)             -- [C]ode [A]ction
      --   nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
      --   nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      --   nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    end

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    --
    --  If you want to override the default filetypes that your language server will attach to you can
    --  define the property 'filetypes' to the map in question.

    require('lspconfig').rust_analyzer.setup {
      cmd = { 'rust-analyzer' },
      on_attach = on_attach,
      filetypes = { "rust" },
      root_dir = require('lspconfig').util.root_pattern("Cargo.toml"),
      -- root_dir = vim.fs.dirname(vim.fs.find({ 'Cargo.toml', 'main.rs' }, { upward = true })[1]),
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importEnforceGranularity = true,
            importPrefix = "crate"
          },
          cargo = {
            allFeatures = true
          },
          checkOnSave = {
            -- default: `cargo check`
            command = "clippy"
          },
          inlayHints = {
            lifetimeElisionHints = {
              enable = false,
              useParameterNames = false
            },
          },
        }
      }
    }
    require('lspconfig').tsserver.setup {
      on_attach = on_attach,
      root_dir = require('lspconfig').util.root_pattern("package.json"),
      filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
      single_file_support = false
    }
    require('lspconfig').denols.setup {
      on_attach = on_attach,
      root_dir = require('lspconfig').util.root_pattern("deno.json", "deno.jsonc"),
      filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    }
    require('lspconfig').denols.setup {
      on_attach = on_attach,
      root_dir = require('lspconfig').util.root_pattern("deno.json", "deno.jsonc"),
      filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    }
    require('lspconfig').lua_ls.setup {
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
          client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
              }
            }
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
      filetypes = { 'lua' },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
