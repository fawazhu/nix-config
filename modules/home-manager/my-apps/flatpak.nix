{
  config,
  lib,
  flake-inputs,
  ...
}: {
  imports = [flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  config = lib.mkIf config.my-apps.enable {
    home.file.".local/share/flatpak/overrides/global".text = ''
      [Context]
      filesystems=/nix/store;~/.themes;~/.icons;xdg-data/fonts;xdg-config/gtk-4.0
      [Environment]
      GTK_THEME=${config.gtk.theme.name}
      ICON_THEME=${config.gtk.iconTheme.name}
      XCURSOR_THEME=${config.home.pointerCursor.name}
      XDG_DATA_HOME=$HOME/.local/share
    '';
    services.flatpak.packages = config.my-apps.flatpak.packages;
    services.flatpak.remotes = config.my-apps.flatpak.remotes;
    services.flatpak.update.onActivation = true;
  };
}
