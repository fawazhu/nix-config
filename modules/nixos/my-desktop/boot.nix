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
  iconThemePackage = pkgs.tela-circle-icon-theme;
  cursorThemeName = "catppuccin-${flavour}-sky-cursors";
  cursorThemePackage =
    if flavour == "latte"
    then pkgs.catppuccin-cursors.latteSky
    else if flavour == "mocha"
    then pkgs.catppuccin-cursors.mochaSky
    else if flavour == "macchiato"
    then pkgs.catppuccin-cursors.macchiatoSky
    else if flavour == "frappe"
    then pkgs.catppuccin-cursors.frappeSky
    else pkgs.catppuccin-cursors.latteSky; # Fallback;
in {
  boot = {
    plymouth = {
      enable = true;
      theme = "bgrt";
    };
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "i915.fastboot=1"
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  services.xserver.displayManager.gdm.enable = true;
  programs.dconf.profiles."gdm" = {
    databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            "cursor-theme" = cursorThemeName;
            "icon-theme" = iconThemeName;
          };
          "org/gnome/desktop/peripherals/touchpad" = {
            "tap-to-click" = true;
          };
        };
      }
    ];
  };
  services.displayManager.sessionPackages = [pkgs.hyprland];
  environment.systemPackages = with pkgs; [ gnome-session gnome-shell cursorThemePackage iconThemePackage ];
}
