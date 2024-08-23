{lib, ...}:
with lib;
with types; {
  enable = mkOption {
    type = bool;
    default = false;
    description = mkDoc "Whether to enable my-shell.";
  };
  git = mkOption {
    type = submodule ({...}: {
      options = {
        userName = mkOption {
          type = str;
          default = null;
          description = mkDoc "Git user name to use.";
        };
        userEmail = mkOption {
          type = str;
          default = null;
          description = mkDoc "Git user email to use.";
        };
      };
    });
    default = { };
    description = mkDoc "Configure git integration.";
  };
  catppuccinFlavour = mkOption {
    type = str;
    default = "mocha";
    description = mkDoc "Catppuccin flavour to use.";
  };
  editor = mkOption {
    type = str;
    default = "nvim";
    description = mkDoc "Editor executable to use.";
  };
  terminal = mkOption {
    type = str;
    default = "alacritty";
    description = mkDoc "Terminal to set as the TERM variable.";
  };
  extraScript = mkOption {
    type = str;
    default = "";
    description = mkDoc "Extra script to run when starting a shell.";
  };
}
