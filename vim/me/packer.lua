return require("packer").startup(function(use)
    -- Packer can manage itself!
    use "wbthomason/packer.nvim"

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Catppuccin Colorscheme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Treesitter & related
    use { "nvim-treesitter/nvim-treesitter", run = { ':TSUpdate' } }
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/playground"

    -- Undotree
    use "mbbill/undotree"

    -- Git integration
    use "tpope/vim-fugitive"

    -- Load neovim lua API
    use "folke/neodev.nvim"
    require("neodev").setup({}) -- This needs to be set up before the LSP

    -- LSP
    use "neovim/nvim-lspconfig"
    use {
        "williamboman/mason.nvim",
        requires = {
            "mhartington/formatter.nvim",
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-lint",
        }
    }
    use "williamboman/mason-lspconfig.nvim"
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    -- Jinja higlighting
    use "hiphish/jinja.vim"

    -- Black formatting
    use 'ambv/black'

    -- Isort formatting
    use 'stsewd/isort.nvim'

    -- Setup
    local lsp_zero = require("lsp-zero")
    require("mason").setup({})
    require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
            lsp_zero.default_setup,
            lua_ls = function()
                -- local lua_opts = lsp_zero.nvim_lua_ls()
                -- require('lspconfig').lua_ls.setup(lua_opts)
            end,
        }
    })
end)
