{pkgs, ...}: {
  environment.shells = [pkgs.bashInteractive pkgs.zsh];
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    bash
    age
    zip
    xz
    unzip
    p7zip
    file
    which
    gnutar
    gawk
    zstd
    less
    lm_sensors
    pciutils
    usbutils
    udisks
    systemd
  ];

  services.flatpak.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.printing.enable = true;
}
