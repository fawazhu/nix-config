{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.my-shell.enable {
    xdg.configFile.zsh.source = ./config;

    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      initExtra = ''
        export EDITOR=${config.my-shell.editor}
        export TERM=${config.my-shell.terminal}
        export BAT_THEME="Catppuccin-${config.my-shell.catppuccin-flavour}"

        for rc in ~/.config/zsh/*; do
          . $rc
        done
      '';
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
