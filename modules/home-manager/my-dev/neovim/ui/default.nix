{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my-dev.enable {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      lualine-nvim
      noice-nvim
      nvim-notify
    ];
    xdg.configFile."nvim/after/plugin/lualine.lua".source = ./lualine.lua;
    xdg.configFile."nvim/after/plugin/noice.lua".source = ./noice.lua;
    xdg.configFile."nvim/after/plugin/notify.lua".source = ./notify.lua;
    xdg.configFile."nvim/after/plugin/theme.lua".source = ./theme.lua;
    xdg.configFile."nvim/after/plugin/flavour.lua".text = ''
      vim.cmd.colorscheme "catppuccin-${config.my-dev.catppuccinFlavour}"
    '';
  };
}
