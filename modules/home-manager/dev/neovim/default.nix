{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./git
    ./languages
    ./misc
    ./nav
    ./ui
  ];

  config = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      extraWrapperArgs = [
        "--suffix"
        "LIBRARY_PATH"
        ":"
        "${lib.makeLibraryPath [pkgs.stdenv.cc.cc pkgs.zlib pkgs.gcc]}"
        "--suffix"
        "PKG_CONFIG_PATH"
        ":"
        "${lib.makeSearchPathOutput "dev" "lib/pkgconfig" [pkgs.stdenv.cc.cc pkgs.zlib pkgs.gcc]}"
      ];
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };

    xdg.configFile."nvim/init.lua".text = "require(\"before\")";
    xdg.configFile."nvim/lua/before/init.lua".text = ''
      require("before.options")
      require("before.keymap")
    '';
    xdg.configFile."nvim/lua/before/keymap.lua".source = ./keymap.lua;
    xdg.configFile."nvim/lua/before/options.lua".source = ./options.lua;
  };
}
