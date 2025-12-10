{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.dev.ai {
    #programs.neovim.plugins = with pkgs.vimPlugins; [codecompanion-nvim];
    #xdg.configFile."nvim/after/plugin/ai.lua".source = ./ai.lua;
  };
}
