local keymap = function(tbl)
	local opts = { noremap = true, silent = true }
	local mode = tbl['mode']
	tbl['mode'] = nil
	local bufnr = tbl['bufnr']
	tbl['bufnr'] = nil

	for k, v in pairs(tbl) do
		if tonumber(k) == nil then
			opts[k] = v
		end
	end

	if bufnr ~= nil then
		vim.api.nvim_buf_set_keymap(bufnr, mode, tbl[1], tbl[2], opts)
	else
		vim.api.nvim_set_keymap(mode, tbl[1], tbl[2], opts)
	end
end

local nmap = function(tbl)
	tbl['mode'] = 'n'
	keymap(tbl)
end

local imap = function(tbl)
	tbl['mode'] = 'i'
	keymap(tbl)
end

local opts = { noremap = true, silent = true }

-- File explorer
nmap{'<leader>f', '<cmd>Telescope<CR>', opts}
nmap{'<leader>gr', '<cmd>Telescope lsp_references<CR>', opts}
nmap{'<leader>gd', '<cmd>Telescope lsp_definitions<CR>', opts}
nmap{'<leader>gt', '<cmd>Telescope lsp_type_definitions<CR>', opts}
nmap{'<leader>go', '<cmd>Telescope lsp_outgoing_calls<CR>', opts}
nmap{'<leader>gi', '<cmd>Telescope lsp_incoming_calls<CR>', opts}

-- Buffer movements
nmap{'J', ':bprevious<CR>', opts}
nmap{'K', ':bnext<CR>', opts}
nmap{'D', ':bdelete<CR>', opts}
