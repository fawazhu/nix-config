{pkgs, ...}: {
  imports = [./fonts.nix];

  boot.plymouth.enable = true;
  boot.kernelParams = ["loglevel=3" "rd.udev.log_level=3"];

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    ark
    elisa
    gwenview
    okular
    kate
    khelpcenter
    dolphin
    baloo-widgets
    dolphin-plugins
    ffmpegthumbs
    krdp
    discover
  ];

  security.pam.services.kwallet.enableKwallet = true;
  services.xserver.xkb.layout = "gb";
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    libsecret
    kdePackages.sddm-kcm
  ];
}
