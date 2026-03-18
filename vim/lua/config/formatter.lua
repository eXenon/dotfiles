require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        javascript = { "prettier", stop_after_first = true },
        clojure = { "cljfmt" },
        css = { "stylelint" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 2000,
        lsp_format = "fallback",
    },
})
