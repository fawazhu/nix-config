local telescope = require('telescope')
telescope.setup {
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown {}
        }
    }
}
telescope.load_extension('ui-select')

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', telescope_builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    telescope_builtin.grep_string({
        search = vim.fn.input('Grep: '),
        vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column',
            '--smart-case', '--hidden', '--glob=!\\.git/**/*' }
    })
end)
vim.keymap.set('n', '<leader>pb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>po', telescope_builtin.oldfiles, {})
vim.keymap.set('n', '<leader>pj', telescope_builtin.jumplist, {})
vim.keymap.set('n', '<leader>pc', telescope_builtin.git_commits, {})
vim.keymap.set('n', '<leader>px', telescope_builtin.git_bcommits, {})
vim.keymap.set('n', '<leader>e', telescope_builtin.diagnostics, {})
vim.keymap.set('n', '<leader>pq', telescope_builtin.quickfix, {})
