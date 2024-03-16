{ pkgs, ... }: {
  home.packages = with pkgs; [
    zip
    xz
    unzip
    p7zip
    ripgrep
    jq
    xq-xml
    yq-go
    eza
    fzf
    fd
    socat
    file
    which
    gnutar
    gawk
    zstd
    less
    gnupg
    lm_sensors
    pciutils
    usbutils
    bat
    udisks
  ];
}
