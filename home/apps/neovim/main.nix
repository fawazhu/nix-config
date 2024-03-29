{ pkgs, ... }: {
  xdg.configFile = {
    "nvim/after".source = ./config/after;
    "nvim/lua".source = ./config/lua;
    "nvim/init.lua".source = ./config/init.lua;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      packer-nvim
    ];
  };
}
