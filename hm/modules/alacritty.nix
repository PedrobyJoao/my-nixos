{ config
, pkgs
, inputs
, ...
}:
{
  programs.alacritty = {
    enable = true;
    # theme = "gruvbox_light"; setting theme is not working for now

    settings = {
      keyboard.bindings = [
        {
          action = "ToggleViMode";
          key = "Escape";
          mods = "Alt";
        }
      ];

      env = {
        TERM = "xterm-256color";
      };

      window = {
        padding = {
          x = 3;
          y = 3;
        };
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      # draw_bold_text_with_bright_colors = true;

      selection = {
        save_to_clipboard = false;
      };

      font = {
        normal = {
          family = "Hack Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "Hack Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "Hack Nerd Font Mono";
          style = "Italic";
        };
        size = 12.0;
      };

      colors = {
        primary = {
          background = "0xebdbb2"; # light soft bg0
          foreground = "0x3c3836"; # fg
        };
        normal = {
          black = "0xf2e5bc"; # bg0
          red = "0xcc241d";
          green = "0x98971a";
          yellow = "0xd79921";
          blue = "0x458588";
          magenta = "0xb16286";
          cyan = "0x689d6a";
          white = "0x7c6f64";
        };
        bright = {
          black = "0x928374";
          red = "0x9d0006";
          green = "0x79740e";
          yellow = "0xb57614";
          blue = "0x076678";
          magenta = "0x8f3f71";
          cyan = "0x427b58";
          white = "0x3c3836";
        };
        cursor = {
          text = "0xf2e5bc";
          cursor = "0x3c3836";
        };
      };

    };
  };
}
