{ config, pkgs, lib, ... }:

{
  home.username = "mario";
  home.homeDirectory = "/home/mario";

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      # { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
  };

  # environment.
  home.packages = with pkgs; [
    firefox
    chromium
    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    kitty
    wofi
    waybar
    neofetch
    pulseaudio
    mako # notifications
    pavucontrol
    armcord
    vesktop # needed for discord streaming
  ];

  # armcord desktop file - fix blurry window in wayland
  xdg.desktopEntries.armcord = {
    name = "Armcord";
    genericName = "Armcord";
    exec = "armcord --enable-features=UseOzonePlatform --ozone-platform=wayland";
  };

  home.sessionVariables = {
    # EDITOR = nvim;
    # chromium pixelated fix
    NIXOS_OZONE_WL = "1"; # - set in chrome://flags
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # minimum version - compatibility
  home.stateVersion = "23.11"; 
}
