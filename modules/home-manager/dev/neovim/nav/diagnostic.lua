local cinnamon = require("cinnamon")
vim.keymap.set('n', ']e', function() cinnamon.scroll(vim.diagnostic.goto_next) end, {})
vim.keymap.set('n', '[e', function() cinnamon.scroll(vim.diagnostic.goto_prev) end, {})
