{ pkgs }:

{
  monitorSwitch = pkgs.writeScriptBin "monitorSwitch" ''
    #!/usr/bin/env bash

    laptop="eDP-1"
    monitor="HDMI-A-1"


    # Check if HDMI-A-1 is connected using hyprctl
    if hyprctl monitors | grep -q "HDMI-A-1"; then
        # HDMI-A-1 is connected, enable it and disable eDP-1

        hyprctl keyword monitor $laptop,disable
        hyprctl keyword monitor $monitor,preferred,auto,1.5
        hyprctl dispatch moveworkspacetomonitor monitor,HDMI-A-1 # Move all workspaces to HDMI-A-1
    else
        # HDMI-A-1 is not connected, enable eDP-1 and disable HDMI-A-1
        hyprctl keyword monitor $monitor,disable
        hyprctl keyword monitor $laptop,preferred,auto,1.2
        hyprctl dispatch moveworkspacetomonitor monitor,eDP-1 # Move all workspaces to eDP-1
    fi
  '';
}
