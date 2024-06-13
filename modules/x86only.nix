{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.adb.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    android-studio 
    discord
  ];
}
