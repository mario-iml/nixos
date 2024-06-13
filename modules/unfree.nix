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
      "vscode"
      "vivaldi"
      "android-studio-stable"
      "discord"
    ];
}
