{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.my-system.enable && config.my-system.bootstrap) {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
