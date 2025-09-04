{

  description = "Personal configuration.";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    home-manager,
    nixpkgs,
    nix-flatpak,
    plasma-manager,
    sops-nix,
    ...
  }: {
    nixosConfigurations = {
      "fawaz-yoga" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          sops-nix.nixosModules.sops
          ./fawaz-yoga/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "hmbkp";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs.flake-inputs = inputs;
            home-manager.extraSpecialArgs.hostname = "fawaz-yoga";
            home-manager.users.fawaz = import ./fawaz-yoga/home-manager;
            home-manager.sharedModules = [
              nix-flatpak.homeManagerModules.nix-flatpak
              plasma-manager.homeModules.plasma-manager
              sops-nix.homeManagerModules.sops
            ];
          }
        ];
      };
    };
  };
}
