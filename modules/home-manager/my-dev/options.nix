{lib, ...}:
with lib;
with types; let
  enableOptions = {name}:
    mkOption {
      type = bool;
      default = false;
      description = mkDoc "Whether to enable ${name}.";
    };
  nestedEnableOptions = {name}:
    mkOption {
      type = submodule {options = {enable = enableOptions {inherit name;};};};
      default = {};
      description = mkDoc "${name} integration.";
    };
in {
  enable = enableOptions {name = "my-dev";};
  languages = mkOption {
    type = submodule {
      options = {
        ansible = nestedEnableOptions {name = "ansible";};
        bash = nestedEnableOptions {name = "bash";};
        css = nestedEnableOptions {name = "css";};
        docker = nestedEnableOptions {name = "docker";};
        go = nestedEnableOptions {name = "go";};
        graphql = nestedEnableOptions {name = "graphql";};
        html = nestedEnableOptions {name = "html";};
        javascript = nestedEnableOptions {name = "javascript";};
        json = nestedEnableOptions {name = "json";};
        lua = nestedEnableOptions {name = "lua";};
        markdown = nestedEnableOptions {name = "markdown";};
        nix = nestedEnableOptions {name = "nix";};
        packer = nestedEnableOptions {name = "packer";};
        python = nestedEnableOptions {name = "python";};
        rust = nestedEnableOptions {name = "rust";};
        terraform = nestedEnableOptions {name = "terraform";};
        toml = nestedEnableOptions {name = "toml";};
        xml = nestedEnableOptions {name = "xml";};
        yaml = nestedEnableOptions {name = "yaml";};
      };
    };
    default = {};
    description = mkDoc "Configure languages.";
  };
  catppuccinFlavour = mkOption {
    type = str;
    default = "mocha";
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
        awscli = nestedEnableOptions {name = "awscli";};
        lazygit = nestedEnableOptions {name = "lazygit";};
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
        tabnine = mkOption {
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
    default = {};
    description = mkDoc "Configure tools.";
  };
}
