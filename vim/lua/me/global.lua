-- Set global options
local global = {
  mapleader = " ",
}

for k, v in pairs(global) do
  vim.g[k] = v
end

-- Set options that are somehow registered differently
local options = {
  mouse = "",
  cursorline = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,
  autoread = true,
  nu = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
