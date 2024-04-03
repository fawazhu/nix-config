{ lib, ... }: {
  home.username = "fawaz";
  home.homeDirectory = "/home/fawaz";

  home.sessionVariables = {
    "GRIM_DEFAULT_DIR" = "/home/fawaz/Pictures/Screenshots";
  };

  xdg = {
    enable = true;
    userDirs.enable = true;
    userDirs.createDirectories = true;
  };

  home.activation = {
    # We have to use a script because of pure mode.
    # Is this still needed?
    linkFonts = lib.hm.dag.entryAfter ["writeBoundary"] ''
      rm -r ~/.local/share/fonts && true
      ln -s /run/current-system/sw/share/X11/fonts ~/.local/share/fonts 2>/dev/null && true
    '';
  };
}
