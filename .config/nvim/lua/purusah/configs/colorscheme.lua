vim.cmd.colorscheme("slate")

if vim.fn.filereadable(vim.fs.dirname(vim.env.MYVIMRC) .. "/lua/purusah/configs/colorscheme-my.lua") then
  require("purusah.configs.colorscheme-my")
end

-- vim: ts=2 sts=2 sw=2 et
