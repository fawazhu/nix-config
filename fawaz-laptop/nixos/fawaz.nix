{ pkgs, ... }: {
  programs.zsh.enable = true;
  users.users."fawaz" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };
}
