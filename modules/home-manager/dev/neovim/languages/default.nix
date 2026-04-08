{
  hostname,
  pkgs,
  ...
}: let
  conform-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "conform.nvim";
    version = "2025-08-22";
    src = pkgs.fetchFromGitHub {
      owner = "stevearc";
      repo = "conform.nvim";
      rev = "3543d000dafbc41cc7761d860cfdb24e82154f75";
      sha256 = "pUF9F5QoDzCZuVRcJEF91M8Qjkh/xosMkf9tRavkmJs=";
      fetchSubmodules = false;
    };
    meta.homepage = "https://github.com/stevearc/conform.nvim/";
    meta.hydraPlatforms = [];
  };
in {
  home.packages = with pkgs; [
    # ansible
    ansible
    ansible-lint
    # bash
    bash
    bash-language-server
    beautysh
    # css
    vscode-langservers-extracted
    prettier
    # docker
    dockerfile-language-server
    # go
    go
    gopls
    delve
    gofumpt
    # html
    vscode-langservers-extracted
    # js
    nodejs_24
    nodemon
    typescript
    electron
    eslint
    typescript-language-server
    # json
    vscode-langservers-extracted
    jq
    fixjson
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

  programs.neovim.plugins = with pkgs;
  with vimPlugins; [
    cmp_luasnip
    cmp-nvim-lsp
    cmp-path
    conform-nvim
    friendly-snippets
    luasnip
    nvim-cmp
    nvim-dap
    nvim-dap-go
    nvim-dap-python
    nvim-lspconfig
    (nvim-treesitter.withPlugins (p: with p; [
      awk
      bash
      cmake
      commonlisp
      css
      csv
      dart
      desktop
      diff
      dockerfile
      dot
      editorconfig
      dockerfile
      fish
      gitattributes
      gitcommit
      gitignore
      git-config
      git-rebase
      go
      gomod
      gosum
      gotmpl
      gowork
      gpg
      graphql
      groovy
      hcl
      helm
      html
      http
      hyprlang
      ini
      java
      javadoc
      javascript
      jinja
      jinja-inline
      jq
      jsdoc
      json
      json5
      kconfig
      kotlin
      llvm
      lua
      lua
      luadoc
      make
      markdown
      markdown_inline
      mermaid
      meson
      nginx
      ninja
      nix
      nu
      passwd
      pem
      powershell
      printf
      promql
      properties
      proto
      puppet
      pymanifest
      python
      query
      rasi
      readline
      regex
      rego
      requirements
      ruby
      rust
      scala
      scss
      sparql
      sql
      ssh-config
      strace
      svelte
      sway
      swift
      systemtap
      templ
      terraform
      tmux
      todotxt
      toml
      tree-sitter-tsv
      tree-sitter-tsx
      tree-sitter-typescript
      tree-sitter-udev
      tree-sitter-vim
      tree-sitter-vimdoc
      tree-sitter-vue
      tree-sitter-yaml
      tree-sitter-zig
    ]))
    markdown-preview-nvim
    SchemaStore-nvim
  ];
  programs.neovim.extraLuaPackages = ps: [ps.jsregexp];
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
    vim.lsp.enable("nixd")
  '';
}
