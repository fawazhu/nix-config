{ ... }: {
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.luks.devices = {
    "crypt-root" = {
      device = "/dev/disk/by-uuid/c4c33a6a-2d49-49cc-8619-0bcedbda9020";
      bypassWorkqueues = true;
    };
  };
  boot.kernelModules = [ "kvm-intel" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot.enable = true;
}
