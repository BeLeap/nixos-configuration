{ pkgs, lib, ... }:
let
  helpers = import ./helpers.nix { inherit pkgs lib; };
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball {
          url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
        }) {
          inherit pkgs;
          repoOverrides = {
            rycee = import (builtins.fetchTarball "https://gitlab.com/BeLeap/nur-expressions/-/archive/firefox-addons/add-pwas-for-firefox/nur-expressions-firefox-addons-add-pwas-for-firefox.tar.gz") { inherit pkgs; };
          };
        };
      };
    };
  };
  home = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      XDG_CURRENT_DESKTOP = "sway"; 
      EDITOR = "nvim";
    };
    packages = lib.lists.flatten (lib.attrsets.attrValues ((import ./packages){ inherit pkgs lib; })) ;

    stateVersion = "22.05";
  };

  programs = lib.trivial.mergeAttrs {
    home-manager.enable = true;

    waybar = (import ./config/sway/waybar);
    wofi = (import ./config/sway/wofi);
    swaylock = (import ./config/sway/swaylock);
  } ((import ./programs) { inherit pkgs lib; });

  services = {
    mako = (import ./config/sway/mako);
    kanshi = (import ./config/sway/kanshi);
    kdeconnect = { enable = true; indicator = true; };
    blueman-applet = { enable = true; };
  };

  wayland = {
    windowManager = {
      sway = (import ./config/sway) { inherit pkgs lib; };
    };
  };

  i18n = {
    inputMethod = {
      enabled = "kime";
      kime.config = {
        indicator.icon_color = "White";
        engine = {
          hangul = {
            layout = "sebeolsik-3-90";
            addons = {
              "sebeolsik-3-90" = [
                "FlexibleComposeOrder"
                "ComposeChoseongSsang"
                "ComposeJongseongSsang"
              ];
            };
          };
        };
      };
    };
  };

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;

    systemDirs = {
      data = [
        "/usr/share"
        "/usr/local/share"
        "/home/beleap/.nix-profile/share"
      ];
      config = [
        "/etc/xdg"
        "/home/beleap/.nix-profile/etc/xdg"
      ];
    };
    desktopEntries = {
      firefox = {
        name = "Firefox";
        exec = "firefox %U";
        terminal = false;
      };
      firefox-work = {
        name = "Firefox (Work)";
        exec = "firefox %U -P work";
        terminal = false;
      };
      reboot = {
        name = "Reboot";
        exec = "reboot";
        terminal = false;
      };
      shutdown = {
        name = "Shutdown";
        exec = "shutdown -h now";
        terminal = false;
      };
      exit = {
        name = "Exit";
        exec = "swaymsg exit";
        terminal = false;
      };
      lock = {
        name = "Lock";
        exec = "swaylock";
        terminal = false;
      };
      vlc = {
        name = "VLC Music";
        exec = "vlc -LZ /home/beleap/Music";
        terminal = false;
      };
    };
  };

  home = {
    file = lib.trivial.mergeAttrs {} (
      let
        autoloadRoot = ./. + "/files";
      in
      helpers.autoloader {
        fn = (
          acc: curr:
          let
            currRelative = lib.path.removePrefix autoloadRoot (/. + curr);
          in
          lib.trivial.mergeAttrs { "${currRelative}".text = builtins.readFile(curr); } acc
        );
        initialVal = {};
        root = autoloadRoot;
      }
    );
  };
}
