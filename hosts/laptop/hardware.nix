{ pkgs, ... }: {
  hardware.enableAllFirmware = true;
  hardware.acpilight.enable = true;
  hardware.bluetooth.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.i2c.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = [ pkgs.intel-media-driver ];
}
