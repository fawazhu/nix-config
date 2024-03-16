{ ... }: {
  services.blueman-applet.enable = true;
# TODO: Get gnome keyring working.
  services.gnome-keyring.enable = true;
}
