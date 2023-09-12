{ lib, pkgs, ... }:

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
  };
  xdg.desktopEntries = {
    firefox = {
      name = "Firefox";
      genericName = "Web Browser";
      exec = "firefox %U";
      terminal = false;
      categories = [ "Application" "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" ];
    };
  };
}
