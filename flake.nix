{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.m1 = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/m1/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.worknb = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/worknb/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/pc/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
