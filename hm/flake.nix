{
  description = "Home Manager configuration of orolo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickemu = {
      # use this PR until it's not into release
      url = "github:quickemu-project/quickemu?ref=pull/1640/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , nixpkgs-master
    , home-manager
    , quickemu
    , ...
    }:
    let
      system = "x86_64-linux";
      overlay-master = final: prev: { master = nixpkgs-master.legacyPackages.${system}; };
      overlay-quickemu = final: prev: {
        inherit (quickemu.packages.${system}) quickemu;
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          overlay-master
          overlay-quickemu
        ];
      };
    in
    {
      homeConfigurations."orolo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];
      };
    };
}
