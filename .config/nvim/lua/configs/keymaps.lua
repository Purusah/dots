-- [[ Jump ]]
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump Half Page Down and Center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump Half Page Up and Center" })

-- [[ Buffer]]
vim.keymap.set("n", "<leader>bb", "<C-^>", { desc = "Buffer: toggle", silent = true })
vim.keymap.set("n", "<leader>bd", ":b#|bd#<CR>", { desc = "[B]uffer: delete current buffer", silent = true })
vim.keymap.set("n", "<leader>bh", ":new<CR>", { desc = "[B]uffer [H]orizontal  Split", silent = true })
vim.keymap.set("n", "<leader>bl", ":ls<CR>", { desc = "Buffer: list", silent = true })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Buffer: go to next", silent = true })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Buffer: go to previous", silent = true })
vim.keymap.set("n", "<leader>bs", ":ls<CR>:buffer<Space>", { desc = "Buffer: list and select", silent = true })
vim.keymap.set("n", "<leader>bu", ":ls<CR>:bdelete<Space>", { desc = "Buffer: list and delete", silent = true })
vim.keymap.set("n", "<leader>bv", ":vnew<CR>", { desc = "Buffer: vertical split", silent = true })
-- " nnoremap <silent> <leader>bk :bd!<CR> -- kill buffer

-- [[ Tabs ]]
vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew %<CR>", { noremap = true, desc = "[T]ab [A]dd" })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true, desc = "[T]ab [C]lose" })
vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true, desc = "[T]ab [O]nly" })
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true, desc = "[T]ab Select [N]ext" })
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true, desc = "[T]ab Select [P]revious" })
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true, desc = "[T]ab [M]ove to [P]revious" })
vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true, desc = "[T]ab [M]ove to [N]ext" })

-- [[ Termianl ]]
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- " Start terminal in insert mode
-- " au BufEnter * if &buftype == 'terminal' | :startinsert | endif
-- " nnoremap <silent> <leader>tt :terminal<CR>
-- " nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
-- " nnoremap <silent> <leader>th :new<CR>:terminal<CR>
-- " tnoremap <C-x> <C-\><C-n><C-w>q

-- vim.keymap.set("n", "<C-b>", function() require("fidget").notify("This is from fidget.notify()!") end)
-- Not Supported with lazy.nvim
-- vim.keymap.set('n', '<leader>cr', ':source $MYVIMRC<CR>', { desc = '[C]onfiguration [R]eload', silent = true })
-- vim.keymap.set('n', '<leader>ce', ':e $MYVIMRC<CR>', { desc = '[C]onfiguration [E]dit', silent = true })

-- redraw screan and clear search highlighted items
-- http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#answer-25569434
-- nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

-- vim: ts=2 sts=2 sw=2 et
