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
  networking.hostName = "beleap-xps-9510";

  environment.systemPackages = with pkgs; [
    nvidia-docker
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  }; 
  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  virtualisation.docker = {
      enable = true;

      enableNvidia = true;
  };
}

