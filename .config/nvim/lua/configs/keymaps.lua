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
-- vim.api.nvim_set_keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- vim.api.nvim_set_keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- vim.api.nvim_set_keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- vim.api.nvim_set_keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- vim.api.nvim_set_keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- vim.api.nvim_set_keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- windows
-- vim.api.nvim_set_keymap("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
-- vim.api.nvim_set_keymap("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
-- vim.api.nvim_set_keymap("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
-- vim.api.nvim_set_keymap("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
-- vim.api.nvim_set_keymap("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
-- vim.api.nvim_set_keymap("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- Move lines
vim.api.nvim_set_keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.api.nvim_set_keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.api.nvim_set_keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.api.nvim_set_keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

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
