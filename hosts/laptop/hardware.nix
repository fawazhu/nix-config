{pkgs, ...}: {
  boot.blacklistedKernelModules = ["nouveau"];
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.luks.devices."crypt-root" = {
    device = "/dev/disk/by-uuid/c4c33a6a-2d49-49cc-8619-0bcedbda9020";
    bypassWorkqueues = true;
  };
  boot.kernelModules = ["kvm-intel"];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot.enable = true;

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

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/f49198d6-71cb-4b79-b354-435c7a6601c5";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/A7CA-B1E6";
    fsType = "vfat";
  };

  hardware.enableAllFirmware = true;
  hardware.acpilight.enable = true;
  hardware.bluetooth.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.i2c.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = [pkgs.intel-media-driver];
}
