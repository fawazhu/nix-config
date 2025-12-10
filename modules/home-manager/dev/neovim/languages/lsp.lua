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
        vim.lsp.codelens.run(opts.buffer, function(list)
                if not list or #list == 0 then
                    return
                end

                require('telescope.pickers').new({}, {
                    prompt_title = 'Code Lens Actions',
                    finder = require('telescope.finders').new_table {
                        results = list,
                        entry_maker = function(entry)
                            return {
                                value = entry,
                                display = entry.title,
                                ordinal = entry.title,
                            }
                        end,
                    },
                    sorter = require('telescope.config').values.generic_sorter(),
                    attach_mappings = function(prompt_bufnr)
                        require('telescope.actions').select_default:enhance {
                            posthook = function()
                                local entry = require('telescope.state').get_selected_entry()
                                if entry and entry.value and entry.value.command then
                                    vim.lsp.buf.execute_command(opts.buffer, entry.value.command)
                                end
                            end,
                        }
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
    -- The pattern '*' ensures this runs for any filetype when a server attaches.
    pattern = "*",
    callback = function(args)
        -- args.buf gives you the specific buffer number (e.g., 1, 2, 3...)
        local bufnr = args.buf

        -- Check if the attached client (the LSP server) supports CodeLens.
        -- This prevents errors if a server that doesn't support CodeLens attaches.
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- Safely check if the client is valid and advertises CodeLens capability
        if client and client.server_capabilities.codeLensProvider then

            -- This function sends the request to the server and handles display.
            -- Using bufnr here ensures we target the correct, attached buffer.
            vim.lsp.codelens.refresh({bufnr = bufnr})
        end
    end,
})
