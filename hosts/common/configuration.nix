{ pkgs, lib, overlays, hostname, ... }:
{
  imports = [
    <home-manager/nixos>
  ];
  
  nixpkgs = {
    inherit overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "electron-24.8.6"
      ];
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball {
          url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
        }) { inherit pkgs; };
      };
    };
  };
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Asia/Seoul";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.beleap = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };
  home-manager.users.beleap = import ../../users/beleap/home.nix {
    inherit pkgs lib;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    sudo
    git
    pciutils
    docker
  ];
  virtualisation.docker.enable = true;

  programs.fish.enable = true;

  sound.enable = true;
  hardware.bluetooth.enable = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = [ "root" "beleap" ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.swaylock = {};
  };

  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
    };

    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'sway --unsupported-gpu'";
        };
      };
    };

    syncthing = 
    let
      deviceList = {
        "beleap-xps-9510" = { id = "ZKRXHYB-AD73BRK-E3QVAW7-EZ2ZYGY-RNGVUC3-BW6Y6GB-XNV2QM4-KIBOKAB"; };
        "beleap-thinkpad" = { id = "ODOR4CS-P4X7FGR-6MRFBH4-DT4O2LE-Q22OTUF-2A2Z7CA-PXVYMZD-WPTZDAY"; };
        "beleap-z-fold-4" = { id = "SY2FU6D-LRQURM2-EML4HUJ-KBPBPOH-3ENSLPL-2EKRZSU-7YSYCWH-VVBR6QX"; };
      };
      deviceListExceptSelf = (lib.attrsets.filterAttrs (n: v: n != hostname) deviceList);
      deviceNameListExceptSelf = (lib.attrsets.foldlAttrs (acc: k: _: acc ++ [k]) [] deviceListExceptSelf);
    in
    {
      enable = true;
      user = "beleap";
      dataDir = "/home/beleap/Documents";
      configDir = "/home/beleap/Documents/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = deviceListExceptSelf;    
        folders = {
          "Logseq" = {
            path = "/home/beleap/Documents/Logseq";
            devices = deviceNameListExceptSelf;
          };
        };
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
}

