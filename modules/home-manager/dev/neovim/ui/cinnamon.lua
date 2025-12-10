local cinnamon = require("cinnamon")

cinnamon.setup({
    options = {
        delay = 2,
        max_delta = {
            time = 500,
        },
    },
})

-- Centered scrolling
vim.keymap.set("n", "<C-U>", function() cinnamon.scroll("<C-U>zz") end)
vim.keymap.set("n", "<C-D>", function() cinnamon.scroll("<C-D>zz") end)
vim.keymap.set('n', 'n', function() cinnamon.scroll("n") end)
vim.keymap.set('n', 'N', function() cinnamon.scroll("N") end)
