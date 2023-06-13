{ lib, pkgs, config, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
  ];

  users.users.beleap = {
    isNormalUser = true;
    home = "/home/beleap";
    extraGroups = [
      "wheel"
    ];
  };

  system.stateVersion = "22.05";
}
