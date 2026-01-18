vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<bs>", "<cmd>noh<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<space>y", [["+y]])
vim.keymap.set("n", "<space>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<space>d", [["_d]])
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<space>w", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<Leader>ds", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<Leader>dv", function()
    local current_config = vim.diagnostic.config()
    local has_virtual_text = current_config and current_config.virtual_text
    vim.diagnostic.config({ virtual_text = not has_virtual_text })
end, { desc = "Toggle diagnostics virtual text" })

vim.keymap.set("n", "<space>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
end)

