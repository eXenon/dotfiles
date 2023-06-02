vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("n", "<leader><Right>", vim.cmd.bnext)
vim.keymap.set("n", "<leader><Left>", vim.cmd.bprev)

-- Move blocks in visual mode, reindenting on the fly
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in the middle when doing stuff
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Keep cursor at the beginning of the line
vim.keymap.set("n", "J", "mzJ`z")

-- Paste over selected text, but don't change the value in the buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Copy-paste using system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- Delete without putting into the buffer
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Quickfix navigation
vim.keymap.set("n", "<leader>qn", ":cn<CR>")
vim.keymap.set("n", "<leader>qp", ":cp<CR>")

-- Integrate with local envs
local makefile = #(vim.fs.find('Makefile', {}))
function fallback()
    print("No Makefile detected.")
end
if makefile > 0 then
    vim.keymap.set("n", "<leader>mf", ":!make format<CR>")
    vim.keymap.set("n", "<leader>mc", ":!make check<CR>")
    vim.keymap.set("n", "<leader>mb", ":!make build<CR>")
else
    vim.keymap.set("n", "<leader>mf", fallback)
    vim.keymap.set("n", "<leader>mc", fallback)
    vim.keymap.set("n", "<leader>mb", fallback)
end
