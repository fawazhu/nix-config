{
  config,
  pkgs,
  ...
}: {
  sops.defaultSopsFile = ../secrets.yaml;
  sops.age.keyFile = "/etc/sops/age/keys.txt";

  sops.secrets.home_wifi_ssid = {};
  sops.secrets.home_wifi_password = {};
  sops.templates."home-wifi.nmconnections" = {
    path = "/etc/NetworkManager/system-connections/home-wifi.nmconnections";
    content = ''
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
  };

  sops.secrets.password.neededForUsers = true;
  users.users.fawaz.hashedPasswordFile = config.sops.secrets.password.path;

  environment.systemPackages = [pkgs.sops];
}
