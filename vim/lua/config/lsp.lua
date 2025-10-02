vim = vim

vim.api.nvim_create_autocmd('lspattach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        print("LSP attached, setting up configuration.")
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id)) -- Format on save

        -- Format on save
        if client.supports_method('textDocument/formatting') then
            vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
        end

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
})
