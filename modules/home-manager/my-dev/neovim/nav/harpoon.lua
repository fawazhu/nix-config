vim.keymap.set('n', '<A-m>', function() require('harpoon.mark').add_file() end)
vim.keymap.set('n', '<A-n>', function() require('harpoon.ui').toggle_quick_menu() end)
for j = 1, 9, 1 do
    vim.keymap.set("n", ("<A-" .. j) .. ">", function() require("harpoon.ui").nav_file(j) end)
end
