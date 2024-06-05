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
  ];

  programs.nm-applet.enable = true;

  home.sessionVariables = {
    # EDITOR = nvim;
    # chromium pixelated fix
    NIXOS_OZONE_WL = "1"; # - set in chrome://flags
  };

  # armcord desktop file - fix blurry window in wayland
  xdg.desktopEntries.armcord = {
    name = "Armcord";
    genericName = "Armcord";
    exec = "armcord --enable-features=UseOzonePlatform --ozone-platform=wayland";
  };

  # vs code desktop file - fix blurry window in wayland
  xdg.desktopEntries.code = {
    name = "Visual Studio Code";
    genericName = "Code Editor";
    exec = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
  };

  # vivaldi desktop file - fix blurry window in wayland
  xdg.desktopEntries.vivaldi = {
    name = "Vivaldi";
    genericName = "Browser";
    exec = "vivaldi --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-seccomp-filter-sandbox --user-agent=\"Chrome/110.0.0.0\"";
  };
}
