{ pkgs, specialArgs, ... }:
rec {
  imports =
    [
      ./hardware-configuration.nix
      (import ../common/configuration.nix {
        inherit pkgs; 
        overlays = specialArgs.overlays;
        lib = pkgs.lib;
        hostname = networking.hostName;
      })
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "23.05";
  networking.hostName = "beleap-thinkpad";
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    } 
  ];
  
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
