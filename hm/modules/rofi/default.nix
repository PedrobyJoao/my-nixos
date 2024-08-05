{ config, pkgs, ... }:
{
  programs.rofi = {
    # enable = true;
    terminal = "${pkgs.cool-retro-term}/bin/cool-retro-term";
    theme = "gruvbox-light";
  };

  home.file.".config/rofi/config.rasi".text = ''
    configuration {
      display-drun: "Search:";
      display-window: "Windows:";
      show-icons: true;
      drun-display-format: "{name}";
      font: "JetBrainsMono Nerd Font Medium 12";
      modi: "window,run,drun";
      kb-row-up: "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
      kb-row-down: "Down,Control+j";
      kb-accept-entry: "Control+m,Return,KP_Enter";
      terminal: "mate-terminal";
      kb-remove-to-eol: "Control+Shift+e";
      /*kb-mode-next: "Shift+Right,Control+Tab,Control+l";*/
      kb-mode-previous: "Shift+Left,Control+Shift+Tab,Control+h";
      kb-remove-char-back: "BackSpace";
    }

    @theme "gruvbox-light"

  '';
}

####### Old popos rofi theme (dark) #######
# * {
#   bg: #1e1e2e66;
#   bg-alt: #585b7066;
#   bg-selected: #31324466;

#   fg: #cdd6f4;
#   fg-alt: #7f849c;


#   border: 0;
#   margin: 0;
#   padding: 0;
#   spacing: 0;
# }

# window {
#   width: 30%;
#   background-color: @bg;
# }

# element {
#   padding: 8 12;
#   background-color: transparent;
#   text-color: @fg-alt;
# }

# element selected {
#   text-color: @fg;
#   background-color: @bg-selected;
# }

# element-text {
#   background-color: transparent;
#   text-color: inherit;
#   vertical-align: 0.5;
# }

# element-icon {
#   size: 14;
#   padding: 0 10 0 0;
#   background-color: transparent;
# }

# entry {
#   padding: 12;
#   background-color: @bg-alt;
#   text-color: @fg;
# }

# inputbar {
#   children: [prompt, entry];
#   background-color: @bg;
# }

# listview {
#   background-color: @bg;
#   columns: 1;
#   lines: 10;
# }

# mainbox {
#   children: [inputbar, listview];
#   background-color: @bg;
# }

# prompt {
#   enabled: true;
#   padding: 12 0 0 12;
#   background-color: @bg-alt;
#   text-color: @fg;
# }

# /* vim: ft=sass
