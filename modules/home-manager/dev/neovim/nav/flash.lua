local cinnamon = require("cinnamon")

-- Flash.nvim integration:
local flash = require("flash")
local jump = require("flash.jump")

flash.setup({
  search = {
    multi_window = false,
    mode = "fuzzy",
  },
  modes = {
    search = {
      enabled = true,
    },
    char = {
      enabled = false,
    },
  },
  action = function(match, state)
    cinnamon.scroll(function()
      jump.jump(match, state)
      jump.on_jump(state)
    end)
  end,
})

vim.keymap.set("n", "s", flash.jump)
vim.keymap.set("o", "s", flash.jump)
vim.keymap.set("v", "s", flash.jump)
vim.keymap.set("n", "S", flash.treesitter)
vim.keymap.set("o", "S", flash.treesitter)
vim.keymap.set("v", "S", flash.treesitter)
vim.keymap.set("o", "r", flash.remote)
vim.keymap.set("o", "R", flash.treesitter)
