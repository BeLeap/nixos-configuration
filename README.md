# nixos-configuration

## Get Started

```sh
sudo nixos-rebuild switch --flake '.#wsl'

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
home-manager init --switch --flake '.#beleap'
```
