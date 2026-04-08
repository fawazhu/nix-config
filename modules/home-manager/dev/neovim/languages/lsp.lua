local cinnamon = require("cinnamon")
local cmp = require('cmp')
local luasnip = require("luasnip")
local luasnip_loaders_from_vscode = require("luasnip.loaders.from_vscode")
local schemastore = require("schemastore")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}
capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = {
        vim.lsp.protocol.CompletionTag.Deprecated
    }
}
capabilities.textDocument.codeLens = { dynamicRegistration = true }
capabilities.textDocument.documentLink = { dynamicRegistration = true }
capabilities.textDocument.diagnostic = {
    tagSupport = {
        valueSet = {
            vim.lsp.protocol.DiagnosticTag.Unnecessary,
            vim.lsp.protocol.DiagnosticTag.Deprecated,
        }
    }
}
capabilities.textDocument.semanticTokens = { dynamicRegistration = true, tokenTypes = {}, tokenModifiers = {}, format = 'relative', formats = {}, requests = { range = true, full = true }, legend = {} }

capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.lsp.inlay_hint.enable(true)
vim.lsp.config("ansiblels", { capabilities = capabilities })
vim.lsp.config("bashls", { capabilities = capabilities })
vim.lsp.config("cssls", { capabilities = capabilities })
vim.lsp.config("dockerls", { capabilities = capabilities })
vim.lsp.config("gopls", {
    capabilities = capabilities,
    settings = {
        gopls = {
            codelenses = {
                test = true,
            },
        },
    },
})
vim.lsp.config("graphql", { capabilities = capabilities })
vim.lsp.config("html", { capabilities = capabilities })
vim.lsp.config("ts_ls", { capabilities = capabilities })
vim.lsp.config("jsonls", {
    capabilities = capabilities,
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true }
        }
    }
})
vim.lsp.config("lua_ls", { capabilities = capabilities })
vim.lsp.config("marksman", { capabilities = capabilities })
vim.lsp.config("protols", { capabilities = capabilities })
vim.lsp.config("pyright", { capabilities = capabilities })
vim.lsp.config("rust_analyzer", { capabilities = capabilities })
vim.lsp.config("terraformls", { capabilities = capabilities })
vim.lsp.config("taplo", {
    capabilities = capabilities,
    settings = {
        evenBetterToml = {
            schema = {
                enabled = true,
                catalogs = {
                    "https://www.schemastore.org/api/json/catalog.json"
                },
            },
        }
    }
})
vim.lsp.config("lemminx", { capabilities = capabilities })
vim.lsp.config("yamlls", {
    capabilities = capabilities,
    yaml = {
        customTags = {
            "!reference sequence",
        },
        schemaStore = {
            enable = true,
        },
        schemas = schemastore.yaml.schemas(),
        yamlVersion = "1.2",
    }
})
vim.lsp.config("zls", { capabilities = capabilities })

vim.lsp.enable("ansiblels")
vim.lsp.enable("bashls")
vim.lsp.enable("cssls")
vim.lsp.enable("dockerls")
vim.lsp.enable("gopls")
vim.lsp.enable("graphql")
vim.lsp.enable("html")
vim.lsp.enable("ts_ls")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("protols")
vim.lsp.enable("pyright")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("terraformls")
vim.lsp.enable("taplo")
vim.lsp.enable("lemminx")
vim.lsp.enable("yamlls")
vim.lsp.enable("zls")

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("i", "<c-h>", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<c-h>", vim.lsp.buf.hover, opts)
        vim.keymap.set("v", "<c-h>", vim.lsp.buf.hover, opts)

        vim.keymap.set("n", "gc", vim.lsp.buf.code_action)
        vim.keymap.set('n', 'gc', function()
            vim.lsp.buf.code_action({
                apply = true,
                context = {
                    only = { 'quickfix', 'refactor', 'source', 'organizeImports' }
                },
                filter = function(action)
                    return action.command or action.edit
                end,
                on_list = function(list)
                    require('telescope.actions').open_selected_entry(list)
                end,
            })
        end, opts)
        vim.keymap.set('n', 'gC', function()
            -- Note: Removed 'opts.buffer' argument for 0.12 compatibility
            vim.lsp.codelens.run(function(lenses)
                if not lenses or vim.tbl_isempty(lenses) then
                    vim.notify("No CodeLens available")
                    return
                end

                require('telescope.pickers').new({}, {
                    prompt_title = 'Code Lens Actions',
                    finder = require('telescope.finders').new_table {
                        results = lenses,
                        entry_maker = function(entry)
                            return {
                                value = entry,
                                display = entry.command.title, -- Standard LSP structure
                                ordinal = entry.command.title,
                            }
                        end,
                    },
                    sorter = require('telescope.config').values.generic_sorter(),
                    attach_mappings = function(prompt_bufnr, map)
                        local actions = require('telescope.actions')
                        local action_state = require('telescope.actions.state')

                        actions.select_default:replace(function()
                            actions.close(prompt_bufnr)
                            local selection = action_state.get_selected_entry()
                            -- Use the standard LSP command executor
                            vim.lsp.buf.execute_command(selection.value.command)
                        end)
                        return true
                    end,
                }):find()
            end)
        end, opts)
        vim.keymap.set("n", "gd", function() cinnamon.scroll(vim.lsp.buf.definition) end)
        vim.keymap.set("n", "gD", function() cinnamon.scroll(vim.lsp.buf.declaration) end)
        vim.keymap.set("n", "gi", function() cinnamon.scroll(vim.lsp.buf.implementation) end)
        vim.keymap.set("n", "gr", function() cinnamon.scroll(vim.lsp.buf.references) end)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'gH', vim.lsp.buf.document_highlight, opts)
        vim.keymap.set('n', '<leader>gh', vim.lsp.buf.clear_references, opts)
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
        vim.keymap.set("v", "<leader>r", vim.lsp.buf.rename)
    end,
})

vim.defer_fn(function()
    require('schemastore').load()
end, 0)

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

-- Autocommand to refresh CodeLens whenever a language server attaches
vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "*",
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client and client.server_capabilities.codeLensProvider then
            -- Initial refresh on attach
            -- In 0.12+, simply calling get() triggers the underlying refresh mechanism
            vim.lsp.codelens.get()

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                buffer = bufnr,
                callback = function()
                    -- This is the modern replacement that avoids the bufnr deprecation
                    vim.lsp.codelens.refresh()
                end,
            })
        end
    end,
})
