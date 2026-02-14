{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."zsh/default".source = ./config;
  xdg.configFile."zsh/custom.sh".text = config.dev.extraScript;

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.zsh = {
    enable = true;
    dotDir = config.home.homeDirectory;
    autosuggestion.enable = true;
    enableCompletion = true;
    initContent = ''
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
