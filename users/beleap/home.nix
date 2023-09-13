{ pkgs, ... }:

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

    starship = {
      enable = true;

      settings = (import ./config/starship){ inherit pkgs; };
    };

    neovim = (import ./config/tui).neovim;
    zoxide = (import ./config/tui).zoxide;
    lsd = (import ./config/tui).lsd;
    direnv = (import ./config/tui).direnv;

    tmux = (import ./config/tui).tmux { inherit pkgs; };

    firefox = (import ./config/firefox) { inherit pkgs; };
    waybar = (import ./config/waybar);
  };
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;

        enableNvidiaPatches = true;
        systemdIntegration = true;

        extraConfig = (import ./config/hypr).config;
      };
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
