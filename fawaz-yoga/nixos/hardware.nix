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
}
