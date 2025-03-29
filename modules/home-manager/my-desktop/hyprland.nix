{
  config,
  pkgs,
  ...
}: let
  wallpaper =
    if config.my-desktop.catppuccinFlavour == "latte"
    then "1.png"
    else "2.png";
  screenshot = "${config.home.homeDirectory}/Pictures/Screenshots";
in {
  home.packages = with pkgs; [
    brightnessctl
    cliphist
    grim
    kdePackages.polkit-kde-agent-1
    pavucontrol
    playerctl
    slurp
    wl-clipboard
  ];

  services.blueman-applet.enable = true;
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = ["~/Pictures/Wallpapers/${wallpaper}"];
    wallpaper = [",~/Pictures/Wallpapers/${wallpaper}"];
    ipc = "off";
    splash = false;
  };

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    # Environment configuration
    env = [
      # Scale
      "GDK_SCALE,${config.my-desktop.scaleFactor}"
      "XDG_SESSION_TYPE,wayland"
      "GSK_RENDERER,ngl"
      "GRIM_DEFAULT_DIR,${screenshot}"
    ];
    # exec
    exec-once = [
      # Startup integrations
      "swaync" # Notifications
      "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1" # Privilege escalation.
      "wl-paste --watch cliphist store" # Clipboard history
      "waybar" # Top bar.
      "hyprpaper" # Desktop wallpaper.
      # Startup apps
      "alacritty"
    ];
    # Display and scaling settings
    monitor = ",highres,auto,${config.my-desktop.scaleFactor}";
    xwayland.force_zero_scaling = true;

    # Input devices
    input = {
      kb_layout = "gb";
      follow_mouse = 1;
      sensitivity = 0;
      touchpad.natural_scroll = true;
    };
    gestures.workspace_swipe = true;

    # Theming
    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      "col.active_border" = "rgba(89b4faff) rgba(a6e3a1ff) 45deg";
      "col.inactive_border" = "rgba(11111baa)";

      layout = "dwindle"; # Default
    };
    decoration.rounding = 10;
    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };
    misc.disable_hyprland_logo = true;

    # Layouts
    dwindle.pseudotile = true;
    dwindle.preserve_split = true;
    master.new_status = "master";

    windowrulev2 = [
      # Floating rules
      "float, title:(.*PolicyKit1 KDE.*)$"
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
      "float, title:^(Volume Control)$"
      "float, title:^(Bluetooth Devices)$"
      "float, title:^(Network Connections)$"
      "float, title:^(Editing .*)$"
      # Annoyances
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\\.)$"
    ];

    "$mainMod" = "SUPER";
    bind =
      [
        # Launch apps
        "$mainMod, T, exec, alacritty"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, W, exec, rofi -show window"
        "$mainMod, Q, exec, rofi -show run"

        # Clipboard
        "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        # Lock
        "$mainMod, P, exec, swaylock &"

        # Notifications
        "$mainMod, N, exec, swaync-client -t -sw"
        "$mainMod SHIFT, N, exec, swaync-client -d"

        # Screenshot
        ", Print, exec, GRIM_DEFAULT_DIR=${screenshot} grim"
        ''SHIFT, Print, exec, GRIM_DEFAULT_DIR=${screenshot} grim -g "$( hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' )"''
        "CTRL, Print, exec, GRIM_DEFAULT_DIR=${screenshot} grim -g \"$(slurp)\""

        # Window manipulation
        "$mainMod, F, togglefloating,"
        "$mainMod, G, fullscreen, 0"
        "$mainMod, X, killactive,"

        # Move focus
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Resize windows
        "$mainMod CTRL, H, resizeactive, -20 0"
        "$mainMod CTRL, L, resizeactive, 20 0"
        "$mainMod CTRL, K, resizeactive, 0 -20"
        "$mainMod CTRL, J, resizeactive, 0 20"

        # Swap windows
        "$mainMod SHIFT, H, swapwindow, l"
        "$mainMod SHIFT, L, swapwindow, r"
        "$mainMod SHIFT, K, swapwindow, u"
        "$mainMod SHIFT, J, swapwindow, d"

        # Move windows
        "$mainMod ALT, H, movewindow, l"
        "$mainMod ALT, L, movewindow, r"
        "$mainMod ALT, K, movewindow, u"
        "$mainMod ALT, J, movewindow, d"
      ]
      # Move workspaces
      ++ builtins.map (w: "$mainMod, ${w}, workspace, ${w}") (builtins.genList (i: builtins.toString (i + 1)) 9)
      # Move active window to a workspace
      ++ builtins.map (w: "$mainMod SHIFT, ${w}, movetoworkspace, ${w}") (builtins.genList (i: builtins.toString (i + 1)) 9);

    bindl = [
      ", xf86monbrightnessup, exec, brightnessctl s -- +5"
      ", xf86monbrightnessdown, exec, brightnessctl s -- -5"
      ", xf86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", xf86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", xf86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
      "$mainMod SHIFT, mouse:272, resizewindow"
    ];
  };
}
