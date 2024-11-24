{pkgs, ...}:
with pkgs;
  stdenv.mkDerivation (finalAttrs: {
    pname = "hyprland-session";
    version = "";

    src = "";

    unpackPhase = "true";

    outputs = [ "out" ];

    installPhase = ''
      mkdir -p $out/share/wayland-sessions
      ln -s "${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop" $out/share/wayland-sessions/hyprland.desktop
    '';
  })
