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
    nwg-look
    # gtk theme
    (catppuccin-gtk.override {
      accents = [ "flamingo" ]; # You can specify multiple accents here to output multiple themes
      size = "compact";
      tweaks = [ "rimless" "black" ]; # You can also specify multiple tweaks here
      variant = "mocha";
    })
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
