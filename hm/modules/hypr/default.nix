{ config
, lib
, pkgs
, ...
}:
let
  scripts = import ./scripts.nix { inherit pkgs; };
in
{
  imports = [
    ./hyprland-environment.nix
    ./hyprlock.nix
    # ./hypridle.nix
  ];

  home.packages = with pkgs; [
    waybar
    hyprshot
    wlr-randr
    bibata-cursors
  ];

  #test later systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''

        # Monitors
        monitor=eDP-1,1920x1200,0x0,1.2,bitdepth,10
        monitor = HDMI-A-1,3840x2160,0x0,1.5,bitdepth,10

        # Run the monitor switch script on startup and when triggered
        exec-once = ${scripts.monitorSwitch}/bin/monitorSwitch;

        # Fix slow startup
        # exec systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        # exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP 

        # Autostart

        exec-once = hyprctl setcursor Bibata-Modern-Classic 16
        exec-once = dunst

        source = /home/orolo/.config/hypr/colors
        exec = pkill waybar & sleep 0.5 && waybar &

        # Set en layout at startup

        # Input config
        input {
            kb_layout = us, br
            kb_variant =
            kb_model =
            kb_options =
            kb_rules =

            follow_mouse = 0

            touchpad {
                natural_scroll = false
            }

            sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        }

        general {

            gaps_in = 5
            gaps_out = 10
            border_size = 2
            col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
            col.inactive_border = rgba(595959aa)

            layout = dwindle
        }

        # decoration {

        #     rounding = 10
        #     blur = true
        #     blur_size = 3
        #     blur_passes = 1
        #     blur_new_optimizations = true

        #     drop_shadow = true
        #     shadow_range = 4
        #     shadow_render_power = 3
        #     col.shadow = rgba(1a1a1aee)
        # }

        animations {
            enabled = yes

            bezier = ease,0.4,0.02,0.21,1

            animation = windows, 1, 3.5, ease, slide
            animation = windowsOut, 1, 3.5, ease, slide
            animation = border, 1, 6, default
            animation = fade, 1, 3, ease
            animation = workspaces, 1, 3.5, ease
        }

        dwindle {
            pseudotile = yes
            preserve_split = yes
        }

        # master {
        #     new_is_master = yes
        # }

        misc {
            new_window_takes_over_fullscreen = 2
        }

        gestures {
            workspace_swipe = false
        }

        windowrule=center,^(rofi)$
        windowrule=float,^(rofi)$
        windowrule=float,^(blueman-manager)$

        $mainMod = SUPER

        bind = $mainMod, M, fullscreen, 1
        bind = $mainMod, RETURN, exec, alacritty
        bind = $mainMod, R, exec, rofi -show drun -show-icons
        bind = $mainMod, B, exec, brave 
        bind = $mainMod, Q, killactive,
        bind = $mainMod SHIFT, Q, exit,
        bind = $mainMod, F, exec, nautilus
        bind = $mainMod, V, togglefloating,
        bind = $mainMod, P, pseudo, # dwindle
        # bind = $mainMod, J, togglesplit, # dwindle

        # hyprlock
        bind = $mainMod, C, exec, hyprlock
        bindl=,switch:Lid Switch, exec, hyprlock

        # Switch Keyboard Layouts
        bind = $mainMod, SPACE, exec, hyprctl switchxkblayout keyboard-k380-keyboard next

        # Switch monitor
        bind = $mainMod CTRL SHIFT, S, exec, ${scripts.monitorSwitch}/bin/monitorSwitch

        # Screenshot a region
        bind = $mainMod SHIFT, P, exec, hyprshot -m region --clipboard-only

        # Functional keybinds
        bind =,XF86AudioMicMute,exec,pamixer --default-source -t
        bind = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-
        bind = ,XF86MonBrightnessUp, exec, brightnessctl s +10%
        bind =,XF86AudioMute,exec,pamixer -t
        bind =,XF86AudioLowerVolume,exec,pamixer -d 10
        bind =,XF86AudioRaiseVolume,exec,pamixer -i 10
        bind =,XF86AudioPlay,exec,playerctl play-pause
        bind =,XF86AudioPause,exec,playerctl play-pause

        # to switch between windows in a floating workspace
        bind = SUPER,Tab,cyclenext,
        bind = SUPER,Tab,bringactivetotop,

        # Move focus with mainMod + arrow keys
        bind = $mainMod, h, movefocus, l
        bind = $mainMod, l, movefocus, r
        bind = $mainMod, k, movefocus, u
        bind = $mainMod, j, movefocus, d

        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        # resize
      binde = $mainMod SHIFT CTRL, l, resizeactive, 30 0
      binde = $mainMod SHIFT CTRL, h, resizeactive, -30 0
      binde = $mainMod SHIFT CTRL, k, resizeactive, 0 -30
      binde = $mainMod SHIFT CTRL, j, resizeactive, 0 30

      bind = $mainMod SHIFT, h, exec, hyprctl dispatch movewindow l
      bind = $mainMod SHIFT, l, exec, hyprctl dispatch movewindow r
      bind = $mainMod SHIFT, j, exec, hyprctl dispatch movewindow d
      bind = $mainMod SHIFT, k, exec, hyprctl dispatch movewindow u


        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow
        bindm = ALT, mouse:272, resizewindow
    '';
  };

  home.file.".config/hypr/colors".text = ''
    $background = rgba(1d192bee)
    $foreground = rgba(c3dde7ee)

    $color0 = rgba(1d192bee)
    $color1 = rgba(465EA7ee)
    $color2 = rgba(5A89B6ee)
    $color3 = rgba(6296CAee)
    $color4 = rgba(73B3D4ee)
    $color5 = rgba(7BC7DDee)
    $color6 = rgba(9CB4E3ee)
    $color7 = rgba(c3dde7ee)
    $color8 = rgba(889aa1ee)
    $color9 = rgba(465EA7ee)
    $color10 = rgba(5A89B6ee)
    $color11 = rgba(6296CAee)
    $color12 = rgba(73B3D4ee)
    $color13 = rgba(7BC7DDee)
    $color14 = rgba(9CB4E3ee)
    $color15 = rgba(c3dde7ee)
  '';
}
