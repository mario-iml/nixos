{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
  ];

  # rebuild alias
  environment.shellAliases = {
    rebuild-command = "sudo nixos-rebuild switch --flake ~/nixos#pc";
    rebuild = "bash -i ~/nixos/nixos-rebuild.sh";
  };

  # boot loader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

  # nvidia stuff
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # networking
  networking.hostName = "Mario-Linux-PC";

  # minimum nixos version on device install
  system.stateVersion = "24.05";
}
