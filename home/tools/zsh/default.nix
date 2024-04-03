{ ... }: {
  xdg.configFile.zsh.source = ./config;
  
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
    for rc in ~/.config/zsh/*; do
      . $rc
    done
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
