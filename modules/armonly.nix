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
    ];

  programs.adb.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    armcord
  ];
}
