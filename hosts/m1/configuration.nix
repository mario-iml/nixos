{ config, lib, pkgs, ... }:

{
  imports =
    [       
      ./hardware-configuration.nix
      ./apple-silicon-support
      ../../modules/base.nix
    ];

  # rebuild alias
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos#m1 --impure";
  };

  # boot loader
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true; 

  # networking
  networking.hostName = "NixOsMarioM1";  
 
  # minimum nixos version on device install 
  system.stateVersion = "24.05"; 
}

