{ config, lib, ... }: {
  config = lib.mkIf config.my-apps.enable {
    services.kdeconnect.enable = config.my-apps.services.kdeconnect.enable;
  };
}
