{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: { 
  # desktop
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = rec {
    XDG_CURRENT_DESKTOP = "hyprland";
  };

  environment.systemPackages = with pkgs; [ 
    xdg-desktop-portal
    xdg-desktop-portal-gtk

    wofi
    waybar
    hyprpaper
    hyprpicker
    hyprlock
    hypridle
    swaynotificationcenter # notifications
    libnotify
    pavucontrol
    networkmanagerapplet
    blueman
    nwg-look
    hyprland-workspaces

    # screenshot
    grim
    swappy
    slurp
    wl-clipboard

    # widgets/bar
    eww
  ];

  programs.nm-applet.enable = true;
}
