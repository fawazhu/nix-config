vim.g.mapleader = " " -- Space is quite a useless command in vim so good leader key.

-- Unset problematic keybindings
vim.keymap.set("n", "Q", "<nop>") -- We don't need ex mode.

-- Move entire lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Clipboard management (system clipboard)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
