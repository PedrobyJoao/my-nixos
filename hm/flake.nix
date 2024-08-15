{
  description = "Home Manager configuration of orolo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , nixpkgs-master
    , home-manager
    , ...
    }:
    let
      system = "x86_64-linux";
      overlay-master = final: prev: { master = nixpkgs-master.legacyPackages.${system}; };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ overlay-master ];
      };
    in
    {
      homeConfigurations."orolo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];
      };
    };
}
