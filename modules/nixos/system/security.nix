{pkgs, ...}: {
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
}
