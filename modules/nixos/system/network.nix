{...}: {
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  networking.nftables.enable = true;
  services.resolved = {
    enable = true;
    dnsovertls = "true";
    dnssec = "false";
    domains = ["2606:4700:4700::1111" "1.1.1.1"];
    fallbackDns = ["2606:4700:4700::1001" "1.0.0.1"];
  };
}
