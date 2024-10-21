{ config, pkgs, ... }:

{
  imports = [
    ./modules/git.nix
    ./modules/nvim.nix
    ./modules/alacritty.nix
    ./modules
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "orolo";
  home.homeDirectory = "/home/orolo";

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # dev
    go
    gotools

    # dev-tools
    aichat
    master.aider-chat
    portaudio # for aider voice assistant
    htop
    tree
    act # github workflow local test

    # fonts
    (nerdfonts.override { fonts = [ "Hack" ]; })
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # desktop env tools
    rofi-wayland
    wl-clipboard
    xdg-utils
    dunst
    nemo
    swaylock
    unzip
    fzf

    # net, bluetooth, sounds... 
    networkmanagerapplet
    pavucontrol
    brightnessctl

    # work tools
    google-chrome
    slack

    # others
    brave
    discord

    # fun
    neofetch

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # xdg.configFile.nvim.source = ./nvim;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/orolo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.bash = {
    enable = true;

    initExtra = ''
      # Enable vi editing mode
      set -o vi

      # Bind C-x C-e to open current command in editor
      bind '"\C-x\C-e": edit-and-execute-command'

      eval "$(fzf --bash)"

      export NUNET="/home/orolo/lab/nunet"
    '';

    shellAliases = {
      hms = "home-manager switch --flake /home/orolo/my-nixos/hm/";
      nixswitch = "sudo nixos-rebuild switch --flake /home/orolo/my-nixos/";
      nixevalstrict = "nix-instantiate --eval --strict";
      nixeval = "nix-instantiate --eval";
      gs = "git status";
      v = "nvim";
      ll = "ls -l";
      la = "ls -a";
      l = "ls -CF";
      tmp = "nvim $(mktemp /tmp/tmpnote.XXXXXX)";
      aider = "aider --no-auto-commits -c ~/.config/aider/config.yaml";
      nunet = "cd ~/lab/nunet";
      vdots = "nvim ~/my-nixos";
      grm = "go run main.go";
      ais = "aichat -s temp --code";
      ai = "aichat -s temp --role simple";
    };
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./extras/starship.toml;
  };

  programs.lazygit = {
    enable = true;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
