{ lib, pkgs, config, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
  ];

  system.stateVersion = "22.05";

  wsl = {
    enable = true;
    defaultUser = "beleap";
    startMenuLaunchers = true;
    nativeSystemd = true;
    docker-native = {
      enable = true;
      addToDockerGroup = true;
    };

    wslConf = {
      automount.root = "/mnt";
    };
  };

  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
  };
  
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

    shell = pkgs.fish;
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
