{pkgs, ...}: {
  home.packages = with pkgs; [
    # ansible
    ansible
    ansible-lint
    ansible-language-server
    # bash
    bash
    bash-language-server
    beautysh
    # css
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier
    # docker
    dockerfile-language-server-nodejs
    # go
    go
    gopls
    delve
    gofumpt
    # graphql
    nodePackages.graphql-language-service-cli
    # html
    nodePackages.vscode-langservers-extracted
    # js
    nodejs_23
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
    nil
    # packer
    packer
    # python
    python313
    python313Packages.debugpy
    pyright
    ruff
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
    cmp-nvim-lsp
    cmp-path
    conform-nvim
    friendly-snippets
    nvim-cmp
    nvim-dap
    nvim-dap-go
    nvim-dap-python
    nvim-lspconfig
    nvim-treesitter
    luasnip
  ];
  programs.neovim.extraLuaPackages = ps: [ ps.jsregexp ];
  xdg.configFile."nvim/after/plugin/conform.lua".source = ./conform.lua;
  xdg.configFile."nvim/after/plugin/dap.lua".source = ./dap.lua;
  xdg.configFile."nvim/after/plugin/lsp.lua".source = ./lsp.lua;
  xdg.configFile."nvim/after/plugin/treesitter.lua".source = ./treesitter.lua;
}
