Standalone Home-Manager for now, I may make it as a module in the future.

TODOs:

- [x] nvim (quite, enough)
- [x] golang (see details below)
- [x] aichat
- [ ] WM and dev environment
  - [x] minimal hyprland
  - [x] minimal rofi drun
  - [x] blueman (accessable by rofi)
  - [x] slack
  - [x] sound GUI? pipewire has one?
  - [x] zoom (try browser version first)
  - [x] file explorer GUI (nemo)
  - [x] notification
  - [x] clipboard not working in every case
  - [x] network manager GUI (sudo nmtui)
  - [x] locker
  - [x] login manager
  - [x] waybar
  - [x] fix resolution (tabs of windows (See slack) are too big?)
  - [ ] suspend when idle
- [ ] codeium
- [ ] tmux
  - [ ] gruvbox light theme as nvim
  - [ ] vim visual mode
  - [ ] ressurection?
- [ ] screenshot by keybind (see my old config)
- [x] brightness control (GUI or cli again?)
- [x] coq env and necessary tools for Software Foundations

Cool but not urgent:

- [x] incorrect temperature
- [x] keyboard not connecting (just had to use bluetoothcli)
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

### Aichat

It has a nixpkg

### Aider

Merged on nixpkgs (master branch): https://github.com/NixOS/nixpkgs/pull/323927

extra: https://discourse.nixos.org/t/50-packaging-bound-aider/49867/4
