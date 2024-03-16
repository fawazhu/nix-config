{ pkgs, ... }: {
  security.apparmor.enable = true;

  security.pam.services.swaylock = {};
  
  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "ALL";
          options = [ "SETENV" "NOPASSWD" ];
        }
      ];
    }
  ];

  environment.systemPackages = with pkgs; [
    sudo
    polkit
    polkit-kde-agent
  ];
}
