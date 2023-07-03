{ lib, pkgs, config, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
  ];

  environment.systemPackages = with pkgs; [
    gcc9
    git
    openssh
    home-manager
    man-pages
    man-pages-posix
  ];

  users.users.beleap = {
    isNormalUser = true;

    shell = pkgs.zsh;
    home = "/home/beleap";
    extraGroups = [
      "wheel"
    ];
  };
  programs.fish.enable = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };
}
