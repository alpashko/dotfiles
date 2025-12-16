return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<space>fh", builtin.help_tags)
        vim.keymap.set("n", "<space>fd", builtin.find_files)
        vim.keymap.set("n", "<space>fw", builtin.grep_string)
        vim.keymap.set("n", "<space>fb", builtin.buffers)
        vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)
        vim.keymap.set("n", "<space>en", function()
            builtin.find_files({
                cwd = vim.fn.stdpath("config")
            })
        end)
        vim.keymap.set("n", "<space>ep", function()
            builtin.find_files({
                cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
            })
        end)
        vim.keymap.set("n", "<space>fp", function()
            builtin.find_files { cwd = "~/plugins/" }
        end)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action)
    end,
}
