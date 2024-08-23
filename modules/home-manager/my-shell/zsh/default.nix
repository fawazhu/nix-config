{
  config,
  lib,
  ...
}: let
  flavour = config.my-shell.catppuccinFlavour;
in {
  config = lib.mkIf config.my-shell.enable {
    xdg.configFile."zsh/default".source = ./config;
    xdg.configFile."zsh/custom.sh".text = config.my-shell.extraScript;

    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      initExtra = ''
        export EDITOR=${config.my-shell.editor}
        export TERM=${config.my-shell.terminal}
        export BAT_THEME="Catppuccin ${(lib.toUpper (builtins.substring 0 1 flavour)) + (builtins.substring 1 (-1) flavour)}"

        for rc in ~/.config/zsh/default/*; do
          . $rc
        done
        . ~/.config/zsh/custom.sh
      '';
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
