{
  config,
  pkgs,
  ...
}: let
  flavour = config.my-desktop.catppuccinFlavour;
  iconThemeName =
    if flavour == "latte"
    then "Tela-circle"
    else "Tela-circle-dark";
  gtkThemeName = "catppuccin-${flavour}-sky-standard";
  cursorThemeName = "catppuccin-${flavour}-sky-cursors";
  hyprland-session = pkgs.callPackage ./hyprland-session.nix {};
in {
  environment.systemPackages = [ hyprland-session ];
  environment.pathsToLink = [ "/share/wayland-sessions" ];

  services.greetd.enable = true;
  services.greetd.settings = {
    default_session.command = "/bin/sh -c 'LIBINPUT_DEFAULT_TAP=true ${pkgs.cage}/bin/cage -s -d -- ${pkgs.greetd.regreet}/bin/regreet'";
  };

  programs.regreet = {
    enable = true;
    cursorTheme.name = cursorThemeName;
    cursorTheme.package =
      if flavour == "latte"
      then pkgs.catppuccin-cursors.latteSky
      else if flavour == "mocha"
      then pkgs.catppuccin-cursors.mochaSky
      else if flavour == "macchiato"
      then pkgs.catppuccin-cursors.macchiatoSky
      else if flavour == "frappe"
      then pkgs.catppuccin-cursors.frappeSky
      else pkgs.catppuccin-cursors.latteSky; # Fallback;
    font.package = pkgs.noto-fonts;
    font.name = "Noto Sans";
    iconTheme.name = iconThemeName;
    iconTheme.package = pkgs.tela-circle-icon-theme;
    theme.package = pkgs.catppuccin-gtk.override {
      accents = ["sky"];
      variant = flavour;
    };
    theme.name = gtkThemeName;
    settings.env."GDK_SCALE" = "1.25";
    settings.env."SESSION_DIRS" = "/run/current-system/sw/share/wayland-sessions";
  };
  environment.etc."greetd/environments".text = ''
    Hyprland
    zsh
  '';
}
