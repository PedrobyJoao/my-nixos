{ config
, pkgs
, inputs
, ...
}:
{
  programs.alacritty = {
    enable = true;

    settings = {
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
    };
  };
}
