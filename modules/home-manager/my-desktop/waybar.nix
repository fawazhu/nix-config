{
  config,
  pkgs,
  ...
}: {
  xdg.configFile = {
    "waybar/themes".source = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "waybar";
      rev = "v1.1";
      sha256 = "sha256-9lY+v1CTbpw2lREG/h65mLLw5KuT8OJdEPOb+NNC6Fo=";
    };
    "waybar/config".text = ''
      {
        "layer": "top",
        "position": "right",
        "width": "44",
        "margin-top": 10,
        "margin-right": 10,
        "margin-bottom": 10,

        "modules-left": ["hyprland/workspaces"],
        "modules-center": [],
        "modules-right": ["privacy", "custom/music", "bluetooth", "wireplumber", "network", "battery", "custom/notifications", "custom/power", "clock"],
        "hyprland/workspaces": {
          "disable-scroll": true,
          "format": " {icon} ",
          "format-icons": {
            "default": "",
            "empty": "",
            "active": ""
          },
          "max-length": 100
         },
        "custom/music": {
          "format": "󰎇",
          "escape": true,
          "interval": 5,
          "tooltip": false,
          "exec": "playerctl status | grep Playing 2>/dev/null",
          "on-click": "playerctl play-pause",
          "max-length": 60
        },
        "custom/notifications": {
          "tooltip": false,
          "format": "{icon}",
          "format-icons": {
            "notification": "󱅫",
            "none": "󰂚",
            "dnd-notification": "󰅸",
            "dnd-none": "󰂜",
            "inhibited-notification": "󱅫",
            "inhibited-none": "󰂚",
            "dnd-inhibited-notification": "󰅸",
            "dnd-inhibited-none": "󰂜"
          },
          "return-type": "json",
          "exec-if": "which swaync-client",
          "exec": "swaync-client -swb",
          "on-click": "swaync-client -t -sw",
          "escape": true
        },
        "clock": {
          "timezone": "Europe/London",
          "format-alt": "{:%y\n%m\n%d}",
          "format": "{:%H\n%M}",
          "tooltip": false
        },
        "battery": {
          "states": {
            "warning": 25,
            "critical": 10
          },
          "format": "{icon}",
          "format-charging": "{icon}",
          "format-full": "{icon}",
          "format-alt": "{icon}",
          "format-icons": ["󰁺", "󰁻",  "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
          "tooltip-format": "{capacity}%"
        },
        "network": {
          "format": "{icon}",
          "format-wifi": "󰖩",
          "format-disconnected": "󰖪",
          "tooltip": false
        },
        "bluetooth": {
          "format": "{icon}",
          "format-disabled": "󰂲",
          "format-on": "󰂯",
          "format-off": "󰂲",
          "format-connected": "󰂱",
          "on-click": "blueman-manager",
          "tooltip": false
        },
        "wireplumber": {
          "format": "{icon}",
          "format-muted": "󰝟",
          "format-icons": {
            "default": ["󰕿", "󰖀", "󰕾"]
          },
          "on-click": "pavucontrol",
          "tooltip-format": "{volume}"
        },
        "custom/power": {
          "tooltip": false,
          "on-click": "rofi -show menu -modi 'menu:rofi-power-menu'",
          "format": "󰐥"
        },
        "privacy": {
          "icon-spacing": 8,
          "icon-size": 12,
          "transition-duration": 250,
          "modules": [
            {
              "type": "screenshare",
              "tooltip": false,
              "tooltip-icon-size": 24
            },
            {
              "type": "audio-in",
              "tooltip": false,
              "tooltip-icon-size": 24
            }
          ]
        }
      }
    '';
    "waybar/style.css".text = ''
      @import "themes/themes/${config.my-desktop.catppuccinFlavour}.css";

      * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 17px;
        min-width: 0;
      }

      #waybar {
        background: transparent;
        color: @sky;
      }

      #workspaces {
        background-color: @surface0;
        border-radius: 1rem;
      }

      #workspaces button {
        color: @lavender;
        border-radius: 1rem;
        padding: 0.4rem;
      }

      #workspaces button.active {
        color: @sky;
        border-radius: 1rem;
      }

      #workspaces button:hover {
        color: @sapphire;
        border-radius: 1rem;
      }

      #privacy {
        background-color: @surface0;
        color: @red;
        padding: 1rem;
        border-radius: 1rem;
        margin-bottom: 10px;
      }

      #custom-music {
        background-color: @surface0;
        color: @green;
        padding: 1rem;
        border-radius: 1rem;
        margin-bottom: 10px;
      }

      #network,
      #bluetooth,
      #clock,
      #battery,
      #wireplumber,
      #custom-power,
      #custom-notifications {
        background-color: @surface0;
        padding: 0.5rem 1rem;
      }

      #clock {
        border-radius: 0px 0px 1rem 1rem;
        padding-bottom: 1rem;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }

      #bluetooth {
        border-radius: 1rem 1rem 0px 0px;
        padding-top: 1rem;
      }
    '';
  };

  home.packages = [pkgs.waybar];
}
