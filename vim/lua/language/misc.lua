-- Fish LSP
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "fish",
    callback = function()
        vim.lsp.start({
            name = "fish-lsp",
            cmd = { "fish-lsp", "start" },
        })
    end
})

-- Lua LSP
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "lua",
    callback = function()
        vim.lsp.start({
            name = "lua-lsp",
            cmd = { "lua-language-server" },
        })
    end
})
