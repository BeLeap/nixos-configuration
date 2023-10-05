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

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}

