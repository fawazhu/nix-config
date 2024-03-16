{ pkgs, ... }: {
  environment.etc = {
    "keyd/default.conf".source = ./config/default.conf;
  };

  systemd.services.keyd = {
    enable = true;
    description = "Key remap daemon";
    unitConfig = {
      Type = "simple";
    };
    serviceConfig = {
      ExecStart = "${pkgs.keyd}/bin/keyd";
    };
    wantedBy = [ "multi-user.target" ];
  };

  environment.systemPackages = [ pkgs.keyd ];
}
