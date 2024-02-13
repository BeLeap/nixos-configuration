{ pkgs, lib, ... }:
{
  system = {
    autoUpgrade = {
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
      packageOverrides = pkgs: {
        nur = import
          (builtins.fetchTarball {
            url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
          })
          { inherit pkgs; };
      };
    };
  };
  time.timeZone = "Asia/Seoul";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.beleap = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "video" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    sudo
    git
    pciutils
    docker
    glib
  ];

  programs.fish.enable = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "beleap" ];
  };

  security = {
    sudo = {
      wheelNeedsPassword = false;
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}

