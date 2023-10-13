{ config, pkgs, specialArgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      (import ../common/configuration.nix {
        inherit pkgs; 
        overlays = specialArgs.overlays;
        lib = pkgs.lib;
      })
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "23.05";
  networking.hostName = "beleap-thinkpad";
  
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
