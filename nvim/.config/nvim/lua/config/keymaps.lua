vim.keymap.set("n", "<C-n>", "<cmd>bn<cr>", { desc = "buffer next" })
vim.keymap.set("n", "<C-p>", "<cmd>bp<cr>", { desc = "buffer prev" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "improved Join" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "improved scroll down" } )
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "imrpoved scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "improved search next" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "improved search prev" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "replace selected from clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y], { desc = "yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank current line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete to blackhole register" })

vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "move selected block down" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "move selected block up" })

vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, { desc = "[G]oto [L]anguage Diagnostics" })
