local lsp_zero = require('lsp-zero').preset({})

lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- Configure pre-installed language servers.
local lsp_config = require('lspconfig')
lsp_config.lua_ls.setup(lsp_zero.nvim_lua_ls())
lsp_config.rust_analyzer.setup({})

lsp_zero.setup()

-- Configure Mason
require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})
require('mason-tool-installer').setup {
    ensure_installed = {
        "bash-language-server",
        "dockerfile-language-server",
        "gitleaks",
        "gopls",
        "jq",
        "nil",
        "prettier",
        "python-lsp-server",
        "shellcheck",
        "shellharden",
        "shfmt",
        "terraform-ls",
        "yaml-language-server",
        "yamllint",
    }
}

-- You need to setup `cmp` after lsp-zero
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = {
        ["<C-y>"] = cmp.mapping(function()
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    cmp.confirm()
                else
                    cmp.confirm()
                end
            else
                cmp.confirm()
            end
        end, { "i", "s", "c", }),

        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})
