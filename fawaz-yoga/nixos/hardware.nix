{pkgs, ...}: {
  boot.initrd.availableKernelModules = ["nvme" "usb_storage"];
  boot.initrd.systemd.enable = true;
  boot.kernelModules = ["kvm-amd"];
  boot.kernelPackages = pkgs.linuxPackages_latest; # Switch from LTS to Latest
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot.enable = true;
  boot.supportedFilesystems = ["ntfs"];

  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  hardware.bluetooth.enable = true;

  services.udisks2.enable = true;

  boot.initrd.luks.devices."crypt-root" = {
    device = "/dev/disk/by-uuid/e2684e65-9447-4a73-b7d8-97e38686d1ea";
    crypttabExtraOpts = ["tpm2-device=auto"];
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

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.amdgpu.opencl.enable = true;

  environment.systemPackages = with pkgs; [clinfo vulkan-tools amdgpu_top tpm2-tss];
  security.tpm2.enable = true;
  systemd.tpm2.enable = true;
  boot.initrd.systemd.tpm2.enable = true;
}
