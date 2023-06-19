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
    shell = pkgs.nushell;
    extraGroups = [
      "wheel"
    ];
  };

  programs.nushell.enable = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
