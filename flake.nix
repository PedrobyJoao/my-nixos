# /etc/nixos/flake.nix
{
  description = "flake for anathem";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs }@inputs:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      anathem = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          ./hosts/anathem/configuration.nix
	];
      };
    };
  };
}
