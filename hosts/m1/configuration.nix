{ config, lib, pkgs, ... }:

{
  imports =
    [       
      ./hardware-configuration.nix
      ./apple-silicon-support
    ];

  # rebuild alias
  environment.shellAliases {
    rebuild="sudo nixos-rebuild switch --flake ~/nixos#m1 --impure";
  };

  # boot loader
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true; 

  # networking
  networking.hostName = "NixOsMarioM1";  
  networking.networkmanager.enable = true; 

  # wifi
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  # time zone.
  time.timeZone = "Europe/Dublin";

  # X11 and gnome
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
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

  # mario user
  users.users.mario = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # packages
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    firefox
  ];
 
  # minimum nixos version on device install 
  system.stateVersion = "24.05"; 
}

