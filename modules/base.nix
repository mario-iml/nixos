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
    ./unfree.nix
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

  environment = {
    sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
  };

  # ensure /bin/bash is found
  #system.activationScripts.binbash = {
  #  deps = [ "binsh" ];
  #  text = ''
  #       ln -s /bin/sh /bin/bash
  #  '';
  #};

  # packages
  environment.systemPackages = with pkgs; [
    calc
    wget
    git
    gh
    stow
    gcc
    psmisc
    htop
    btop
    unzip
    apfs-fuse
    alejandra
    jq

    cargo
    rustup
    dioxus-cli

    nodejs_22

    (python3.withPackages (subpkgs: with subpkgs; [
        pip
        pygobject3
      ]))

    # eduroam
    openssl

    # nordvpn
    wgnord

    alacritty
    neofetch
    pulseaudio
    fzf
    remmina
    keepassxc
    pinta

    firefox
    chromium
    vivaldi
 
    linphone
    vscode
    zed-editor
    libreoffice
    thunderbird

    networkmanager-openvpn

    vesktop # needed for discord streaming
    pipewire # needed for streaming
    wireplumber # needed for streaming
  ];

  # openvpn resolv conf fix
  environment.etc."openvpn/update-resolv-conf".source = "${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  virtualisation.docker.enable = true;

  # mario user
  users.users.mario = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker" "video" "input" "kvm" "adbusers"];
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
