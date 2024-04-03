{ pkgs, ... }: {
  xdg.configFile = {
    "tmux/plugins/catppuccin/tmux".source = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "cece0c36772483d1343bcace2b1cedb007057c2e";
      sha256 = "sha256-dB2bS/TG0ptXCCTfrm75xaDLaA29SYV5cv77YqSdLRk=";
    };
    "tmux/plugins/tmux-plugins/tmux-sensible".source = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-sensible";
      rev = "v3.0.0";
      sha256 = "sha256-ney/Y1YtCsWLgthOmoYGZTpPfJz+DravRB31YZgnDuU=";
    };
    "tmux/tmux.conf".source = ./tmux.conf;
  };

  home.packages = [ pkgs.tmux ];
}
