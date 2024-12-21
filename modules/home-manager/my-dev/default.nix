{
  lib,
  pkgs,
  ...
}: let
  granted = pkgs.granted.overrideAttrs (finalAttrs: previousAttrs: {CGO_ENABLED = 0;});
in {
  options.my-dev = import ./options.nix {inherit lib;};

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
      vault
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
      openssl_3_3
      socat
      tcpdump
      # Multimedia tools
      ffmpeg_7-full
      graphviz
      imagemagick
    ];
    services.podman.enable = true;
  };

  imports = [
    ./alacritty.nix
    ./bat.nix
    ./btop.nix
    ./git.nix
    ./nushell.nix
    ./neovim
    ./tmux
    ./zsh
  ];
}
