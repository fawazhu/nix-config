{ lib, ... }: with lib; {
  enable = mkOption {
    type = types.bool;
    default = false;
    description = mkDoc "Whether to enable my-shell.";
  };
  git = mkOption {
    type = types.submodule ({ ... }: {
      options = {
        userName = {
          type = types.str;
          default = null;
          description = mkDoc "Git user name to use.";
        };
        userEmail = {
          type = types.str;
          default = null;
          description = mkDoc "Git user email to use.";
        };
      };
    });
    default = { };
    description = mkDoc "Configure git integration.";
  };
  catppuccin-flavour = mkOption {
    type = types.str;
    default = "latte";
    description = mkDoc "Catppuccin flavour to use.";
  };
  editor = mkOption {
    type = types.str;
    default = "nvim";
    description = mkDoc "Editor executable to use.";
  };
  terminal = mkOption {
    type = types.str;
    default = "alacritty";
    description = mkDoc "Terminal to set as the TERM variable.";
  };
}
