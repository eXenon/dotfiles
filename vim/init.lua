vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Generic keymaps and settings
require("config.keymaps")
require("config.settings")

-- Load plugins (loads every spec from lua/plugins/)
require("config.lazy")
--   Plugin specific config
require("config.treesitter")
require("config.colorscheme")
require("config.telescope")
require("config.undotree")

-- All the things LSP
require("config.lsp")

-- Custom function packages
require("config.qmk")

-- Language specific packages
require("language.html")
require("language.ocaml")
require("language.clojure")
require("language.python")


-- dofile(os.getenv("HOME") .. "/.config/nvim/me/packer.lua")
-- dofile(os.getenv("HOME") .. "/.config/nvim/me/specific.lua")
-- dofile(os.getenv("HOME") .. "/.config/nvim/me/qmk.lua")
-- dofile(os.getenv("HOME") .. "/.config/nvim/me/python.lua")
