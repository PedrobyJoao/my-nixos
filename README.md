Standalone Home-Manager for now, I may make it as a module in the future.

TODOs:

- [ ] codeium (ok, that is important. Should I simply use Copilot?)
- [ ] screenshot by keybind (see my old config)
- [ ] suspend when idle
- [ ] tmux (I'm not missing Tmux tbh)
  - [ ] gruvbox light theme as nvim
  - [ ] vim visual mode
  - [ ] ressurection?

Cool but not urgent:

- [ ] fix greetd initialization
- [ ] starship: let me know when within nixshell
- [ ] (nvim) Terminal integration, maybe with tmux (fullscreen styled as Taelin's)
- [ ] random wallpapers
- [ ] (nvim) carl sagan message when open
- [ ] hibernate
- [ ] fuzzy finder to be used to find files within $HOME
- [ ] sound control through CLI (e.g.: alsaMixer)

## Dev

### Dev environments, containers and ...

- https://devenv.sh/
- https://github.com/the-nix-way/dev-templates

### Go

Tip: for each project, create a minimal flake.nix with `mkShell`.

And use `nix develop` to enter the shell.

Example:

```nix
{
  description = "NuNet Device Management Service";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    ,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ ];
        };
      in
      {
        packages = rec {
          device-management-service = pkgs.buildGoModule {
            pname = "device-management-service";
            src = ./.;
            vendorHash = null; # Let nix compute the vendor hash
            # If you have a vendor directory, use this instead:
            # vendorHash = pkgs.lib.fakeSha256;

            buildInputs = with pkgs; [
              pkg-config
              sqlite
            ];

            # Add any necessary build flags here
            buildFlags = [ "-tags=libsqlite3" ];

            meta = {
              description = "NuNet Device Management Service";
              homepage = "https://gitlab.com/nunet/device-management-service";
              # license = licenses.<something>;
            };
          };
          default = device-management-service;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go_1_21
            gopls
            gotools
            go-tools
            sqlite
            pkg-config
            systemd.dev
          ];

          shellHook = ''
            export CGO_ENABLED=1
            export PKG_CONFIG_PATH="${pkgs.systemd.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
          '';
        };
      }
    );
}
```

## Dev-Tools

### Nvim

My entire config is under `hm/nvim/`.

The home-manager config for it is under `hm/modules/nvim.nix`
