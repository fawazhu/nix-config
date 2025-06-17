local cmp = require('cmp')
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local luasnip = require("luasnip")
local luasnip_loaders_from_vscode = require("luasnip.loaders.from_vscode")

vim.lsp.inlay_hint.enable(true)
lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
    "force",
    lspconfig.util.default_config.capabilities,
    cmp_nvim_lsp.default_capabilities(),
    { textDocument = { completion = { completionItem = { snippetSupport = true } } } }
)

lspconfig.ansiblels.setup({})
lspconfig.bashls.setup({})
lspconfig.cssls.setup({})
lspconfig.dockerls.setup({})
lspconfig.gopls.setup({})
lspconfig.graphql.setup({})
lspconfig.html.setup({})
lspconfig.ts_ls.setup({})
lspconfig.jsonls.setup({})
lspconfig.lua_ls.setup({})
lspconfig.marksman.setup({})
lspconfig.protols.setup({})
lspconfig.pyright.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.terraformls.setup({})
lspconfig.taplo.setup({})
lspconfig.lemminx.setup({})
lspconfig.yamlls.setup({
    yaml = {
        customTags = {
            "!reference sequence",
        },
        schemaStore = {
            enable = true,
        },
        schemas = {
            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
                "**/.gitlab-ci.yml",
                "**/.gitlab-ci.yaml",
                "**/*.gitlab-ci.yml",
                "**/*.gitlab-ci.yaml",
                "/.gitlab/*.yml",
                "/.gitlab/*.yaml",
            },
        },
        yamlVersion = "1.2",
    }
})
lspconfig.zls.setup({})


vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("i", "<c-h>", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<c-h>", vim.lsp.buf.hover, opts)
        vim.keymap.set("v", "<c-h>", vim.lsp.buf.hover, opts)

        vim.keymap.set("n", "gc", vim.lsp.buf.code_action)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)

        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
        vim.keymap.set("v", "<leader>r", vim.lsp.buf.rename)
    end,
})


luasnip_loaders_from_vscode.lazy_load()
vim.keymap.set("i", "<c-f>", function()
    luasnip.jump(1)
end)
vim.keymap.set("i", "<c-s>", function()
    luasnip.jump(-1)
end)


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
        end, { "i", "c" }),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            else
                cmp.complete()
            end
        end, { "i", "c" }),
        ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            else
                cmp.complete()
            end
        end, { "i", "c" }),
        ['<C-e>'] = cmp.mapping(function()
            cmp.mapping.abort()
        end, { "c" }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
})
