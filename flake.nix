{
  description = "Personal configuration.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
    sops-nix.url = "github:mic92/sops-nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    sops-nix,
    ...
  }: {
    nixosConfigurations = {
      "fawaz-laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/hardware.nix
          {_module.args = {inherit inputs;};}
          ./hosts/laptop/system.nix
          {_module.args = {inherit inputs;};}
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs.flake-inputs = inputs;
            home-manager.users.fawaz = import ./hosts/laptop/fawaz.nix;
            home-manager.users.guest = import ./hosts/laptop/guest.nix;
            home-manager.sharedModules = [
              sops-nix.homeManagerModules.sops
            ];
          }
          sops-nix.nixosModules.sops
        ];
      };
    };
  };
}
