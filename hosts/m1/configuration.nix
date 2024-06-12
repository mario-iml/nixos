{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support
    ../../modules/base.nix
  ];

  # rebuild alias
  environment.shellAliases = {
    rebuild-command = "sudo nixos-rebuild switch --flake ~/nixos#m1 --impure";
    rebuild = "bash -i ~/nixos/nixos-rebuild.sh";
    update = "cd ~/nixos && nix flake update";
  };

  # setting WLR Graphic Card - needed for hyprland
  environment.sessionVariables = {
    WLR_DRM_DEVICES = "/dev/dri/card0";
  };

  # experimental GPU drivers - needed for hyperland
  hardware = {
    asahi = {
      # peripheralFirmwareDirectory = ./firmware;
      withRust = true;
      # addEdgeKernelConfig = true;
      useExperimentalGPUDriver = true;
      experimentalGPUInstallMode = "replace";
    };
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # packages
  environment.systemPackages = with pkgs; [
    mesa-asahi-edge
    xdg-desktop-portal-hyprland
  ];

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
