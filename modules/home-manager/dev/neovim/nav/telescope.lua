local builtin = require('telescope.builtin')
local telescope = require('telescope')
telescope.setup {
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown {}
        }
    }
}
telescope.load_extension('ui-select')

vim.keymap.set('n', '<leader>pa', function()
    builtin.find_files({
        find_command = {
            "fd",
            "--type",
            "f",
            "--color",
            "never",
            "--hidden",
            "--no-ignore-vcs",
            "-L",
            "--exclude",
            ".git/**/*",
        }
    })
end)
vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({
        find_command = {
            "fd",
            "--type",
            "f",
            "--color",
            "never",
            "--hidden",
            "-L",
            "--exclude",
            ".git/**/*",
        }
    })
end)
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({
        search = vim.fn.input('Grep: '),
        vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column',
            '--smart-case', '--hidden', '--glob=!\\.git/**/*' }
    })
end)
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>po', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>pj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>pc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>px', builtin.git_bcommits, {})
vim.keymap.set('n', '<leader>e', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>pq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>pk', builtin.keymaps, {})
