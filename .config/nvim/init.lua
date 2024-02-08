vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  ui = {
    border = "rounded",
  },
  spec = {
    { import = "plugins" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "zipPlugin",
      },
    },
  },
})

require("configs.options")
require("configs.colorscheme")
require("configs.autocmds")
require("configs.keymaps")

-- vim: ts=2 sts=2 sw=2 et
