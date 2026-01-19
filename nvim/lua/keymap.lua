vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>fd", fzf.files)
vim.keymap.set("n", "<leader>/", fzf.live_grep)
vim.keymap.set("n", "<leader>en", function()
	fzf.files({
		cwd = vim.fn.stdpath("config")
	})
end)

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "grr", function() fzf.lsp_references() end, opts)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<bs>", "<cmd>noh<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>w", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<leader>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)
end)

local gs = require("gitsigns")

vim.keymap.set("n", "]c", gs.next_hunk, { desc = "Next git hunk" })
vim.keymap.set("n", "[c", gs.prev_hunk, { desc = "Prev git hunk" })

vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })

vim.keymap.set("n", "<leader>hb", function()
  gs.blame_line({ full = true })
end, { desc = "Blame line" })

vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff this file" })
