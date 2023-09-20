{ pkgs, lib, ... }:
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
        };
      };
    };
  };
  home = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      EDITOR = "nvim";
    };
    packages = lib.lists.flatten (lib.attrsets.attrValues ((import ./packages){ inherit pkgs; })) ;

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
  };
 
  wayland = {
    windowManager = {
      sway = (import ./config/sway) { inherit pkgs lib; };
    };
  };
 
  i18n = {
    inputMethod = {
      enabled = "kime";
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
    };

    configFile = {
      "nvim" = {
        source = ./config/nvim;
        recursive = true;
      };
    };
  };

  home = {
    file = lib.trivial.mergeAttrs {} (
      (
        (import ./helpers.nix) { inherit pkgs lib; }
      ).files
    );
  };
}
