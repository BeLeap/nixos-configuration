{ lib, pkgs, config, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
  ];

  environment.systemPackages = with pkgs; [
    git
    home-manager
    man-pages
    man-pages-posix
  ];

  users.users.beleap = {
    isNormalUser = true;
    home = "/home/beleap";
    extraGroups = [
      "wheel"
    ];
  };

  nix = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
  };
}
