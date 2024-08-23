{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my-desktop.enable {
    xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = ~/Pictures/Wallpapers/1.png
      wallpaper = ,~/Pictures/Wallpapers/1.png

      ipc = off
      splash = true
    '';

    home.packages = [pkgs.hyprpaper];

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        # Environment configuration
        env = [
          # Scale
          "GDK_SCALE,${config.my-desktop.scaleFactor}"
          "XDG_SESSION_TYPE,wayland"
          "XCURSOR_SIZE,${toString (
            if config.my-desktop.scaleFactor == 1
            then config.my-desktop.cursorSize
            else config.my-desktop.cursorSize + 1
          )}" # Fix odd cursor size bug.
        ];
        # exec
        exec-once = [
          # Startup integrations
          "swaync" # Notifications
          "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1" # Privilege escalation.
          "wl-paste --watch cliphist store" # Clipboard history
          "waybar" # Top bar.
          "hyprpaper" # Desktop wallpaper.
          "kdeconnectd" # KDE connect.
          # Startup apps
          "alacritty"
        ];
        # Display and scaling settings
        monitor = ",highres,auto,${config.my-desktop.scaleFactor}";
        xwayland = {
          force_zero_scaling = true;
        };

        # Input devices
        input = {
          kb_layout = "gb";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad = {
            natural_scroll = true;
          };
        };
        gestures = {
          workspace_swipe = true;
        };

        # Theming
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(89b4faff) rgba(a6e3a1ff) 45deg";
          "col.inactive_border" = "rgba(11111baa)";

          layout = "dwindle"; # Default
        };
        decoration = {
          rounding = 10;
        };
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
        misc = {
          disable_hyprland_logo = true;
        };

        # Layouts
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        master = {
          new_status = "master";
        };

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
        bind = [
          "$mainMod, T, exec, alacritty"
          "$mainMod, R, exec, rofi -show drun"
          "$mainMod, W, exec, rofi -show window"
          "$mainMod, Q, exec, rofi -show run"
          "$mainMod, X, killactive,"
          "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
          "$mainMod, P, exec, swaylock &"
          "$mainMod, O, exec, grim"
          "$mainMod, N, exec, swaync-client -t -sw"
          "$mainMod SHIFT, N, exec, swaync-client -d"

          # Window mode
          "$mainMod, F, togglefloating,"
          "$mainMod, G, fullscreen, 0"
          "$mainMod, T, fullscreen, 1"

          # Move focus
          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"
          "$mainMod, Left, movefocus, l"
          "$mainMod, Right, movefocus, r"
          "$mainMod, Up, movefocus, u"
          "$mainMod, Down, movefocus, d"

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
          "$mainMod ALT, H, moveintogroup, l"
          "$mainMod ALT, L, moveintogroup, r"
          "$mainMod ALT, K, moveintogroup, u"
          "$mainMod ALT, J, moveintogroup, d"

          # Move workspaces
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
        ];

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
    };
  };
}
