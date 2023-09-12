-- A bunch of language specific tweaks

---- OCaml
vim.api.nvim_create_autocmd(
    { "BufEnter" },
    {
        pattern = { "*.ml", "*.mli" },
        callback = function()
            local __current = vim.api.nvim_buf_get_name(0)
            if string.sub(__current, -3, -1) == "mli" then
                local __ml = string.gsub(__current, ".mli", ".ml")
                vim.keymap.set("n", "<leader>m", function()
                    vim.cmd("e " .. __ml)
                end)
            elseif string.sub(__current, -2, -1) == "ml" then
                local __mli = string.gsub(__current, ".ml", ".mli")
                vim.keymap.set("n", "<leader>m", function()
                    vim.cmd("e " .. __mli)
                end)
            end
        end
    }
)

---- Purescript formatter
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = { "*.purs" },
        callback = function()
            vim.fn.system("purs-tidy format-in-place src/*")
            vim.cmd("e")
            vim.cmd("set syntax=haskell")
        end
    }
)
