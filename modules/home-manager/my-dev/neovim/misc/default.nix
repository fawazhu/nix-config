{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./codeium.nix];

  config = lib.mkIf config.my-dev.enable {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      undotree
      indent-blankline-nvim
      vim-sleuth
    ];
    xdg.configFile."nvim/after/plugin/autocommand.lua".source = ./autocommand.lua;
    xdg.configFile."nvim/after/plugin/indent_blankline.lua".source = ./indent_blankline.lua;
    xdg.configFile."nvim/after/plugin/undotree.lua".source = ./undotree.lua;
  };
}
