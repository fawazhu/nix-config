{
  config,
  pkgs,
  ...
}: let
  catppuccin-tmux = with pkgs;
    stdenv.mkDerivation (finalAttrs: {
      pname = "catppuccin-tmux";
      version = "v2.1.3";

      src = fetchFromGitHub {
        owner = "catppuccin";
        repo = "tmux";
        rev = "v2.1.3";
        sha256 = "sha256-Is0CQ1ZJMXIwpDjrI5MDNHJtq+R3jlNcd9NXQESUe2w=";
      };

      installPhase = ''
        mkdir -p $out/share/tmux-plugins
        cp -r . $out/share/tmux-plugins/catppuccin
      '';
    });
  tmux-plugins-sensible = with pkgs;
    stdenv.mkDerivation (finalAttrs: {
      pname = "tmux-plugins-sensible";
      version = "v3.0.0";

      src = fetchFromGitHub {
        owner = "tmux-plugins";
        repo = "tmux-sensible";
        rev = finalAttrs.version;
        sha256 = "sha256-ney/Y1YtCsWLgthOmoYGZTpPfJz+DravRB31YZgnDuU=";
      };

      installPhase = ''
        mkdir -p $out/share/tmux-plugins
        cp -r . $out/share/tmux-plugins/tmux-sensible
      '';
    });
in {
  xdg.configFile."tmux/extra.conf".source = ./tmux.conf;
  xdg.configFile."tmux/tmux.conf".text = ''
    set -g @catppuccin_flavor ${config.my-dev.catppuccinFlavour}
    set -g @catppuccin_window_current_number_color "#{@thm_${config.my-dev.catppuccinAccent}}"
    source-file ~/.config/tmux/extra.conf
    set-option -g default-shell ${pkgs.zsh}/bin/zsh
    run '${catppuccin-tmux}/share/tmux-plugins/catppuccin/catppuccin.tmux'
    run '${tmux-plugins-sensible}/share/tmux-plugins/tmux-sensible/sensible.tmux'
  '';
  home.packages = [pkgs.tmux];
}
