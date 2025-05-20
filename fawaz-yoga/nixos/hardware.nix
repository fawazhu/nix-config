{...}: {
  boot.initrd.availableKernelModules = ["nvme" "usb_storage"];
  boot.initrd.systemd.enable = true;
  boot.kernelModules = ["kvm-amd"];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];

  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  services.udisks2.enable = true;

  boot.initrd.luks.devices."crypt-root" = {
    device = "/dev/disk/by-uuid/e2684e65-9447-4a73-b7d8-97e38686d1ea";
    bypassWorkqueues = true;
    allowDiscards = true;
  };
  fileSystems."/" = {
    device = "/dev/mapper/crypt-root";
    fsType = "btrfs";
    options = ["subvol=root"];
  };
  fileSystems."/home" = {
    device = "/dev/mapper/crypt-root";
    fsType = "btrfs";
    options = ["subvol=home"];
  };
  fileSystems."/nix" = {
    device = "/dev/mapper/crypt-root";
    fsType = "btrfs";
    options = ["subvol=nix"];
  };
  fileSystems."/var" = {
    device = "/dev/mapper/crypt-root";
    fsType = "btrfs";
    options = ["subvol=var"];
  };
  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/3E07-6CC6";
    fsType = "vfat";
  };
}
