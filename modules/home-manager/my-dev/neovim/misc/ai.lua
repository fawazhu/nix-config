require("codecompanion").setup({
    strategies = {
        chat = {
            adapter = "qwencoder",
        },
        inline = {
            adapter = "qwencoder",
        },
    },
    adapters = {
        qwencoder = function()
            return require("codecompanion.adapters").extend("ollama", {
                name = "llamaqwen",
                schema = { model = { default = "qwen2.5-coder:1.5b" } },
            })
        end,
        codegemma = function()
            return require("codecompanion.adapters").extend("ollama", {
                name = "llamacodegemma",
                schema = { model = { default = "codegemma:2b" } },
            })
        end,
    }
})
vim.keymap.set("n", "<A-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<A-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
