# /etc/nixos/flake.nix
{
  description = "flake for anathem";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    ,
    }@inputs:
    let
      system = "x86_64-linux";

      # The `specialArgs` parameter passes the
      # non-default nixpkgs instances to other nix modules
    in
    {
      nixosConfigurations = {
        anathem = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs system;
            pkgs-stable = import nixpkgs-stable {
              inherit system;
            };
          };
          modules = [
            ./hosts/anathem/configuration.nix
          ];
        };
      };
    };
}
