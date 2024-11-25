{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my-desktop.enable {
    home.file = {
      ".local/share/rofi/themes".source = "${pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "rofi";
        rev = "b636a00fd40a7899a8206195464ae8b7f0450a6d";
        sha256 = "sha256-zA8Zum19pDTgn0KdQ0gD2kqCOXK4OCHBidFpGwrJOqg=";
      }}/basic/.local/share/rofi/themes";
    };

    xdg.configFile."rofi/config.rasi".text = ''
      configuration{
        modi: "run,drun,window";
        icon-theme: "${config.my-desktop.iconTheme.name}";
        show-icons: true;
        terminal: "alacritty";
        drun-display-format: "{icon} {name}";
        location: 0;
        disable-history: false;
        hide-scrollbar: true;
        display-drun: "   Apps ";
        display-run: "   Run ";
        display-window: "   Window ";
        sidebar-mode: true;
      }

      @theme "catppuccin-${config.my-desktop.catppuccinFlavour}"
    '';

    home.packages = [pkgs.rofi-wayland-unwrapped pkgs.rofi-power-menu];
  };
}
