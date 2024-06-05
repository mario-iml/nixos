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

    linphone
    vscode
    libreoffice
    thunderbird

    armcord
    vesktop # needed for discord streaming
    pipewire # needed for streaming
    wireplumber # needed for streaming

    brightnessctl
    networkmanager-openvpn

    # gtk theme
    (catppuccin-gtk.override {
      accents = ["flamingo"]; # You can specify multiple accents here to output multiple themes
      size = "compact";
      tweaks = ["rimless" "black"]; # You can also specify multiple tweaks here
      variant = "mocha";
    })
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # minimum version - compatibility
  home.stateVersion = "23.11";
}
