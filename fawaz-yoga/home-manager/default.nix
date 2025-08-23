{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/theming.nix
    ../../modules/home-manager/graphical
    ../../modules/home-manager/dev
  ];

  home.username = "fawaz";
  home.homeDirectory = "/home/fawaz";

  sops.defaultSopsFile = ../secrets.yaml;
  sops.age.keyFile = "/etc/sops/age/keys.txt";

  sops.secrets.ssh_private_key = {
    mode = "0400";
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
  };
  sops.secrets.ssh_public_key = {
    mode = "0400";
    path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
  };

  programs.git = {
    userName = "Fawaz Hussain";
    userEmail = "fawazsana@gmail.com";
  };
  dev.ai = true;
  dev.extraScript = ''
    startgame() {
      case $1 in
        fe7)
          echo "Starting Fire Emblem: The Blazing Blade"
          gamescope -W 2880 -H 1800 -w 2880 -h 1800 -b --expose-wayland --hdr-enabled -- mgba-qt /home/fawaz/Games/GBA/fe7.gba
          ;;
        fe8)
          echo "Starting Fire Emblem: The Sacred Stones"
          gamescope -W 2880 -H 1800 -w 2880 -h 1800 -b --expose-wayland --hdr-enabled -- mgba-qt /home/fawaz/Games/GBA/fe8.gba
          ;;
        *)
          echo "Game $1 is not configured" >&2
          ;;
      esac
    }
  '';

  theming = {
    flavour = "macchiato";
    accent = "sapphire";
    scaling = 2;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    gamemode
    gparted
    mangohud
    mgba
    umu-launcher
    winetricks
    wineWowPackages.full
  ];
  services.flatpak.packages = [
    "ca.desrt.dconf-editor//stable"
    "com.github.tchx84.Flatseal"
  ];
  programs.lutris = {
    enable = true;
    steamPackage = pkgs.steam;
    extraPackages = with pkgs; [
      gamemode
      gamescope
      mangohud
      umu-launcher
      winetricks
    ];
    protonPackages = with pkgs; [proton-ge-bin];
  };
}
