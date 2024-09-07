{pkgs, ...}: {
  environment.etc = {
    "keyd/default.conf".text = ''
      [ids]
      *
      [main]
      capslock = esc
      esc = noop
      leftalt = oneshot(myalt)
      shift = oneshot(myshift)
      meta = oneshot(mymeta)
      control = oneshot(mycontrol)
      [myalt:A]
      leftalt = clear()
      [myshift:S]
      shift = clear()
      [mymeta:M]
      meta = clear()
      [mycontrol:C]
      control = clear()
    '';
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
