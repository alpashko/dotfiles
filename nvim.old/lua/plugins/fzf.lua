return {
    {
        "ibhagwan/fzf-lua",
        config = function()
            local actions = require('fzf-lua.actions')
            local fzf = require("fzf-lua")
            require('fzf-lua').setup({
                winopts = { backdrop = 85 },
                keymap = {
                    builtin = {
                        ["<C-f>"] = "preview-page-down",
                        ["<C-b>"] = "preview-page-up",
                        ["<C-p>"] = "toggle-preview",
                    },
                    fzf = {
                        ["ctrl-a"] = "toggle-all",
                        ["ctrl-t"] = "first",
                        ["ctrl-g"] = "last",
                        ["ctrl-d"] = "half-page-down",
                        ["ctrl-u"] = "half-page-up",
                    }
                },
                actions = {
                    files = {
                        ["ctrl-q"] = actions.file_sel_to_qf,
                        ["ctrl-n"] = actions.toggle_ignore,
                        ["ctrl-h"] = actions.toggle_hidden,
                        ["enter"]  = actions.file_edit_or_qf,
                    }
                }
            })
            vim.keymap.set("n", "<space>fd", fzf.files)
            vim.keymap.set("n", "<space>fb", fzf.buffers)
            vim.keymap.set("n", "<space>en", function()
                fzf.files({
                    cwd = vim.fn.stdpath("config"),
                })
            end, { desc = "Find files in Neovim config" })
            vim.keymap.set("n", "<leader>/", fzf.live_grep)
        end,
    }
}
