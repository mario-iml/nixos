{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "mario";
  home.homeDirectory = "/home/mario";

  # allow specific unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "vscode"
      "vivaldi"
    ];

  # environment.
  home.packages = with pkgs; [
    firefox
    chromium
    vivaldi
    (nerdfonts.override {fonts = ["FantasqueSansMono"];})
    armcord
    vesktop # needed for discord streaming
    pipewire # needed for streaming
    wireplumber # needed for streaming
    linphone
    nwg-look
    networkmanager-openvpn
    vscode
    libreoffice
    thunderbird
    brightnessctl


    # gtk theme
    (catppuccin-gtk.override {
      accents = ["flamingo"]; # You can specify multiple accents here to output multiple themes
      size = "compact";
      tweaks = ["rimless" "black"]; # You can also specify multiple tweaks here
      variant = "mocha";
    })
  ];

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
