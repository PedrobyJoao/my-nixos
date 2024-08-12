{ pkgs, inputs, ... }:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/wayland-sessions";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session}";
        user = "greeter";
      };
    };
  };
}
