{config, ...}: let
  flavour = config.theming.flavour;
  accent = config.theming.accent;
  palette = builtins.fromJSON (builtins.readFile ./palette.json);
  accentHex = (builtins.getAttr accent (builtins.getAttr flavour palette).colors).hex;
in {
  xdg.configFile."eza/theme.yml".text = ''
    filekinds:
      directory: {foreground: "${accentHex}"}
      mount_point: {foreground: "${accentHex}"}
  '';
}
