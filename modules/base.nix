{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hyprland.nix
  ];

  # nix experimental features/options
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # enable network manager
  networking.networkmanager.enable = true;

  # wifi
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  # time zone.
  time.timeZone = "Europe/Berlin";

  # Display manager
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  # keyboard layout
  console = {
    useXkbConfig = true;
  };
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "altgr-intl";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

  # aliases
  environment.shellAliases = {
    vim = "nvim";
  };

  # packages
  environment.systemPackages = with pkgs; [
    wget
    git
    stow
    gcc
    psmisc
    htop
    btop
    unzip
    apfs-fuse
    alejandra

    # eduroam
    openssl

    alacritty
    neofetch
    pulseaudio
    fzf
    remmina
    keepassxc
    pinta
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  virtualisation.docker.enable = true;

  # mario user
  users.users.mario = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker" "video" "input"];
  };

  # home-manager for user
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "mario" = import ./mario.nix;
    };
  };

  # shell
  programs.zsh.enable = true;
  users.users.mario.shell = pkgs.zsh;

  # firewall
  networking.firewall = {
    enable = false;
    #allowedTCPPorts = [ 80 443 ];
    #allowedUDPPortRanges = [
    #  { from = 4000; to = 4007; }
    #  { from = 8000; to = 8010; }
    #];
  };
}
