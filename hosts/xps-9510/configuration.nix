{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      (import ../common/configuration.nix { inherit config pkgs; })
    ];
    
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "23.05";

  nix.settings.experimental-features = ["nix-command" "flakes"];
}

