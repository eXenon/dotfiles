-- Set linenumbers
vim.opt.nu = true
vim.opt.relativenumber = false

-- Expand tabs to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

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

-- Always reload from disk
vim.opt.autoread = true

-- Show illegal whitespaces
vim.opt.list = true
vim.opt.listchars["tab"] = "»"
vim.opt.listchars["trail"] = "·"
vim.opt.listchars["nbsp"] = "⎵"
vim.opt.listchars["precedes"] = "◀"
vim.opt.listchars["extends"] = "▶"
