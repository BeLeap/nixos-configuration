vim.keymap.set("i", "<C-q>", "<esc>:qa<cr>", { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set("n", "<C-q>", ":qa<cr>", { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set("n", "<leader>q", ":bd<cr>", { noremap = true, silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>s", ":update<cr>", { noremap = true, silent = true })

vim.keymap.set("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true, noremap = true, silent = true })
vim.keymap.set("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true, noremap = true, silent = true })

vim.keymap.set("n", "<leader>u", "<esc>:undo<cr>", { silent = true, desc = "Undo" })

vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "Move focus to left" })
vim.keymap.set("n", "<M-n>", "<C-w>j", { desc = "Move focus to down" })
vim.keymap.set("n", "<M-e>", "<C-w>k", { desc = "Move focus to up" })
vim.keymap.set("n", "<M-i>", "<C-w>l", { desc = "Move focus to right" })

vim.keymap.set("n", "n", "h")
vim.keymap.set("n", "u", "j")
vim.keymap.set("n", "e", "k")
vim.keymap.set("n", "i", "l")
