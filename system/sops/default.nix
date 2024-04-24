{pkgs, ...}: {
  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.keyFile = "/etc/sops/age/keys.txt";

  environment.systemPackages = [pkgs.sops];
}
