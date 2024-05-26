{
  config,
  lib,
  pkgs,
  ...
}: let
  enable = config.my-dev.tools.codeium.enable;
in {
  config = lib.mkIf enable {
    home.packages = [pkgs.codeium];
    programs.neovim.plugins = [pkgs.vimPlugins.codeium-vim];

    xdg.configFile."nvim/after/syntax/codeium-syntax.vim" = {
      text = ''
        highlight CodeiumSuggestion guifg=#808080 ctermfg=244
      '';
    };
    xdg.configFile."nvim/after/plugin/codeium.lua" = {
      text = ''
        vim.g.codeium_bin = "${pkgs.codeium}/bin/codeium_language_server"
        vim.g.codeium_enabled = true
        vim.g.codeium_disable_bindings = true
        vim.g.codeium_idle_delay = 200
        vim.g.codeium_render = true
        vim.keymap.set("i", "<c-q>", "codeium#Accept()", { expr = true, silent = true, nowait = true, script = true })
        vim.keymap.set("i", "<c-`>", "<Cmd>call codeium#Clear()<CR>", { expr = true, silent = true })
        vim.g.codeium_filetypes = {
          TelescopePrompt = false
        }
      '';
    };
  };
}
