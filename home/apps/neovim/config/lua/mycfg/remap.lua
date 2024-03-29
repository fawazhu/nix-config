vim.g.mapleader = " " -- Space is quite a useless command in vim so good leader key.

-- Unset problematic keybindings
vim.keymap.set("n", "Q", "<nop>") -- We don't need ex mode.
vim.keymap.set("i", "<c-y>", "<nop>") -- TODO: investigate impact of LSP remapping.

-- Undo mapping
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- File management (rest is set with telescope)
vim.keymap.set("n", "<leader>pd", vim.cmd.NvimTreeToggle)

-- Move entire lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste over without affecting buffer.
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Clipboard management (system clipboard)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Format
vim.keymap.set("n", "<leader>ff", function()
    vim.lsp.buf.format({ async = false, timeout_ms = 5000 })
end)
vim.keymap.set("n", "<leader>ft", "gg=G") -- fix indentation.

-- Find and replace all occurrences
vim.keymap.set("n", "<leader>rr", ":%s/<c-r><c-w>/<c-r><c-w>/gI<Left><Left><Left>") -- I usually just write these out nowadays. Consider removing.
vim.keymap.set("v", "<leader>rr", "<Esc>:%s/<c-r><c-w>/<c-r><c-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>rt", vim.lsp.buf.rename)
vim.keymap.set("v", "<leader>rt", vim.lsp.buf.rename)

-- LSP
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.declaration)
vim.keymap.set("n", "<leader>lD", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>lc", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references)
vim.keymap.set("i", "<c-h>", vim.lsp.buf.hover)
vim.keymap.set("n", "<c-h>", vim.lsp.buf.hover)
vim.keymap.set("v", "<c-h>", vim.lsp.buf.hover)

-- Errors -- I don't really use these.
vim.keymap.set("n", "<leader>ee", "<cmd>TroubleToggle<cr>", { noremap = true })
vim.keymap.set("n", "<leader>eq", "<cmd>TroubleToggle quickfix<cr>", { noremap = true })

-- Git
vim.keymap.set('n', '<leader>gd', '<cmd>Gitsigns diffthis<cr>') -- This one is actually really useful and I need to use it more.
vim.keymap.set('n', '<leader>gf', ':DiffviewFileHistory %<cr>')
vim.keymap.set('n', '<leader>gb', ':DiffviewFileHistory<cr>')
vim.keymap.set('n', '<leader>gc', ':DiffviewClose<cr>')
vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>')
vim.keymap.set('n', '<leader>ga', ':Git add <c-r>%<cr>') -- I don't use this one.

-- Better scrolling (centre's screen while scrolling).
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
