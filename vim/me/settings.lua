-- Set linenumbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Expand tabs to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- Persistent undofile, even after close
vim.opt.undofile = true

-- Don't highlight searches
vim.opt.hlsearch = false

-- Highlight regexes incrementally
vim.opt.incsearch = true

-- Pretty
vim.opt.termguicolors = true

-- Always have at least 8 lines visible when scrolling
vim.opt.scrolloff = 8

-- Always draw sign column for consistent UI
vim.opt.signcolumn = "yes"
