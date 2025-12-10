local cinnamon = require("cinnamon")

-- Flash.nvim integration:
local flash = require("flash")
local jump = require("flash.jump")

flash.setup({
  action = function(match, state)
    cinnamon.scroll(function()
      jump.jump(match, state)
      jump.on_jump(state)
    end)
  end,
  labels = "asdfghjklqwertyuiopzxcvbnm0123456789",
  char = {
    wrap = true,
  },
  modes = {
    search = {
      enabled = true,
    },
  },
  search = {
    mode = "fuzzy",
  },
})

vim.keymap.set("n", "s", flash.jump)
vim.keymap.set("o", "s", flash.jump)
vim.keymap.set("v", "s", flash.jump)
vim.keymap.set("n", "S", flash.treesitter)
vim.keymap.set("o", "S", flash.treesitter)
vim.keymap.set("v", "S", flash.treesitter)
vim.keymap.set("o", "r", flash.remote)
vim.keymap.set("o", "r", flash.treesitter_search)
vim.keymap.set("v", "r", flash.treesitter_search)
vim.keymap.set("c", "<c-s>", flash.toggle)
