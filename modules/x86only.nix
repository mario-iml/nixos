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
    ];

  # packages
  environment.systemPackages = with pkgs; [
    android-studio 
  ];
}
