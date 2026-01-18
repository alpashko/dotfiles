return {
    {
        "neovim/nvim-lspconfig",
        enable = true,
        dependencies = {
            "saghen/blink.cmp",
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local servers = { "lua_ls", "ty", }

            for _, server in ipairs(servers) do
                vim.lsp.config(server, {
                    capabilities = vim.tbl_deep_extend("force", {}, capabilities),
                })
            end
            vim.lsp.enable(servers)

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("my.lsp", {}),
                callback = function(args)
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                    if vim.tbl_contains({ "lua", "py" }, vim.bo.filetype) then
                        if not client:supports_method("textDocument/willSaveWaitUntil")
                            and client:supports_method("textDocument/formatting") then
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                                buffer = args.buf,
                                callback = function()
                                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                                end,
                            })
                        end
                    end
                end,
            })
        end,

    },
}
