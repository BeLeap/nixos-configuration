{ pkgs, lib, config, specialArgs, ... }:
let
  helpers = import ./helpers.nix {
    inherit
      pkgs
      lib
      config
      specialArgs;
  };
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
        };
      };
    };
  };
  home = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      EDITOR = "nvim";
    };
    packages = ((import ./packages){ inherit pkgs; }).packages ;

    stateVersion = "22.05";
  };

  programs = lib.trivial.mergeAttrs {
    home-manager.enable = true;

    wezterm = {
      enable = true;
      package = (helpers.nixGLMesaWrap pkgs.wezterm);
      extraConfig = (import ./config/wezterm).extraConfig;
    };
    waybar = (import ./config/sway/waybar);
  } ((import ./programs) { inherit pkgs; });
  services = {
    mako = (import ./config/sway/mako);
    kanshi = (import ./config/sway/kanshi);
    kdeconnect = { enable = true; indicator = true; };
  };
  wayland = {
    windowManager = {
      sway = lib.trivial.mergeAttrs {
        enable = true;
        package = (helpers.nixGLMesaWrap pkgs.sway);
      } (import ./config/sway);
    };
  };
  i18n = {
    inputMethod = {
      enabled = "kime";
    };
  };
  xdg = {
    enable = true;
 
    systemDirs = {
      data = [
        "/usr/share"
        "/usr/local/share"
        "/home/beleap/.nix-profile/share"
      ];
    };
    desktopEntries = {
      reboot = {
        name = "Reboot";
        exec = "reboot";
        terminal = false;
      };
    };
  };
}
