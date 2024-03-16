{ ... }: {
  networking = {
    hostName = "fawaz-laptop";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      # TODO: automate wifi configuration. For now use nmtui, you might have to set the DNS explicitly here temporarily.
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
}
