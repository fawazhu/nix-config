{
  description = "Personal configuration.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
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
          sops-nix.nixosModules.sops
          ./fawaz-laptop/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs.flake-inputs = inputs;
            home-manager.users.fawaz = import ./fawaz-laptop/home-manager;
            home-manager.sharedModules = [
              (
                {pkgs, ...}: let
                  overlay-pyside6 = final: prev: {
                    pyside6 = pkgs.callPackage ./pyside6.nix {};
                  };
                in {
                  nixpkgs.overlays = [overlay-pyside6];
                }
              )
              sops-nix.homeManagerModules.sops
            ];
          }
        ];
        #        modules = [
        #          ./hosts/laptop/hardware.nix
        #          {_module.args = {inherit inputs;};}
        #          ./hosts/laptop/system.nix
        #          {_module.args = {inherit inputs;};}
        #          home-manager.nixosModules.home-manager
        #          {
        #            home-manager.useGlobalPkgs = true;
        #            home-manager.useUserPackages = true;
        #            home-manager.extraSpecialArgs.flake-inputs = inputs;
        #            home-manager.users.fawaz = import ./hosts/laptop/fawaz.nix;
        #            home-manager.sharedModules = [
        #              sops-nix.homeManagerModules.sops
        #            ];
        #          }
        #          sops-nix.nixosModules.sops
        #        ];
      };
    };
  };
}
