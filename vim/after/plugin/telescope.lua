local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        mappings = {
            i = {
                -- Map a single ESC key to directly exit telescope
                ["<esc>"] = actions.close,
            },
        },
    },
})
telescope.load_extension('fzf')

vim.keymap.set("n", "s", builtin.buffers, {})
vim.keymap.set("n", "f", builtin.find_files, {})
vim.keymap.set("n", "F", builtin.git_files, {})
vim.keymap.set("n", "<leader>s", builtin.live_grep, {})
