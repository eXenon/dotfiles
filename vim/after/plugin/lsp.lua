local lsp = require('lsp-zero')
lsp.preset('recommended')

on_attach = function(client, buf)
    local opts = { buffer = buf, remap = false }

    -- Format on save
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

    -- Default keymaps I use:
    -- gn/gp goto next/prev issue
    -- gf format
    -- gt goto type type_definition
    -- gh see hover
    vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "gf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)

    -- Act on the code using the LSP
    vim.keymap.set("n", "gas", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "gar", function() vim.lsp.buf.rename() end, opts)

    -- Toggle automatic hover symbol highlight
    vim.g.local_automatic_lsp_hover = true
    vim.g.local_automatic_lsp_hover_flag = true
    vim.keymap.set("n", "gI", function()
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
                if vim.g.local_automatic_lsp_hover and vim.g.local_automatic_lsp_hover_flag then
                    vim.lsp.buf.document_highlight()
                    vim.g.local_automatic_lsp_hover_flag = false
                else
                    if vim.g.local_automatic_lsp_hover then
                        vim.lsp.buf.clear_references()
                        vim.g.local_automatic_lsp_hover_flag = true
                    end
                end
            end
        })
    end
end
lsp.on_attach(on_attach)


lsp.setup()

-- Fixes to specific LSP setups
local lspconfig = require('lspconfig')

-- Fix purescript filetype detection
vim.api.nvim_create_autocmd(
    { "BufEnter", "BufWinEnter" },
    {
        pattern = "*.purs",
        command = 'set filetype=purescript syntax=haskell',
    }
)

--  Fix Elm LSP root directory detection
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

-- OCaml LSP doesn’t work out of the box
lspconfig.ocamllsp.setup({
    filetypes = { "ocaml" },
    on_attach = on_attach,
})
