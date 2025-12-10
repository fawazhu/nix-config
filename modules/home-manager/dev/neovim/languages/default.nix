{hostname, pkgs, ...}: {
  home.packages = with pkgs; [
    # ansible
    ansible
    ansible-lint
    # bash
    bash
    bash-language-server
    beautysh
    # css
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier
    # docker
    dockerfile-language-server
    # go
    go
    gopls
    delve
    gofumpt
    # graphql
    #nodePackages.graphql-language-service-cli
    # html
    nodePackages.vscode-langservers-extracted
    # js
    nodejs_24
    nodemon
    typescript
    electron
    eslint
    typescript-language-server
    # json
    nodePackages.vscode-langservers-extracted
    jq
    nodePackages.fixjson
    # lua
    lua
    lua54Packages.luarocks
    lua-language-server
    # markdown
    marksman
    markdownlint-cli
    # nix
    alejandra
    nixd
    # packer
    packer
    # protocol buffers
    protols
    # python
    python313
    python313Packages.debugpy
    pyright
    ruff
    uv
    # rust
    cargo
    rustc
    rustfmt
    rust-analyzer
    lldb_18
    # terraform
    opentofu
    terraform
    terraform-ls
    # toml
    taplo
    # xml
    xq-xml
    libxml2
    lemminx
    # yaml
    yq-go
    yaml-language-server
    yamlfmt
    yamllint
    # extra
    tree-sitter
    zlib
    autoconf
    automake
    binutils
    bison
    debugedit
    fakeroot
    file
    findutils
    flex
    gawk
    gcc
    gettext
    gnugrep
    groff
    gzip
    libtool
    gnum4
    gnumake
    gnupatch
    gnused
    texinfo
    which
  ];

  programs.neovim.plugins = with pkgs; with vimPlugins; [
    cmp_luasnip
    cmp-path
    conform-nvim
    friendly-snippets
    luasnip
    nvim-cmp
    nvim-dap
    nvim-dap-go
    nvim-dap-python
    nvim-lspconfig
    nvim-treesitter
    markdown-preview-nvim
    SchemaStore-nvim
  ];
  programs.neovim.extraLuaPackages = ps: [ ps.jsregexp ];
  xdg.configFile."nvim/after/plugin/conform.lua".source = ./conform.lua;
  xdg.configFile."nvim/after/plugin/dap.lua".source = ./dap.lua;
  xdg.configFile."nvim/after/plugin/lsp.lua".source = ./lsp.lua;
  xdg.configFile."nvim/after/plugin/treesitter.lua".source = ./treesitter.lua;
  xdg.configFile."nvim/after/plugin/lsp-nix.lua".text = ''
    vim.lsp.config("nixd", {
       cmd = { "nixd" },
       settings = {
          nixd = {
             nixpkgs = {
                expr = 'import (builtins.getFlake github:fawazhu/nix-config).inputs.nixpkgs { }'
             },
             formatting = {
                command = { "nixfmt" },
             },
             options = {
                nixos = {
                   expr = '(builtins.getFlake github:fawazhu/nix-config).nixosConfigurations."${hostname}".options',
                },
                home_manager = {
                   expr = '(builtins.getFlake github:fawazhu/nix-config).nixosConfigurations."${hostname}".options.home-manager.users.type.getSubOptions []',
                },
             },
          },
       },
    })
  '';
}
