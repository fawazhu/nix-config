{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my-shell.enable {
    home.packages = with pkgs; [ripgrep jq xq-xml yq-go eza fzf fd socat bat];
  };
}
