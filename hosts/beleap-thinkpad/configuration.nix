{ config, pkgs, overlays, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      (import ../common/configuration.nix {
        inherit config pkgs overlays; 
        lib = pkgs.lib;
      })
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "23.05";
  networking.hostName = "beleap-thinkpad";
  
  nix.settings.experimental-features = ["nix-command" "flakes"];
}

