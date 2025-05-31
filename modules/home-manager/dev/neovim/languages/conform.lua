vim.keymap.set("n", "<leader>ff", function()
    require("conform").format({ async = false, lsp_fallback = true, timeout_ms = 5000 })
end)

require("conform").setup({
    formatters_by_ft = {
        bash = { "beautysh" },
        go = { "gofumpt" },
        json = { "fixjson", "jq" },
        markdown = { "markdownlint" },
        nix = { "alejandra" },
        packer = { "packer_fmt" },
        python = { "ruff_format" },
        rust = { "rustfmt" },
        sh = { "beautysh" },
        terraform = { "terraform_fmt" },
        toml = { "taplo" },
        xml = { "xmllint" },
        yaml = { "yamlfmt" },
        ["_"] = { "trim_whitespace" },
    }
})
