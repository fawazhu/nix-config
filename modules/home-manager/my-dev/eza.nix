{config, ...}: let
  flavour = config.my-dev.catppuccinFlavour;
  accent = config.my-dev.catppuccinAccent;
  palette = builtins.fromJSON (builtins.readFile ./palette.json);
  accentHex = (builtins.getAttr accent (builtins.getAttr flavour palette).colors).hex;
in {
  xdg.configFile."eza/theme.yml".text = ''
    filekinds:
      directory: {foreground: "${accentHex}"}
      mount_point: {foreground: "${accentHex}"}
  '';
}
