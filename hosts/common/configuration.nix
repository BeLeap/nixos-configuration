{ pkgs, lib, overlays, hostname, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  system = {
    autoUpgrade = {
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };
  
  nixpkgs = {
    inherit overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "electron-25.9.0"
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
    extraGroups = [ "wheel" "docker" "networkmanager" "video" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };
  home-manager.users.beleap = import ../../users/beleap/home.nix {
    inherit pkgs lib hostname;
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

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    opengl.enable = true;
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = [ "root" "beleap" ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.swaylock = {};
  };


  systemd.services.tailscaled.wantedBy = lib.mkForce [];
  services = {
    tailscale.enable = true;
    
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd 'sway --unsupported-gpu'";
          vt = "next";
        };
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      wlr = {
        enable = true;
      };
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = ["*"];
        };
      };
    };
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
  
  fonts.fontconfig = {
    enable = true;
  };

  boot = {
    initrd.kernelModules = [ "pcspkr" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    plymouth = {
      enable = true;
      # themePackages = [
      #   pkgs.catppuccin-plymouth
      # ];
      theme = "breeze";
    };

    kernelParams = [
      "quiet"
      "splash"
    ];
  };

  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
    _1password-gui.polkitPolicyOwners = [ "beleap" ];

    nix-ld.enable = true;
  };
}

