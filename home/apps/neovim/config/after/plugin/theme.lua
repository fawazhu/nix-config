vim.cmd.colorscheme "catppuccin-latte"

require("catppuccin").setup({
    integrations = {
        cmp = true,
        gitsigns = true,
        harpoon = true,
        indent_blankline = {
            enabled = true,
            scope_color = "sky",
            colored_indent_levels = false,
        },
        lsp_trouble = true,
        mason = true,
        nvimtree = true,
        telescope = true,
        treesitter = true
    }
})
