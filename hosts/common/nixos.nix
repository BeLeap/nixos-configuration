{ pkgs, lib, ... }:
{
  networking =
    {
      networkmanager = {
        enable = true;
      };
    };
  virtualisation.docker.enable = true;

  sound.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    opengl.enable = true;
  };
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.swaylock = { };
  };


  systemd.services.tailscaled.wantedBy = lib.mkForce [ ];
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time --remember --cmd '${pkgs.hyprland}/bin/Hyprland'";
          vt = "next";
        };
      };
    };

    dbus.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      wlr = {
        enable = true;
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
      config = {
        common = {
          default = [ "hyprland" ];
        };
      };
    };
  };

  fonts.fontconfig = {
    enable = true;
  };

  boot = {
    initrd = {
      verbose = false;
      kernelModules = [ "pcspkr" ];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "breeze";
    };

    consoleLogLevel = 0;

    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
    ];
  };

  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
    _1password-gui.polkitPolicyOwners = [ "beleap" ];

    nix-ld.enable = true;

    kdeconnect = {
      enable = true;
      package = pkgs.valent;
    };
  };

  i18n.inputMethod = {
    enabled = "ibus";
    ibus = {
      engines = with pkgs.ibus-engines; [
        hangul
      ];
    };
  };
}
