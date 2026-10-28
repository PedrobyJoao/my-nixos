{ config, pkgs, ... }:
let
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  hyprlock = "${config.programs.hyprlock.package}/bin/hyprlock";
  lockCommand = "${pkgs.procps}/bin/pgrep -x hyprlock || ${hyprlock}";
in
{
  services.hypridle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = {
      general = {
        lock_cmd = lockCommand;
        before_sleep_cmd = lockCommand;
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
        # Wait for Hyprlock to acquire the session lock before suspending.
        inhibit_sleep = 3;
      };

      listener = [
        {
          timeout = 300;
          on-timeout = lockCommand;
        }
        {
          timeout = 600;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
        {
          timeout = 900;
          on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
