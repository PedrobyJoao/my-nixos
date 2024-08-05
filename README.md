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
  - [ ] network manage GUI
  - [ ] waybar
  - [ ] file explorer GUI
  - [ ] settings GUI (did I ever use this back on popos?)
  - [ ] random wallpapers
- [ ] tmux
  - [ ] gruvbox light theme as nvim
  - [ ] ressurection?
- [ ] screenshot by keybind (see my old config)
- [ ] brightness control (GUI or cli again?)
- [ ] codeium
- [ ] coq env and necessary tools for Software Foundations
- [ ] aider // WAIT: a nixpkg is being created for it

Cool but not urgent:

- [ ] random wallpapers
- [ ] hibernate
- [ ] hyprland start one terminal

## Dev

### Dev environments, containers and ...

- https://devenv.sh/
- https://github.com/the-nix-way/dev-templates

### Go

Tip: build specific shell for each project

Adding the following `shell.nix` in my `go` project was enough to run something with: `sqlite`, `libp2p` and other libraries...

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    go
    gcc
    pkg-config
    sqlite
  ];

  shellHook = ''
    export CGO_ENABLED=1
  '';
}
```

## Dev-Tools

### Nvim

TODOs:

- [ ] Codeium
- [ ] copy and paste between terminals
- [ ] Terminal integration, maybe with tmux (fullscreen styled as Taelin's)

### Aichat

It has a nixpkg

### Aider

I'll wait for the people building the nixpkg which is ocurring now.

Possibility: instantiate Aider within a dev shell together with project's nix shell if any.

- important: https://discourse.nixos.org/t/50-packaging-bound-aider/49867/4
- https://src.thehellings.com/greg/aider-flake
- https://github.com/jbotwell/nixaider
- https://github.com/cognivore/flake-aider-chat/blob/main/flake.nix
- https://github.com/paul-gauthier/aider/pull/608
