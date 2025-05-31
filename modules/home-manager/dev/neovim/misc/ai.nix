{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.dev.ai {
    home.packages = [pkgs.ollama];
    systemd.user.services.ollama = {
      Unit = {
        Description = "Ollama AI";
        After = "multi-user.target";
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.ollama}/bin/ollama serve";
        Restart = "always";
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
    systemd.user.startServices = true;

    programs.neovim.plugins = [pkgs.vimPlugins.codecompanion-nvim];
    xdg.configFile."nvim/after/plugin/ai.lua".source = ./ai.lua;
  };
}
