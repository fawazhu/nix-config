{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my-system.enable {
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
    ];
  };
}
