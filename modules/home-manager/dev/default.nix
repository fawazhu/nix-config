{
  lib,
  pkgs,
  ...
}: let
  granted = pkgs.callPackage ./granted.nix {};
in {
  options.dev = import ./options.nix {inherit lib;};

  config = {
    home.packages = with pkgs; [
      # Cloud tools
      awscli2
      aws-vault
      granted
      # Git tools
      lazygit
      pre-commit
      # Vault
      vault-bin
      # Data manipulation
      jq
      xq-xml
      yq-go
      # Search / file management
      eza
      fd
      fzf
      ripgrep
      rsync
      # Networking
      dig
      openssl
      socat
      tcpdump
      # Multimedia tools
      ffmpeg_7-full
      graphviz
      imagemagick
      # Container tools
      podman-compose
    ];
    services.podman.enable = true;
  };

  imports = [
    ./ai.nix
    ./alacritty.nix
    ./bat.nix
    ./btop.nix
    ./eza.nix
    ./git.nix
    ./neovim
    ./tmux
    ./zsh
  ];
}
