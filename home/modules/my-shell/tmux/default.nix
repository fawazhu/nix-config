{
  config,
  lib,
  pkgs,
  ...
}: let
  catppuccin-tmux = pkgs.callPackage ./catppuccin-tmux.nix {};
  tmux-plugins-sensible = pkgs.callPackage ./tmux-plugins-sensible.nix {};
in {
  config = lib.mkIf config.my-shell.enable {
    xdg.configFile = {
      "tmux/extra.conf".source = ./tmux.conf;
      "tmux/tmux.conf".text = ''
        source-file ~/.config/tmux/extra.conf
        set -g @catppuccin_flavour ${config.my-shell.catppuccin-flavour}
        set -as default-terminal '${config.my-shell.terminal}'
        set -as terminal-features ',${config.my-shell.terminal}:RGB'
        set-option -g default-shell ${config.programs.nushell.package}/bin/nu
        run '${catppuccin-tmux}/share/tmux-plugins/catppuccin/catppuccin.tmux'
        run '${tmux-plugins-sensible}/share/tmux-plugins/tmux-sensible/sensible.tmux'
      '';
    };

    home.packages = [
      pkgs.tmux
      catppuccin-tmux
      tmux-plugins-sensible
    ];
  };
}
