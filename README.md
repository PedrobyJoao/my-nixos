Standalone Home-Manager for now, I may make it as a module in the future.

Important TODOs:

- [ ] update nixos and hm flakes (Getting some errors now)
- [ ] Home-manager user for non-linux distros

TODOs:

- [ ] suspend when idle
- [ ] tmux (I'm not missing Tmux tbh)
  - [ ] vim visual mode
  - [ ] ressurection?

Cool but not urgent:

- [ ] fix greetd initialization
- [ ] starship: let me know when within nixshell
- [ ] (nvim) Terminal integration, maybe with tmux (fullscreen styled as Taelin's)
- [ ] random wallpapers
- [ ] (nvim) carl sagan message when open
- [ ] hibernate
- [ ] sound control through CLI (e.g.: alsaMixer)

## Dev

### Dev environments, containers and ...

- https://devenv.sh/
- https://github.com/the-nix-way/dev-templates

### Nvim

My entire config is under `hm/nvim/`.

The home-manager config for it is under `hm/modules/nvim.nix`
