vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        pattern = { "*.py" },
        callback = function()
            vim.cmd "Black"
        end
    }
)
