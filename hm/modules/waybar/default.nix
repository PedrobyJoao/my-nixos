{ config
, lib
, pkgs
, ...
}:
{
  imports = [ ./colors.nix ];
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];
        modules-center = [
          "clock#date"
          "battery"
          "clock#time"
        ];
        modules-right = [
          "network"
          "memory"
          "cpu"
          "temperature"
          "pulseaudio"
          "custom/keyboard-layout"
          "tray"
        ];

        battery = {
          interval = 3;
          states = {
            # "good" = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format-charging = "󰂄 {capacity}%";
          format-plugged = " {capacity}%";
        };

        "clock#time" = {
          interval = 1;
          format = "{:%H:%M}";
          tooltip = false;
        };

        "clock#date" = {
          interval = 10;
          format = "  {:%e %b}";
          tooltip-format = "{:%e %B}";
        };

        cpu = {
          interval = 5;
          format = "{usage}% CPU";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "custom/keyboard-layout" = {
          exec = "hyprctl devices | grep -m1 'Active Keyboard Layout' | awk '{print $4}'";
          interval = 30;
          format = "  {}";
          signal = 1;
          tooltip = false;
        };

        memory = {
          format = "{used:0.1f}GB RAM";
          tooltip-format = "{used:0.1f}GB used out of {total:0.1f}GB";
          interval = 5;
          states = {
            warning = 70;
            critical = 90;
          };
        };

        network = {
          format = "{icon} {essid}";
          format-icons = {
            "wifi" = [
              "󰤟 "
              "󰤢 "
              "󰤥 "
              "󰤨 "
            ];
            "ethernet" = [ "󰈀" ];
            "disconnected" = [ "󰌙" ];
          };
          tooltip-format = ''
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';

          interval = 5;
          # format-disconnected = "󰯡 Disconnected";
          # format-ethernet = "󰒢 Connected!";
          # format-wifi = "󰖩 {essid}";
        };

        "hyprland/submap" = {
          format = "<span style=\"italic\">  {}</span>";
          tooltip = false;
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 120;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          format = "{icon}";
          all-outputs = true;
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
          };
        };

        temperature = {
          # fixes wrong temperature
          # see: https://bbs.archlinux.org/viewtopic.php?id=282319
          # get the path with core_temp + temp1_input
          hwmon-path-abs = "/sys/devices/platform/coretemp.0/hwmon";
          input-filename = "temp1_input";

          critical-threshold = 80;
          interval = 5;
          format = "{icon} {temperatureC}°C";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = true;
        };

        pulseaudio = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "{icon} {volume}%  {format_source}";
          "format-bluetooth-muted" = "{icon}    {format_source}";
          "format-muted" = " ";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
            #     "headphone" = "󰋋";
            #     "hands-free" = "󰏳";
            #     "headset" = "󰋎";
            #     "phone" = "";
            #     "portable" = "";
            #     "car" = "";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          "on-click" = "${lib.getExe pkgs.pavucontrol}";
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };
      }
    ];
  };
}
