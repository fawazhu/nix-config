{pkgs, ...}: {
  boot.blacklistedKernelModules = ["nouveau"];
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.luks.devices."crypt-root" = {
    device = "/dev/disk/by-uuid/6a8819c2-b614-4d5e-8b3c-1232f1d489ea";
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

  fileSystems."/var" = {
    device = "/dev/mapper/crypt-root";
    fsType = "btrfs";
    options = ["subvol=var"];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/1470-832C";
    fsType = "vfat";
  };

  hardware.enableAllFirmware = true;
  hardware.acpilight.enable = true;
  hardware.bluetooth.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.i2c.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = [pkgs.intel-media-driver];

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
	hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";

  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}
