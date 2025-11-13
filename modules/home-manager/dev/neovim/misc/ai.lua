require("mcphub").setup({})
require("codecompanion").setup({
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          -- MCP Tools
          make_tools = true,              -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true,      -- Show tool results directly in chat buffer
          format_tool = nil,               -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = true,                -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true,      -- Add MCP prompts as /slash commands
        }
      }
    },
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
            return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                    api_key = "TERM"
                }
            })
        end,
    }
})
require('minuet').setup {
    virtualtext = {
        auto_trigger_ft = { '*' },
        keymap = {
            accept = '<C-q>',
            accept_line = '<C-Q>l',
            prev = '<C-Q>[',
            next = '<C-Q>]',
            dismiss = '<C-w>',
        },
    },
    provider = 'openai_fim_compatible',
    n_completions = 1,
    context_window = 512,
    provider_options = {
        openai_fim_compatible = {
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            model = 'qwen2.5-coder:1.5b-instruct',
            optional = {
                max_tokens = 56,
                top_p = 0.9,
            },
        },
    },
}
vim.keymap.set("n", "<A-s>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<A-s>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
