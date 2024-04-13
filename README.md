# Installation
- install nixos on device:
  - install git
  - create mario user and set password
  - think of networking configuration
  - enable ssh service to access easier if neccesarry
- ```su mario```
- git clone nixos into ~/ - add ssh key to github (ssh-keygen)
- ```sudo nixos-rebuild switch --flake ~/nixos#<host> (--impure for asahi)``` <host> for example m1
- git clone dotiles into ~/
- ```cd ~/dotfiles/```
- ```stow . --adopt```

# FAQ
- I get database not found error when running into command-not-found in fish:
  - ```sudo nix-channel --update```
