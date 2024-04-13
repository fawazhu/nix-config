vim.keymap.set("n", "<leader>ff", function()
    require("conform").format({ async = false, lsp_fallback = true, timeout_ms = 5000 })
end)
