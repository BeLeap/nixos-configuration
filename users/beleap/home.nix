{ pkgs, lib, config, specialArgs, ... }:
let
  helpers = import ./helpers.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
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

  programs = {
    home-manager.enable = true;

    fish = (import ./config/fish);
    git = (import ./config/git);

    starship = (import ./config/starship){ inherit pkgs; };

    neovim = (import ./config/tui).neovim;
    zoxide = (import ./config/tui).zoxide;
    lsd = (import ./config/tui).lsd;
    direnv = (import ./config/tui).direnv;

    tmux = (import ./config/tui).tmux { inherit pkgs; };

    firefox = (import ./config/firefox) { inherit pkgs; };
    wezterm = {
      enable = true;
      package = (helpers.nixGLMesaWrap pkgs.wezterm);
      extraConfig = (import ./config/wezterm).extraConfig;
    };
    waybar = (import ./config/waybar);
  };
  services = {
    mako = (import ./config/mako);
  };
  wayland = {
    windowManager = {
      hyprland = (import ./config/hypr);
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
