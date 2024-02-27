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
    enabled = "kime";
    kime = {
      daemonModules = [
        "Xim"
        "Wayland"
        "Indicator"
      ];
      iconColor = "White";
      extraConfig = ''
        log:
          global_level: DEBUG
        engine:
          translation_layer: null
          default_category: Latin
          global_category_state: false
          global_hotkeys:
            M-C-Backslash:
              behavior: !Mode Math
              result: ConsumeIfProcessed
            Super-Space:
              behavior: !Toggle
              - Hangul
              - Latin
              result: Consume
            M-C-E:
              behavior: !Mode Emoji
              result: ConsumeIfProcessed
            Esc:
              behavior: !Switch Latin
              result: Bypass
            Muhenkan:
              behavior: !Toggle
              - Hangul
              - Latin
              result: Consume
            AltR:
              behavior: !Toggle
              - Hangul
              - Latin
              result: Consume
            Hangul:
              behavior: !Toggle
              - Hangul
              - Latin
              result: Consume
          category_hotkeys:
            Hangul:
              ControlR:
                behavior: !Mode Hanja
                result: Consume
              HangulHanja:
                behavior: !Mode Hanja
                result: Consume
              F9:
                behavior: !Mode Hanja
                result: ConsumeIfProcessed
          mode_hotkeys:
            Math:
              Enter:
                behavior: Commit
                result: ConsumeIfProcessed
              Tab:
                behavior: Commit
                result: ConsumeIfProcessed
            Hanja:
              Enter:
                behavior: Commit
                result: ConsumeIfProcessed
              Tab:
                behavior: Commit
                result: ConsumeIfProcessed
            Emoji:
              Enter:
                behavior: Commit
                result: ConsumeIfProcessed
              Tab:
                behavior: Commit
                result: ConsumeIfProcessed
          candidate_font: Noto Sans CJK KR
          xim_preedit_font:
          - Noto Sans CJK KR
          - 15.0
          latin:
            layout: Colemak
            preferred_direct: true
          hangul:
            layout: sebeolsik-3-90
            word_commit: false
            preedit_johab: Needed
            addons:
              all:
              - ComposeChoseongSsang
              dubeolsik:
              - TreatJongseongAsChoseong
              sebeolsik-3-90:
              - FlexibleComposOrder
              - ComposeChoseongSsang
              - ComposeJongseongSsang
      '';
    };
  };
}
