require("plugins")
require("config")
require("keymap")
require("lsp")
require("autocmd")
require("menu")

vim.cmd.colorscheme("gruvbuddy")
vim.g.loaded_python3_provider = 1

if vim.fn.has("cscope") == 1 then
	vim.o.cscopetag = true
	vim.o.cscopeverbose = true
end

if vim.g.vscode then
    vim.keymap.set('n', 'u', "<Cmd>call VSCodeNotify('undo')<CR>")
    vim.keymap.set('n', '<C-r>', "<Cmd>call VSCodeNotify('redo')<CR>")
end
