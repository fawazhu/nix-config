{pkgs, ...}: {
  environment.etc = {
    "keyd/default.conf".source = ./default.conf;
  };

  systemd.services.keyd = {
    enable = true;
    description = "Key remap daemon";
    serviceConfig = {
      ExecStart = "${pkgs.keyd}/bin/keyd";
    };
    wantedBy = ["multi-user.target"];
  };

  environment.systemPackages = [pkgs.keyd];
}
