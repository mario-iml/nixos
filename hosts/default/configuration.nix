{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # boot loader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  # networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Dublin";

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  console = {
    useXkbConfig = true;
  };
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "altgr-intl";

  # display manager
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;

  # install packages
  environment.systemPackages = with pkgs; [
    wget
    git
    kitty
    # nvim dependencies
    gcc
    # waybar
    (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
  ];


  # desktop
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];


  # sound
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  programs.fish.enable = true;

  # rebuild alias
  programs.fish.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles-nixos/nixos/#default";
  };

  # default editor
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # enable services
  services.openssh.enable = true;

  # creating user
  users.users.mario = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  # home-manager for user
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "mario" = import ./home.nix;
    };
  };

  # firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  # first installed version - compatibility
  system.stateVersion = "23.11";

}

