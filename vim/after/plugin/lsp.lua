local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.on_attach(function(client, buf)
    local opts = { buffer = buf, remap = false }

    -- Default keymaps I use:
    -- gd -> goto definition
    -- K  -> display documentation under cursor
    vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>f", vim.cmd.LspZeroFormat, opts)
    vim.keymap.set("n", "<leader>t", function() vim.lsp.buf.type_definition() end, opts)
end)


lsp.setup()

-- Fixes to specific LSP setups

--  Fix Elm LSP root directory detection
local lspconfig = require('lspconfig')
lspconfig.elmls.setup({
    root_dir = function(fname)
        return vim.loop.cwd()
    end
})

--  Add Tailwind LSP to elm files
lspconfig.tailwindcss.setup({
    filetypes = { "html", "elm" },
    init_options = {
        userLanguages = {
            elm = "html",
            html = "html"
        }
    },
    settings = {
        tailwindCSS = {
            includeLanguages = {
                elm = "html",
                html = "html"
            },
            classAttributes = { "class", "className", "classList", "ngClass" },
            experimental = {
                classRegex = {
                    "\\bclass[\\s(<|]+\"([^\"]*)\"",
                    "\\bclass[\\s(]+\"[^\"]*\"[\\s+]+\"([^\"]*)\"",
                    "\\bclass[\\s<|]+\"[^\"]*\"\\s*\\+{2}\\s*\" ([^\"]*)\"",
                    "\\bclass[\\s<|]+\"[^\"]*\"\\s*\\+{2}\\s*\" [^\"]*\"\\s*\\+{2}\\s*\" ([^\"]*)\"",
                    "\\bclass[\\s<|]+\"[^\"]*\"\\s*\\+{2}\\s*\" [^\"]*\"\\s*\\+{2}\\s*\" [^\"]*\"\\s*\\+{2}\\s*\" ([^\"]*)\"",
                    "\\bclassList[\\s\\[\\(]+\"([^\"]*)\"",
                    "\\bclassList[\\s\\[\\(]+\"[^\"]*\",\\s[^\\)]+\\)[\\s\\[\\(,]+\"([^\"]*)\"",
                    "\\bclassList[\\s\\[\\(]+\"[^\"]*\",\\s[^\\)]+\\)[\\s\\[\\(,]+\"[^\"]*\",\\s[^\\)]+\\)[\\s\\[\\(,]+\"([^\"]*)\""
                }
            },
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning"
            },
            validate = true
        }
    }
})

vim.lsp.set_log_level("debug")
