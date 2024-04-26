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

  /*# use x86_64 steam and allow unfree license
  nixpkgs.overlays = [(self: super: let
    x86pkgs = import pkgs.path { system = "x86_64-linux";
      config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-runtime"
        "steam-run"
      ];
    };
  in {
    inherit (x86pkgs) steam steam-run;
  })];

  # allow build for x86_64-linux architecture through emulation
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];*/

  # packages
  environment.systemPackages = with pkgs; [
    box64
    #steam
    #steam-run
  ];
}

