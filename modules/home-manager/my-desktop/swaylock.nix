{
  config,
  lib,
  pkgs,
  ...
}: let
  flavour = config.my-desktop.catppuccinFlavour;
  transparent = "00000000";
  base =
    if flavour == "latte"
    then "eff1f5"
    else if flavour == "frappe"
    then "303446"
    else if flavour == "macchiato"
    then "24273a"
    else if flavour == "mocha"
    then "1e1e2e"
    else transparent;
  text =
    if flavour == "latte"
    then "4c4f69"
    else if flavour == "frappe"
    then "c6d0f5"
    else if flavour == "macchiato"
    then "cad3f5"
    else if flavour == "mocha"
    then "cdd6f4"
    else transparent;
  blue =
    if flavour == "latte"
    then "1e66f5"
    else if flavour == "frappe"
    then "8caaee"
    else if flavour == "macchiato"
    then "8aadf4"
    else if flavour == "mocha"
    then "89b4fa"
    else transparent;
  green =
    if flavour == "latte"
    then "40a02b"
    else if flavour == "frappe"
    then "a6d189"
    else if flavour == "macchiato"
    then "a6da95"
    else if flavour == "mocha"
    then "a6e3a1"
    else transparent;
  lavendar =
    if flavour == "latte"
    then "7287fd"
    else if flavour == "frappe"
    then "babbf1"
    else if flavour == "macchiato"
    then "b7bdf8"
    else if flavour == "mocha"
    then "b4befe"
    else transparent;
  maroon =
    if flavour == "latte"
    then "e64553"
    else if flavour == "frappe"
    then "ea999c"
    else if flavour == "macchiato"
    then "ee99a0"
    else if flavour == "mocha"
    then "eba0ac"
    else transparent;
  peach =
    if flavour == "latte"
    then "fe640b"
    else if flavour == "frappe"
    then "ef9f76"
    else if flavour == "macchiato"
    then "f5a97f"
    else if flavour == "mocha"
    then "fab387"
    else transparent;
  rosewater =
    if flavour == "latte"
    then "dc8a78"
    else if flavour == "frappe"
    then "f2d5cf"
    else if flavour == "macchiato"
    then "f4dbd6"
    else if flavour == "mocha"
    then "f5e0dc"
    else transparent;
in {
  config = lib.mkIf config.my-desktop.enable {
    xdg.configFile."swaylock/config".text = ''
      ignore-empty-password
      hide-keyboard-layout
      disable-caps-lock-text

      color=${base}
      bs-hl-color=${rosewater}
      caps-lock-bs-hl-color=${rosewater}
      caps-lock-key-hl-color=${green}
      inside-color=${transparent}
      inside-clear-color=${transparent}
      inside-caps-lock-color=${transparent}
      inside-ver-color=${transparent}
      inside-wrong-color=${transparent}
      key-hl-color=${green}
      layout-bg-color=${transparent}
      layout-border-color=${transparent}
      layout-text-color=${text}
      line-color=${transparent}
      line-clear-color=${transparent}
      line-caps-lock-color=${transparent}
      line-ver-color=${transparent}
      line-wrong-color=${transparent}
      ring-color=${lavendar}
      ring-clear-color=${rosewater}
      ring-caps-lock-color=${peach}
      ring-ver-color=${blue}
      ring-wrong-color=${maroon}
      separator-color=${transparent}
      text-color=${text}
      text-clear-color=${rosewater}
      text-caps-lock-color=${peach}
      text-ver-color=${blue}
      text-wrong-color=${maroon}
    '';
    home.packages = [pkgs.swaylock];
  };
}
