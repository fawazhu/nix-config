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
        awscli = mkOption {
          type = submodule {
            options = {
              enable = enableOptions {name = "awscli";};
              config = mkOption {
                type = str;
                default = "";
                description = mkDoc "AWS CLI configuration file";
              };
            };
          };
          default = {};
          description = mkDoc "Configure the AWS CLI.";
        };
        hcpvault = nestedEnableOptions {name = "hcpvault";};
        lazygit = nestedEnableOptions {name = "lazygit";};
        codeium = nestedEnableOptions {name = "codeium";};
        tabnine = nestedEnableOptions {name = "codeium";};
        virtualenv = nestedEnableOptions {name = "virtualenv";};
      };
    };
    default = {};
    description = mkDoc "Configure tools.";
  };
}
