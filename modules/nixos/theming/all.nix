{
  config,
  lib,
  pkgs,
  ...
}: let
  flavour = config.theming.flavour;
  accent = config.theming.accent;

  captializedAccent = (lib.toUpper (builtins.substring 0 1 accent)) + (builtins.substring 1 (-1) accent);
  hex = builtins.substring 1 (-1) ((builtins.getAttr accent (builtins.getAttr flavour palette).colors).hex);
  palette = builtins.fromJSON (builtins.readFile ./palette.json);

  isLight = ! (builtins.getAttr flavour palette).dark;

  iconThemeSuffix =
    if isLight
    then "light"
    else "dark";
  iconThemeName = "Tela-circle-${hex}-${iconThemeSuffix}";
  iconThemePackage = pkgs.callPackage ./tela-circle-icon-theme.nix {hex = hex;};

  cursorThemeName = "catppuccin-${flavour}-${accent}-cursors";
  cursorThemePackage = builtins.getAttr "${flavour}${captializedAccent}" pkgs.catppuccin-cursors;
in {
  programs.dconf.profiles."gdm".databases = [
    {
      settings = {
        "org/gnome/desktop/interface" = {
          cursor-theme = cursorThemeName;
          icon-theme = iconThemeName;
          scaling-factor = config.theming.scaling;
        };
        "org/gnome/mutter" = {
          experimental-features = "['scale-monitor-framebuffer']";
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true; # Not theming but nice place to put it.
        };
      };
    }
  ];

  boot.plymouth.theme = "bgrt";
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = ["splash"];

  environment.systemPackages = [cursorThemePackage iconThemePackage];
}
