vim.keymap.set('n', '<leader>gd', '<cmd>Gitsigns diffthis<cr>') -- This one is actually really useful and I need to use it more.
vim.keymap.set('n', '<leader>gf', ':DiffviewFileHistory %<cr>')
vim.keymap.set('n', '<leader>gb', ':DiffviewFileHistory<cr>')
vim.keymap.set('n', '<leader>gc', ':DiffviewClose<cr>')
vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>')

require("diffview").setup()

require('gitsigns').setup {
    attach_to_untracked          = true,
    current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 50,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 500,
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
}
