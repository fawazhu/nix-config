{
  config,
  lib,
  pkgs,
  ...
}: let
  flavour = config.my-dev.catppuccinFlavour;
  captializedFlavour = (lib.toUpper (builtins.substring 0 1 flavour)) + (builtins.substring 1 (-1) flavour);
in {
  xdg.configFile."zsh/default".source = ./config;
  xdg.configFile."zsh/custom.sh".text = config.my-dev.extraScript;

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
      export EDITOR=nvim
      export TERM=alacritty
      export BAT_THEME="Catppuccin ${captializedFlavour}"

      for rc in ~/.config/zsh/default/*; do
        . $rc
      done
      . ~/.config/zsh/custom.sh
      . ${pkgs.awscli2}/bin/aws_zsh_completer.sh
    '';
  };

  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
}
