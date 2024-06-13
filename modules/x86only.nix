{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # allow specific unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "android-studio-stable"
      "discord"
    ];

  programs.adb.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    android-studio 
    discord
  ];
}
