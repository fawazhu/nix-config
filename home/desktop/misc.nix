{ pkgs, ... }: {
  # These are packages that do not need to be configured.
  home.packages = with pkgs; [
    grim
    cliphist
    brightnessctl
    playerctl
    pavucontrol
    swaynotificationcenter
    libsForQt5.polkit-kde-agent
  ];
}
