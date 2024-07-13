{pkgs, ...}: {
  environment.etc = {
    "keyd/default.conf".text = ''
      [ids]
      *
      [main]
      capslock = overload(inverse, esc)
      esc = noop
      leftalt = oneshot(alt)
      rightalt = oneshot(altgr)
      shift = oneshot(shift)
      meta = oneshot(meta)
      control = oneshot(control)
      [inverse]
      j = clear()
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
