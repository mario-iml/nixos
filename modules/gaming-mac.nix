{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  # packages
  environment.systemPackages = with pkgs; [
    box64
  ];
}

