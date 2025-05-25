{
  config,
  pkgs,
  ...
}: {
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      document-font-name = "Noto Serif 11";
      font-name = "Noto Sans 10";
      monospace-font-name = "JetBrainsMono Nerd Font 10";
    };
    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = ["one.ablaze.floorp.desktop" "Alacritty.desktop" "org.gnome.Nautilus.desktop" "org.inkscape.Inkscape.desktop" "org.kde.krita.desktop"];
    };
  };
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      {
        id = clipboard-indicator.extensionUuid;
        package = clipboard-indicator;
      }
    ];
  };
}
