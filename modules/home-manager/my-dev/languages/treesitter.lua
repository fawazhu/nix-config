local treesitter_path = "~/.local/share/nvim/treesitter"
vim.o.runtimepath = treesitter_path .. "," .. vim.o.runtimepath
require('nvim-treesitter.configs').setup({
    ensure_installed = { "bash", "c", "regex", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc" },
    parser_install_dir = treesitter_path,
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
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
})

-- Fix indentation based on treesitter.
vim.keymap.set("n", "<leader>ft", "gg=G")

-- Auto update grammers
vim.cmd(":TSUpdate")

-- Fix highlighting if inconsistent (bug workaround).
vim.keymap.set("n", "<leader>lt", ":write | edit | TSBufEnable highlight<CR>")
