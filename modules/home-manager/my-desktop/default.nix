{config, lib, pkgs, ...}: {
  options.my-desktop = import ./options.nix {inherit lib pkgs;};

  config = lib.mkIf config.my-desktop.enable {
    xdg = {
      enable = true;
      userDirs.enable = true;
      userDirs.createDirectories = true;
    };

    home.sessionVariables."GRIM_DEFAULT_DIR" = "${config.home.homeDirectory}/Pictures/Screenshots";
    home.packages = with pkgs; [
      cliphist
      brightnessctl
      playerctl
      pavucontrol
      libsForQt5.polkit-kde-agent
      wl-clipboard
      grim
      slurp
    ];

    services.blueman-applet.enable = true;
  };

  imports = [
    ./hyprland.nix
    ./rofi.nix
    ./swaylock.nix
    ./swaync.nix
    ./themes.nix
    ./waybar.nix
  ];
}
