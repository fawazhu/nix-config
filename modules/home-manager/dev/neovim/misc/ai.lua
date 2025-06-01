require("codecompanion").setup({
    strategies = {
        chat = {
            adapter = "qwen2_5_coder",
        },
        inline = {
            adapter = "qwen2_5_coder",
        },
    },
    adapters = {
        qwen2_5_coder = function()
            return require("codecompanion.adapters").extend("ollama", {
                name = "qwen2_5_coder",
                schema = { model = { default = "qwen2.5-coder:7b" } },
            })
        end,
    }
})
vim.keymap.set("n", "<A-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<A-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
