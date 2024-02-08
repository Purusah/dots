vim.cmd.colorscheme("slate")

if vim.fn.filereadable(vim.fs.dirname(vim.env.MYVIMRC) .. "/lua/configs/colorscheme-my.lua") == 1 then
  require("configs.colorscheme-my")
end

-- vim: ts=2 sts=2 sw=2 et
