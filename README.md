### Home Manager

Standalone Home-Manager for now, I may make it as a module in the future.

Also, since I'm using standalone HM, I noticed that when updating my flakes, I should update both flakes
of my NixOS config and the flake of my home-manager. Otherwise, updating just one of them might result in errors.

### TODOs

Important TODOs:

- [ ] Home-manager user for non-linux distros
- [ ] easy sandbox to test anything

TODOs:

- [ ] suspend when idle
- [ ] tmux (I'm not missing Tmux tbh)
  - [ ] vim visual mode
  - [ ] ressurection?
- [ ] assets as submodule
- [ ] nvim as submodule

Cool but not urgent:

- [ ] (nvim) Terminal integration, maybe with tmux (fullscreen styled as Taelin's)
- [ ] random wallpapers
- [ ] (nvim) carl sagan message when open
- [ ] hibernate
