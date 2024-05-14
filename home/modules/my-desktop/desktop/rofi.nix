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
        rev = "5350da41a11814f950c3354f090b90d4674a95ce";
        sha256 = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
      }}/basic/.local/share/rofi/themes";
      ".local/bin/rofi-power-menu".source = "${pkgs.fetchFromGitHub {
        owner = "jluttine";
        repo = "rofi-power-menu";
        rev = "3.1.0";
        sha256 = "sha256-VPCfmCTr6ADNT7MW4jiqLI/lvTjlAu1QrCAugiD0toU=";
      }}/rofi-power-menu";
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

    home.packages = [pkgs.rofi-wayland-unwrapped];
  };
}
