{
  config,
  pkgs,
  flake-inputs,
  ...
}: {
  imports = [
    flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ../../modules/home-manager/my-desktop
    ../../modules/home-manager/my-dev
    ../../modules/home-manager/theming
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
  my-dev.ai = true;
  my-dev.catppuccinFlavour = "macchiato";
  my-dev.catppuccinAccent = "peach";

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];
  services.flatpak.update.auto.enable = true;
  services.flatpak.update.auto.onCalendar = "weekly";
  home.packages = with pkgs; [seahorse nautilus file-roller gparted ncdu];

  my-desktop.mimeDefaults = {
      archive = "org.gnome.FileRoller.desktop";
      browser = "one.ablaze.floorp.desktop";
      calendar = "com.calibre_ebook.calibre.desktop";
      document = "org.libreoffice.LibreOffice.desktop";
      ebook = "com.calibre_ebook.calibre.desktop";
      editor = "nvim.desktop";
      font = "org.gnome.font-viewer.desktop";
      image = "org.gnome.Loupe.desktop";
      music = "io.bassi.Amberol.desktop";
      pdf = "org.gnome.Evince.desktop";
      video = "org.gnome.Totem.desktop";
  };

  theming = {
    flavour = "macchiato";
    accent = "peach";
    scaling = 2;
  };


  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
