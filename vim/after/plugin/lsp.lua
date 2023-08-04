local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.on_attach(function(client, buf)
    local opts = { buffer = buf, remap = false }

    -- Format on save
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

    -- Default keymaps I use:
    -- gd -> goto definition
    -- gR -> rename
    -- gn/gp goto next/prev issue
    vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<leader>t", function() vim.lsp.buf.type_definition() end, opts)

    -- Toggle automatic hover of info and symbol highlight
    vim.g.local_automatic_lsp_hover = true
    vim.keymap.set("n", "<leader>Ld", function()
        if vim.g.local_automatic_lsp_hover then
            vim.g.local_automatic_lsp_hover = false
            print("Disabled automatic hover info.")
        else
            vim.g.local_automatic_lsp_hover = true
            print("Enabled automatic hover info.")
        end
    end, opts)

    -- Highlight symbol under cursor
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=235 guibg=DarkBlue
      hi! LspReferenceText cterm=bold ctermbg=235 guibg=DarkBlue
      hi! LspReferenceWrite cterm=bold ctermbg=235 guibg=DarkBlue
    ]]
        vim.api.nvim_create_augroup('lsp_document_highlight', {})
        vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
            group = 'lsp_document_highlight',
            buffer = 0,
            callback = function()
                if vim.g.local_automatic_lsp_hover then
                    vim.lsp.buf.document_highlight()
                    vim.lsp.buf.hover()
                end
            end
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'lsp_document_highlight',
            buffer = 0,
            callback = vim.lsp.buf.clear_references,
        })
    end
end)


lsp.setup()

-- Fixes to specific LSP setups

--  Fix Elm LSP root directory detection
local lspconfig = require('lspconfig')
lspconfig.elmls.setup({
    root_dir = function(_)
        return vim.loop.cwd()
    end,
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
