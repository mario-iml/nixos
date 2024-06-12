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
    rebuild-command = "sudo nixos-rebuild switch --flake ~/nixos#worknb";
    rebuild = "bash -i ~/nixos/nixos-rebuild.sh";
    update = "cd ~/nixos && nix flake update";
  };

  # boot loader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

  # networking
  networking.hostName = "GNB-060";

  # minimum nixos version on device install
  system.stateVersion = "24.05";
}
