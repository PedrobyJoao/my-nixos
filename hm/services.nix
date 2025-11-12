{ pkgs, ... }:

{
  # Hourly lock for stretch breaks (user session)
  systemd.user.services.hyprlock-hourly = {
    Unit = {
      Description = "Lock screen hourly for stretch break";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStartPre = [
        "${pkgs.libnotify}/bin/notify-send 'Stretch break' 'Locking screen in 20s' -u critical"
        "${pkgs.coreutils}/bin/sleep 20"
      ];
      ExecStart = "${pkgs.hyprland}/bin/hyprctl dispatch exec ${pkgs.hyprlock}/bin/hyprlock";
    };
  };

  systemd.user.timers.hyprlock-hourly = {
    Unit = {
      Description = "Trigger hyprlock hourly";
    };
    Timer = {
      OnCalendar = "hourly";
      Persistent = true; # if missed, trigger shortly after login
      Unit = "hyprlock-hourly.service";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  # Daily poweroff at 21:00 (user session)
  systemd.user.services.poweroff-at-2100 = {
    Unit = {
      Description = "Power off at 21:00 daily";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl poweroff";
    };
  };

  systemd.user.timers.poweroff-at-2100 = {
    Unit = {
      Description = "Trigger daily poweroff at 21:00";
    };
    Timer = {
      OnCalendar = "21:00";
      Persistent = false; # do not power off immediately if a run was missed
      Unit = "poweroff-at-2100.service";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
