return {
    {
        "mbbill/undotree",
        enabled = true,
        config = function()
            vim.keymap.set("n", "<space>u", vim.cmd.UndotreeToggle)
        end
    },
}
