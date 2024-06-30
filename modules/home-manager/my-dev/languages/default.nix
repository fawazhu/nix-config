{
  config,
  lib,
  pkgs,
  ...
}: let
  l = config.my-dev.languages;
  luasnip = pkgs.neovimUtils.buildNeovimPlugin {
    name = "luasnip";
    pname = "luasnip";
  };
in {
  config = lib.mkIf config.my-dev.enable {
    home.packages = with pkgs;
      (
        if l.ansible.enable
        then [ansible ansible-lint ansible-language-server]
        else []
      )
      ++ (
        if l.bash.enable
        then [bash bash-language-server beautysh]
        else []
      )
      ++ (
        if l.css.enable
        then [nodePackages.vscode-langservers-extracted sass]
        else []
      )
      ++ (
        if l.docker.enable
        then [dockerfile-language-server-nodejs]
        else []
      )
      ++ (
        if l.go.enable
        then [
          go
          gopls
          delve
          gofumpt
          /*
          gotools
          */
        ]
        else []
      )
      ++ (
        if l.graphql.enable
        then [nodePackages.graphql-language-service-cli]
        else []
      )
      ++ (
        if l.html.enable
        then [nodePackages.vscode-langservers-extracted rubyPackages.htmlbeautifier ruby]
        else []
      )
      ++ (
        if l.javascript.enable
        then with nodePackages; [nodejs_22 nodemon typescript electron eslint typescript-language-server]
        else []
      )
      ++ (
        if l.json.enable
        then [nodePackages.vscode-langservers-extracted jq nodePackages.fixjson]
        else []
      )
      ++ (
        if l.lua.enable
        then [lua lua54Packages.luarocks lua-language-server]
        else []
      )
      ++ (
        if l.markdown.enable
        then [marksman markdownlint-cli]
        else []
      )
      ++ (
        if l.nix.enable
        then [alejandra nil]
        else []
      )
      ++ (
        if l.packer.enable
        then [packer]
        else []
      )
      ++ (
        if l.python.enable
        then with python312Packages; [python312 pip pyright debugpy autopep8]
        else []
      )
      ++ (
        if l.rust.enable
        then [cargo rustc rustfmt rust-analyzer lldb_18]
        else []
      )
      ++ (
        if l.terraform.enable
        then [opentofu terraform terraform-ls]
        else []
      )
      ++ (
        if l.toml.enable
        then [taplo]
        else []
      )
      ++ (
        if l.xml.enable
        then [xq-xml libxml2 lemminx]
        else []
      )
      ++ (
        if l.yaml.enable
        then [yq-go yaml-language-server yamlfmt]
        else []
      )
      ++ [tree-sitter gawk];

    programs.neovim.plugins = with pkgs.vimPlugins;
    with pkgs;
      (
        if l.python.enable
        then [nvim-dap-python]
        else []
      )
      ++ (
        if l.go.enable
        then [nvim-dap-go]
        else []
      )
      ++ [
        lsp-zero-nvim
        nvim-lspconfig
        nvim-cmp
        luasnip
        friendly-snippets
        cmp_luasnip
        cmp-nvim-lsp
        cmp-path
        nvim-treesitter
        nvim-dap
        conform-nvim
      ];

    xdg.configFile."nvim/after/plugin/languages.lua".text = ''
      local dap = require('dap')
      local lsp_zero = require('lsp-zero').preset({})
      local lspconfig = require('lspconfig')

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

      ${
        if l.ansible.enable
        then ''
          lspconfig.ansiblels.setup({})
        ''
        else ""
      }
      ${
        if l.bash.enable
        then ''
          lspconfig.bashls.setup({})
        ''
        else ""
      }
      ${
        if l.css.enable
        then ''
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true

          lspconfig.cssls.setup({
            capabilities = capabilities,
          })
        ''
        else ""
      }
      ${
        if l.docker.enable
        then ''
          lspconfig.dockerls.setup({})
        ''
        else ""
      }
      ${
        if l.go.enable
        then ''
          lspconfig.gopls.setup({})
          dap.adapters.delve = {
            type = 'server',
            port = "''${port}",
            executable = {
              command = 'dlv',
              args = {'dap', '-l', '127.0.0.1:''${port}'},
            }
          }

          dap.configurations.go = {
            {
              type = "delve",
              name = "Debug",
              request = "launch",
              program = "''${file}"
            },
            {
              type = "delve",
              name = "Debug test", -- configuration for debugging test files
              request = "launch",
              mode = "test",
              program = "''${file}"
            },
            -- works with go.mod packages and sub packages
            {
              type = "delve",
              name = "Debug test (go.mod)",
              request = "launch",
              mode = "test",
              program = "./''${relativeFileDirname}"
            }
          }
        ''
        else ""
      }
      ${
        if l.graphql.enable
        then ''
          lspconfig.graphql.setup({})
        ''
        else ""
      }
      ${
        if l.html.enable
        then ''
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true

          lspconfig.html.setup ({
            capabilities = capabilities,
          })
        ''
        else ""
      }
      ${
        if l.javascript.enable
        then ''
          lspconfig.tsserver.setup({})
        ''
        else ""
      }
      ${
        if l.json.enable
        then ''
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true

          require'lspconfig'.jsonls.setup {
            capabilities = capabilities,
          }
        ''
        else ""
      }
      ${
        if l.lua.enable
        then ''
          lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
        ''
        else ""
      }
      ${
        if l.markdown.enable
        then ''
          lspconfig.marksman.setup({})
        ''
        else ""
      }
      ${
        if l.nix.enable
        then ''
          lspconfig.nil_ls.setup({})
        ''
        else ""
      }
      ${
        if l.python.enable
        then ''
          lspconfig.pyright.setup({})
          require('dap-python').setup('python')
        ''
        else ""
      }
      ${
        if l.rust.enable
        then ''
          lspconfig.rust_analyzer.setup({})
        ''
        else ""
      }
      ${
        if l.terraform.enable
        then ''
          lspconfig.terraformls.setup({})
        ''
        else ""
      }
      ${
        if l.toml.enable
        then ''
          lspconfig.taplo.setup({})
        ''
        else ""
      }
      ${
        if l.xml.enable
        then ''
          lspconfig.lemminx.setup({})
        ''
        else ""
      }
      ${
        if l.yaml.enable
        then ''
          lspconfig.yamlls.setup({
            settings = {
              yaml = {
                customTags = {
                  "!reference"
                },
              },
            }
          })
        ''
        else ""
      }
      require("conform").setup({
        formatters_by_ft = {
          ${
        if l.nix.enable
        then ''
          nix = { "alejandra" },
        ''
        else ""
      }
          ${
        if l.python.enable
        then ''
          python = { "autopep8" },
        ''
        else ""
      }
          ${
        if l.bash.enable
        then ''
          sh = { "beautysh" },
          bash = { "beautysh" },
        ''
        else ""
      }
          ${
        if l.json.enable
        then ''
          json = { "fixjson", "jq" },
        ''
        else ""
      }
          ${
        if l.go.enable
        then ''
          go = { "gofumpt", "goimports" },
        ''
        else ""
      }
          ${
        if l.html.enable
        then ''
          html = { "htmlbeautifier" },
        ''
        else ""
      }
          ${
        if l.markdown.enable
        then ''
          markdown = { "markdownlint" },
        ''
        else ""
      }
          ${
        if l.packer.enable
        then ''
          packer = { "packer_fmt" },
        ''
        else ""
      }
          ${
        if l.rust.enable
        then ''
          rust = { "rustfmt" },
        ''
        else ""
      }
          ${
        if l.terraform.enable
        then ''
          terraform = { "terraform_fmt" },
        ''
        else ""
      }
          ${
        if l.xml.enable
        then ''
          xml = { "xmllint" },
        ''
        else ""
      }
          ${
        if l.yaml.enable
        then ''
          toml = { "taplo" },
        ''
        else ""
      }
          ${
        if l.yaml.enable
        then ''
          yaml = { "yamlfmt" },
        ''
        else ""
      }
          ["_"] = { "trim_whitespace" },
        },
      })
    '';

    xdg.configFile."nvim/after/plugin/conform.lua".source = ./conform.lua;
    xdg.configFile."nvim/after/plugin/dap.lua".source = ./dap.lua;
    xdg.configFile."nvim/after/plugin/lsp.lua".source = ./lsp.lua;
    xdg.configFile."nvim/after/plugin/treesitter.lua".source = ./treesitter.lua;
  };
}
