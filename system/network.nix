{ config, ... }: {
  sops.secrets.home_wifi_ssid = {};
  sops.secrets.home_wifi_password = {};

  sops.templates."home-wifi.nmconnections".content = ''
    [connection]
    id=home-wifi
    type=wifi
    
    [wifi]
    mode=infrastructure
    ssid=${config.sops.placeholder.home_wifi_ssid}
    
    [wifi-security]
    auth-alg=open
    key-mgmt=wpa-psk
    psk=${config.sops.placeholder.home_wifi_password}
    
    [ipv4]
    dns=1.1.1.1;1.0.0.1;
    method=auto
    
    [ipv6]
    addr-gen-mode=default
    method=auto
    
    [proxy]
  '';

  environment.etc = {
    "NetworkManager/system-connections/home-wifi.nmconnections".source = config.sops.templates."home-wifi.nmconnections".path;
  };

  networking = {
    hostName = "fawaz-laptop";
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
}
