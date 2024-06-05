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

    # screenshot
    grim
    swappy
    slurp

    # https://github.com/end-4/dots-hyprland
    axel
  ];

  programs.nm-applet.enable = true;
}
