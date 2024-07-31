Standalone Home-Manager for now, I may make it as a module in the future.

TODOs:
[x] nvim (quite)
[x] golang
[x] aichat

[] hyperland
[] tmux

[] aider // wait for packaging it

[] golang: build specific shells for each project
[] instead of having Aider as a systemd container, use it as a shell in every project
[] use tmux instead of toggleterm

## Dev

### Dev environments, containers and ...

- https://devenv.sh/
- https://github.com/the-nix-way/dev-templates

### Go

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

### Aichat

It has a nixpkg

### Aider

I'll wait for the people building the nixpkg which is ocurring now.

- important: https://discourse.nixos.org/t/50-packaging-bound-aider/49867/4
- https://src.thehellings.com/greg/aider-flake
- https://github.com/cognivore/flake-aider-chat/blob/main/flake.nix
- https://github.com/paul-gauthier/aider/pull/608
