{ ... }: {
  imports = [
    ./git
    ./misc
    ./nav
    ./ui
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  xdg.configFile."nvim/init.lua".text = "require(\"before\")";
  xdg.configFile."nvim/lua/before/init.lua".text = ''
    require("before.options")
    require("before.keymap")
  '';
  xdg.configFile."nvim/lua/before/keymap.lua".source = ./keymap.lua;
  xdg.configFile."nvim/lua/before/options.lua".source = ./options.lua;
}
