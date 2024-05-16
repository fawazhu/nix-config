{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./rofi.nix
    ./swaylock.nix
    ./swaync.nix
    ./themes.nix
    ./waybar.nix
  ];

  config = lib.mkIf config.my-desktop.enable {
    home.sessionVariables."GRIM_DEFAULT_DIR" = "${config.home.homeDirectory}/Pictures/Screenshots";
    home.packages = with pkgs; [
      cliphist
      brightnessctl
      playerctl
      pavucontrol
      libsForQt5.polkit-kde-agent
      wl-clipboard
      grim
    ];

    services.blueman-applet.enable = true;
  };
}
