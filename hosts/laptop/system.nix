{
  config,
  pkgs,
  ...
}: let
  userName = "fawaz";
in {
  sops.defaultSopsFile = ./system-secrets.yaml;
  sops.age.keyFile = "/etc/sops/age/keys.txt";
  environment.systemPackages = [pkgs.sops];

  sops.secrets.home_wifi_ssid = {};
  sops.secrets.home_wifi_password = {};
  sops.secrets.password_fawaz.neededForUsers = true;

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
  users.users."${userName}".hashedPasswordFile = config.sops.secrets.password_fawaz.path;

  imports = [../../modules/nixos/my-system];

  my-system = {
    enable = true;
    bootstrap = true;
    desktop.enable = true;
    flatpak.enable = true;
    keyd.enable = true;
    hostname = "fawaz-laptop";
    user.name = userName;
  };

  system.stateVersion = "24.05";
}
