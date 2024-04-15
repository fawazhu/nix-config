local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', telescope.find_files, {})
vim.keymap.set('n', '<leader>pg', telescope.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    telescope.grep_string({
        search = vim.fn.input('Grep: '),
        vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column',
            '--smart-case', '--hidden', '--glob=!\\.git/**/*' }
    })
end)
vim.keymap.set('n', '<leader>pb', telescope.buffers, {})
vim.keymap.set('n', '<leader>po', telescope.oldfiles, {})
vim.keymap.set('n', '<leader>pj', telescope.jumplist, {})
vim.keymap.set('n', '<leader>pc', telescope.git_commits, {})
vim.keymap.set('n', '<leader>px', telescope.git_bcommits, {})
vim.keymap.set('n', '<leader>e', telescope.diagnostics, {})
vim.keymap.set('n', '<leader>q', telescope.quickfix, {})
