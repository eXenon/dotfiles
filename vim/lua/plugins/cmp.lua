return {
    {
        "echasnovski/mini.icons",
        version = false,
        config = function()
            -- this is the compatibility fix for plugins that only support nvim-web-devicons
            require("mini.icons").mock_nvim_web_devicons()
            require("mini.icons").tweak_lsp_kind()
        end,
        lazy = true,
    },
    { "hrsh7th/cmp-nvim-lsp", lazy = true },
    { "hrsh7th/cmp-path", lazy = true },
    { "hrsh7th/cmp-buffer", lazy = true },
    { "hrsh7th/cmp-omni", lazy = true },
    { "hrsh7th/cmp-cmdline", lazy = true },
    { "quangnguyen30192/cmp-nvim-ultisnips", lazy = true },
    {
        "hrsh7th/nvim-cmp",
        name = "nvim-cmp",
        event = "VeryLazy",
        config = function()
            require("config.cmp")
        end,
    },
    {
        "SirVer/ultisnips",
        dependencies = {
            "honza/vim-snippets",
        },
        event = "InsertEnter",
    },
}
