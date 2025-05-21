{pkgs, ...}: let
  irPackage = pkgs.callPackage ./linux-enable-ir-emitter.nix {};
  howdyPackage = pkgs.callPackage ./howdy.nix {};
in {
  imports = [
    ../../modules/nixos/my-desktop
    ../../modules/nixos/system
    ../../modules/nixos/theming
    ./hardware.nix
    ./secrets.nix
  ];

  theming = {
    flavour = "macchiato";
    accent = "peach";
    scaling = 2;
  };

  users.users."fawaz" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };
  nix.settings.trusted-users = ["fawaz"];

  environment.localBinInPath = true;
  programs.zsh.enable = true;
  networking.hostName = "fawaz-yoga";
  system.stateVersion = "24.11";

  environment.systemPackages = [irPackage howdyPackage];

  systemd.services.linux-enable-ir-emitter = let
    targets = [
      "suspend.target"
      "sleep.target"
      "hybrid-sleep.target"
      "hibernate.target"
      "suspend-then-hibernate.target"
    ];
  in {
    description = "Enable the infrared emitter";

    script = "${irPackage}/bin/linux-enable-ir-emitter run";
    serviceConfig.ConfigurationDirectory = "linux-enable-ir-emitter";
    serviceConfig.StateDirectory = "linux-enable-ir-emitter";
    wantedBy = targets ++ ["multi-user.target"];
    after = targets ++ ["dev-video2.device"];
  };
  system.activationScripts.pam_howdy = ''
    mkdir -p /etc/pam.d/
    test -e /etc/pam.d/pam_howdy.so >/dev/null || ln -s "${howdyPackage}/lib/security/pam_howdy.so" /etc/pam.d/pam_howdy.so
  '';
  environment.etc."howdy/config.ini".text = ''
    [video]
    device_path = /dev/video2
  '';

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
  '';
}
