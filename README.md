Standalone Home-Manager for now, I may make it as a module in the future.

TODOs:
[x] nvim (quite)
[] tmux
[] hyperland
[] golang
[] aider
[] aichat

[] lazygit
[] use tmux instead of toggleterm

## Go

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
