{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.my-system.enable && config.my-system.bootstrap) {
    security.apparmor.enable = true;

    security.sudo.extraRules = [
      {
        groups = ["wheel"];
        commands = [
          {
            command = "ALL";
            options = ["SETENV" "NOPASSWD"];
          }
        ];
      }
    ];

    environment.systemPackages = with pkgs; [
      sudo
      polkit
    ];
  };
}
