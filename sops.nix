{ ... }: {
  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.keyFile = "/home/fawaz/.config/sops/age/keys.txt";
}
