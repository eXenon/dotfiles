vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "bb" },
    callback = function()
        vim.o.syntax = "clojure"
    end
})
vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "clj", "clojure", "bb" },
    callback = function()
        -- Toggle this for vim-sexp to not go into insert mode after wrapping something
        vim.g.sexp_insert_after_wrap = 0
        -- Toggle this to disable automatically creating closing brackets and quotes
        vim.g.sexp_enable_insert_mode_mappings = 1

        vim.lsp.start({
            name = "clojure-lsp",
            cmd = { "clojure-lsp" },
            root_dir = vim.fs.dirname(vim.fs.find({ ".lsp" }, { upward = true })[1])
        })
    end
})
