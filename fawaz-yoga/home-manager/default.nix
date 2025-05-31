{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/theming.nix
    ../../modules/home-manager/graphical
    ../../modules/home-manager/dev
    ./flatpak-packages.nix
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

  theming = {
    flavour = "latte";
    accent = "peach";
    scaling = 2;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  home.packages = with pkgs; [gparted ncdu wineWowPackages.waylandFull gamemode umu-launcher mangohud];
  services.flatpak.packages = [
    "ca.desrt.dconf-editor//stable"
    "com.github.tchx84.Flatseal"
    "com.usebottles.bottles//stable"
  ];
  programs.lutris = {
    enable = true;
    steamPackage = pkgs.steam;
    extraPackages = with pkgs; [mangohud winetricks gamescope gamemode umu-launcher];
    protonPackages = with pkgs; [proton-ge-bin];
  };
}
