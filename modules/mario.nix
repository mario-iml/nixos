{ config, pkgs, ... }:

{
  home.username = "mario";
  home.homeDirectory = "/home/mario";

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      # { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
  };

  # environment.
  home.packages = [
    pkgs.firefox
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  home.sessionVariables = {
    # EDITOR = nvim;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # minimum version - compatibility
  home.stateVersion = "23.11"; 
}
