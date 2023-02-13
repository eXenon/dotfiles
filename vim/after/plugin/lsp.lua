local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
	'sumneko_lua',
})

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

vim.lsp.set_log_level("debug")
