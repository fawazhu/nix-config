{ lib, ... }: with lib; with types; let
  enable-options = { name }: mkOption {
    type = bool;
    default = false;
    description = mkDoc "Whether to enable ${name}.";
  };
  nested-enable-options = { name }: mkOption {
    type = submodule { options = { enable = enable-options { inherit name; }; }; };
    default = {};
    description = mkDoc "${name} integration.";
  };
in {
  enable = enable-options { name = "my-dev"; };
  languages = mkOption {
    type = submodule {
      options = {
        ansible = nested-enable-options { name = "ansible"; };
        bash = nested-enable-options { name = "bash"; };
        css = nested-enable-options { name = "css"; };
        docker = nested-enable-options { name = "docker"; };
        go = nested-enable-options { name = "go"; };
        graphql = nested-enable-options { name = "graphql"; };
        html = nested-enable-options { name = "html"; };
        javascript = nested-enable-options { name = "javascript"; };
        json = nested-enable-options { name = "json"; };
        lua = nested-enable-options { name = "lua"; };
        markdown = nested-enable-options { name = "markdown"; };
        nix = nested-enable-options { name = "nix"; };
        packer = nested-enable-options { name = "packer"; };
        python = nested-enable-options { name = "python"; };
        rust = nested-enable-options { name = "rust"; };
        terraform = nested-enable-options { name = "terraform"; };
        toml = nested-enable-options { name = "toml"; };
        xml = nested-enable-options { name = "xml"; };
        yaml = nested-enable-options { name = "yaml"; };
      };
    };
    default = { };
    description = mkDoc "Configure languages.";
  };
  catppuccin-flavour = mkOption {
    type = str;
    default = "latte";
    description = mkDoc "Catppuccin flavour to use.";
  };
  terminal = mkOption {
    type = str;
    default = "alacritty";
    description = mkDoc "Terminal to set as the TERM variable.";
  };
  tools = mkOption {
    type = submodule {
      options = {
        awscli = nested-enable-options { name = "awscli"; };
        lazygit = nested-enable-options { name = "lazygit"; };
        codeium = mkOption {
          type = submodule {
            options = {
              enable = mkOption {
                type = bool;
                default = false;
                description = mkDoc "Whether to enable codeium integration.";
              };
            };
          };
          default = {};
          description = mkDoc "codeium integration.";
        };
      };
    };
    default = { };
    description = mkDoc "Configure tools.";
  };
}
