vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    diagnostics = {
        enable = true,
        show_on_open_dirs = true,
    },
    filesystem_watchers = {
        ignore_dirs = {
          "/.git",
          "/.terraform",
          "/build",
          "/node_modules",
          "/target",
        },
    },
    filters = {
        custom = {
            "^\\.git$"
        },
        git_ignored = false,
    },
    modified = {
        enable = true,
    },
    renderer = {
        add_trailing = true,
        group_empty = true,
        indent_markers = {
            enable = true,
            inline_arrows = false,
        },
        icons = {
            show = {
                folder_arrow = false
            },
        },
        special_files = {},
    },
    select_prompts = true,
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 25,
    },
})

vim.keymap.set("n", "<leader>pd", vim.cmd.NvimTreeToggle)
