{...}: {
  security.apparmor.enable = true;
  security.polkit.enable = true;
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
}
