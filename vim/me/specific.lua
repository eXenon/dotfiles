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


--- Clojure
-- Map leader to comma
vim.g.maplocalleader=","

-- Toggle this for vim-sexp to not go into insert mode after wrapping something
vim.g.sexp_insert_after_wrap = 0
-- Toggle this to disable automatically creating closing brackets and quotes
vim.g.sexp_enable_insert_mode_mappings = 1

--- SuperHTML LSP
 vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "html", "shtml", "htm" },
    callback = function()
        vim.lsp.start({
            name = "superhtml",
            cmd = { "superhtml", "lsp" },
            root_dir = vim.fs.dirname(vim.fs.find({".git"}, { upward = true })[1])
        })
    end
 })
