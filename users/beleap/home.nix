{ pkgs, lib, hostname, ... }:
let
  helpers = import ./helpers.nix { inherit pkgs lib; };
  username = "beleap";
in
{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      XDG_CURRENT_DESKTOP = "sway";
      EDITOR = "nvim --cmd 'let g:flatten_wait=1'";
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
    packages = lib.lists.flatten (lib.attrsets.attrValues ((import ./packages) { inherit pkgs lib; }));

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;

    waybar = (import ./gui/waybar/default.nix);
    wofi = (import ./gui/wofi/default.nix);
    swaylock = (import ./gui/swaylock.nix);
    firefox = (import ./gui/firefox/default.nix) { inherit helpers hostname; };
    wezterm = (import ./gui/wezterm/default.nix);

    carapace = (import ./tui/carapace.nix);
    fish = (import ./tui/fish.nix);
    git = (import ./tui/git.nix);
    starship = (import ./tui/starship/default.nix) { inherit lib; };
    k9s = (import ./tui/k9s.nix);
    neovim = (import ./tui/neovim.nix) { inherit pkgs; };
    direnv = (import ./tui/direnv.nix);
    lsd = (import ./tui/lsd.nix);
    zoxide = (import ./tui/zoxide.nix);
    tmux = (import ./tui/tmux.nix) { inherit pkgs; };
  };

  services = {
    dunst = (import ./gui/dunst.nix) { inherit pkgs; };
    kanshi = (import ./gui/kanshi.nix);
    blueman-applet = { enable = true; };
    mpd = { enable = true; };
    keybase = { enable = true; };
    kbfs = { enable = true; };
  };

  wayland = {
    windowManager = {
      sway = (import ./gui/sway.nix) { inherit pkgs lib helpers hostname; };
    };
  };

  i18n = {
    inputMethod = {
      enabled = "kime";
      kime.config = {
        indicator.icon_color = "White";
        engine = {
          latin = {
            layout = "Colemak";
          };
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
        exec = "firefox %U -P personal --name firefox-personal";
        terminal = false;
      };
      firefox-work = {
        name = "Firefox (Work)";
        exec = "firefox %U -P work --name firefox-work";
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
      lock = {
        name = "Lock";
        exec = "swaylock";
        terminal = false;
      };
    };
  };

  home = {
    file = lib.trivial.mergeAttrs { } (
      let
        autoloadRoot = ./. + "/files";
      in
      helpers.autoloader {
        fn = (
          acc: curr:
            let
              currRelative = lib.path.removePrefix autoloadRoot (/. + curr);
            in
            lib.trivial.mergeAttrs { "${currRelative}".source = curr; } acc
        );
        initialVal = { };
        root = autoloadRoot;
      }
    );
  };
}
