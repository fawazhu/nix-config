{
  config,
  lib,
  mcphub-nvim,
  pkgs,
  ...
}: let
  mcp-hub = pkgs.buildNpmPackage {
    pname = "mcp-hub";
    version = "4.2.1";
    src = pkgs.fetchFromGitHub {
      owner = "ravitemer";
      repo = "mcp-hub";
      tag = "v4.2.1";
      sha256 = "sha256-KakvXZf0vjdqzyT+LsAKHEr4GLICGXPmxl1hZ3tI7Yg=";
    };
    npmDepsHash = "sha256-nyenuxsKRAL0PU/UPSJsz8ftHIF+LBTGdygTqxti38g=";
  };
in {
  config = lib.mkIf config.dev.ai {
    programs.neovim.plugins = with pkgs.vimPlugins; [codecompanion-nvim mcphub-nvim minuet-ai-nvim];
    programs.neovim.extraPackages = [mcp-hub];
    xdg.configFile."nvim/after/plugin/ai.lua".source = ./ai.lua;
  };
}
