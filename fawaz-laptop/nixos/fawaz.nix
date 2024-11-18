{ pkgs, ... }: {
  services.greetd.settings.initial_session = {
    command = "Hyprland";
    user = "fawaz";
  };
  programs.zsh.enable = true;
  users.users."fawaz" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };
}
