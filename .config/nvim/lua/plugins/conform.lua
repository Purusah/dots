-- Formatter

return {
  "stevearc/conform.nvim",
  version = "^5.1.0",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>F",
      function()
        require("conform").format({ async = true, lsp_fallback = false })
      end,
      mode = { "n", "v" },
      desc = "[F]ormat Buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier", "eslint", "deno_fmt" },
      javascriptreact = { "prettier", "eslint", "deno_fmt" },
      typescript = { "prettier", "eslint", "deno_fmt" },
      typescriptreact = { "prettier", "eslint", "deno_fmt" },
      rust = { "rustfmt" },
      -- ["_"] = { "trim_whitespace" }, -- filetypes that don't have other formatters configured
      ["*"] = { "trim_whitespace", "codespell" }, -- all filetypes
    },
    -- format_on_save = {
    --   lsp_fallback = false,
    --   timeout_ms = 500,
    -- },
    format_after_save = {
      lsp_fallback = false,
    },
    log_level = vim.log.levels.ERROR, -- use `:ConformInfo` to see the location of the log file.
    notify_on_error = true,
    formatters = {
      -- my_formatter = {
      --   -- This can be a string or a function that returns a string
      --   command = "npx run eslint",
      --   -- OPTIONAL - all fields below this are optional
      --   -- A list of strings, or a function that returns a list of strings
      --   -- Return a single string instead to run the command in a shell
      --   args = { "--stdin-from-filename", "$FILENAME" },
      --   -- If the formatter supports range formatting, create the range arguments here
      --   range_args = function(ctx)
      --     return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
      --   end,
      --   -- Send file contents to stdin, read new contents from stdout (default true)
      --   -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
      --   -- file is assumed to be modified in-place by the format command.
      --   stdin = true,
      --   -- A function that calculates the directory to run the command in
      --   -- cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
      --   -- When cwd is not found, don't run the formatter (default false)
      --   require_cwd = true,
      --   -- When returns false, the formatter will not be used
      --   condition = function(ctx)
      --     return vim.fs.basename(ctx.filename) ~= "README.md"
      --   end,
      --   -- Exit codes that indicate success (default {0})
      --   exit_codes = { 0, 1 },
      --   -- Environment variables. This can also be a function that returns a table.
      --   env = {
      --     VAR = "value",
      --   },
      -- },
      -- These can also be a function that returns the formatter
      -- other_formatter = function()
      --   return {
      --     command = "my_cmd",
      --   }
      -- end,
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
