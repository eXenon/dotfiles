-- Requires python packages jedi and python-lsp-server
vim.lsp.enable("pylsp")

vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        pattern = { "*.py" },
        callback = function()
            vim.cmd "Black"
        end
    }
)
