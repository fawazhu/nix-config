local treesitter_path = "~/.local/share/nvim/treesitter"
vim.o.runtimepath = treesitter_path .. "," .. vim.o.runtimepath
require('nvim-treesitter').setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "gni",
            scope_incremental = "gnc",
            node_decremental = "gnd",
        },
    },
    indent = {
        enable = true,
    },
    semantic_tokens = {
        enable = true,
        enable_delay = 100,
    },
})

-- Fix indentation based on treesitter.
vim.keymap.set("n", "<leader>ft", "gg=G")

-- Fix highlighting if inconsistent (bug workaround).
vim.keymap.set("n", "<leader>lt", ":write | edit | TSBufEnable highlight<CR>")
