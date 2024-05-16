{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.my-system.enable && config.my-system.bootstrap) {
    networking = {
      hostName = config.my-system.hostname;
      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
      };
      nftables.enable = true;
    };
    services.resolved = {
      enable = true;
      dnsovertls = "true";
      dnssec = "false";
      domains = ["2606:4700:4700::1111" "1.1.1.1"];
      fallbackDns = ["2606:4700:4700::1001" "1.0.0.1"];
    };
  };
}
