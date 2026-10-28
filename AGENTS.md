# Repository guide

Personal NixOS configuration with standalone Home Manager.
The root flake manages NixOS; `hm/flake.nix` manages Home Manager
separately.

## Where to find things

Paths are relative to the repository root.

- Neovim: `hm/modules/nvim.nix` and `hm/nvim/`.
- Hyprland, Hyprlock, and related: `hm/modules/hypr/`.
- Waybar: `hm/modules/waybar/`.
- Rofi: `hm/modules/rofi/`.
- Alacritty: `hm/modules/alacritty.nix`.
- Git: `hm/modules/git.nix`.
- Main home manager file: `hm/home.nix`.
- Bash and active shell aliases: `hm/home.nix`.
- greetd: `modules/greetd.nix`.

## Working conventions

- Check imports before assuming a module is active. Home Manager imports
  are in `hm/home.nix` and `hm/modules/default.nix`.
- Do not update flake lock files or change `stateVersion` unless requested.
