vim.keymap.set("i", "<C-q>", "<esc>:qa<cr>", { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set("n", "<C-q>", ":qa<cr>", { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set("n", "<leader>q", ":bd<cr>", { noremap = true, silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>s", ":update<cr>", { noremap = true, silent = true })

vim.keymap.set("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true, noremap = true, silent = true })
vim.keymap.set("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true, noremap = true, silent = true })

vim.keymap.set("n", "<leader>u", "<esc>:undo<cr>", { silent = true, desc = "Undo" })

vim.keymap.set("v", "<leader>y", "\"*y")

vim.keymap.set("t", ",d", "<C-\\><C-n>")
