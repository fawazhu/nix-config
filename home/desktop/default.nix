{ pkgs, ... }: {
  imports = [
    ./grim.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./themes.nix
    ./rofi
    ./swaylock
    ./swaync
    ./waybar
  ];

  home.packages = with pkgs; [
    cliphist
    brightnessctl
    playerctl
    pavucontrol
    libsForQt5.polkit-kde-agent
    wl-clipboard
  ];

  services.blueman-applet.enable = true;
}
