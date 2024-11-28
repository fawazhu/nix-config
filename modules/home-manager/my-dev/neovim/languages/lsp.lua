local lsp_zero = require('lsp-zero').preset({})

lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

lsp_zero.setup()

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
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
        ["<C-f>"] = cmp_action.luasnip_jump_forward(),
        ["<C-s>"] = cmp_action.luasnip_jump_backward(),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    }
})

local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.ansiblels.setup({})
lspconfig.bashls.setup({})
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.dockerls.setup({})
lspconfig.gopls.setup({})
lspconfig.graphql.setup({})
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({})
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
lspconfig.marksman.setup({})
lspconfig.nil_ls.setup({
    nix = {
        flake = {
            autoArchive = true,
            autoEvalInputs = true,
        },
    },
})
lspconfig.pyright.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.terraformls.setup({})
lspconfig.taplo.setup({})
lspconfig.lemminx.setup({})
lspconfig.yamlls.setup({
    settings = {
        yaml = {
            customTags = {
                "!reference"
            },
        },
    }
})

vim.keymap.set("v", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set("n", "gc", vim.lsp.buf.code_action)
vim.keymap.set("i", "<c-h>", vim.lsp.buf.hover)
vim.keymap.set("n", "<c-h>", vim.lsp.buf.hover)
vim.keymap.set("v", "<c-h>", vim.lsp.buf.hover)
