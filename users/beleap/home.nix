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
    };
    packages = with pkgs; [
      neovim-nightly
      openvpn
      vault-bin
      postgresql_15
      mongosh
      nix-prefetch-git

      universal-ctags
      nodejs
      yarn
      go
      rustup
      evcxr
      deno
      ghc
      haskell-language-server
      python3
      zig
      tree-sitter
      jupyter

      croc
      ntp
      mtr
      tshark
      dig
      openssl
      ipcalc
      tcpdump
      istioctl
      ngrok
      pueue

      azure-cli
      saml2aws
      awscli2
      terraform

      kubernetes-helm
      kubectl
      kubectx
      kubectl-node-shell

      hexyl
      sshpass
      gnumake
      stow
      man
      irssi
      bottom
      tealdeer
      fzf
      gdb
      file
      yq
      lsd
      fd
      ripgrep
      bat
      difftastic
      unzip
      gitAndTools.gh

      anytype
    ];

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;

    bash = {
      enable = true;
      bashrcExtra = ''
        export EDITOR=nvim
      '';
    };

    git = {
      enable = true;

      userName = "BeLeap";
      userEmail = "beleap@beleap.dev";

      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
        user.signingKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNrBVLG52+DGp9mHdt5H45alxWVCLu5JsodOPryPar5R620vqryWONGsE9FI8EeFRiBvIvNhhvYlbTzaSYU46koVRAUcjFUH3Wd3NW15sY4UiC9RYVMMtc0IpghSTa0cPH06XvU0d8cftySfarsT6rlJPLDpOKKn0yrbfI3ErncLpIWyBIYELkzJ3azeb4J8L2KoO+l4Ce4QR7E1eyqRXOPT81ZwK19mTW/F+H+UAlcQrv5uUh3NZclmahE3Vwc23VWORwmBvHnhcZSOb/M79lk45WVUFZYPBqSPxihNd9Cpcq7TgKczS1liiO2S2NIJ73wG/UviuR52fOqBagJBlL";
        gpg.format = "ssh";
        gpg.ssh.program = "/opt/1Password/op-ssh-sign";
        commit.gpgsign = true;
      };

      difftastic = {
        enable = true;
      };

      ignores = [
        "*.null_ls*"
        "root.md"
        "run.fish"
        "shell.nix"
        ".envrc"
        ".direnv"
        "run.nu"
      ];

      aliases = {
        gone = "! git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '\$2 == \"[gone]\" {print \$1}' | xargs -r git branch -D";
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;

      withNodeJs = true;
      withRuby = true;
      withPython3 = true;
    };

    zoxide = {
      enable = true;

      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;

      settings = import ./config/starship {
        inherit pkgs;
      };
    };

    direnv = {
      enable = true;

      nix-direnv = {
        enable = true;
      };

      enableNushellIntegration = true;
    };

    tmux = {
      enable = true;
      clock24 = true;
      shortcut = "a";
      keyMode = "vi";

      extraConfig = ''
        set -g base-index 1
        set-option -g default-terminal "screen-256color"
        set-option -sa terminal-features ',XXX:RGB'
      '';

      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_window_tabs_enabled on
          '';
        }
      ];
    };

    nushell =
    let
      nushell_conf = (import ./config/nushell);
    in
    {
      enable = true;

      extraConfig = lib.strings.concatStrings(
        [
          ''
            $env.config = {
              show_banner: false,
              edit_mode: vi,
            }
          ''
          nushell_conf.git
          nushell_conf.kubectl
        ]
      );

      extraEnv = ''
        $env.EDITOR = 'nvim'
        $env.PATH = ($env.PATH | split row (char esep) | append '/home/beleap/.nix-profile/bin' | append '/home/beleap/.local/bin')
      '';

      shellAliases = {
        v = "nvim";

        gst = "git status";
        gsw = "git switch";
        gd = "git diff";
        ga = "git add";
        gc = "git commit -v";
        gp = "git push";
        gf = "git fetch --prune --all";
        gl = "git pull";

        k = "kubectl";
        ktx = "kubectx";
        tf = "terraform";
      };
    };

    firefox = {
      enable = true;

      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          CaptivePortal = false;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisableFirefoxAccounts = false;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          OfferToSaveLoginsDefault = false;
          PasswordManagerEnabled = false;
          FirefoxHome = {
            Search = true;
            Pocket = false;
            Snippets = false;
            TopSites = false;
            Highlights = false;
          };
          UserMessaging = {
            ExtensionRecommendations = false;
            SkipOnboarding = true;
          };
        };
        cfg = {
          enableGnomeExtensions = true;
          enableTridactylNative = true;
        };
      };
 

      profiles = 
      let
        common = {
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.aboutConfig.showWarning" = false;
          };
          userChrome = ''
            #main-window #titlebar {
              overflow: hidden;
              transition: height 0.3s 0.3s !important;
            }
            /* Default state: Set initial height to enable animation */
            #main-window #titlebar { height: 3em !important; }
            #main-window[uidensity="touch"] #titlebar { height: 3.35em !important; }
            #main-window[uidensity="compact"] #titlebar { height: 2.7em !important; }
            /* Hidden state: Hide native tabs strip */
            #main-window[titlepreface*="[Sidebery]"] #titlebar { height: 0 !important; }
            /* Hidden state: Fix z-index of active pinned tabs */
            #main-window[titlepreface*="[Sidebery]"] #tabbrowser-tabs { z-index: 0 !important; }
          '';
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            profile-switcher
            onepassword-password-manager
            tridactyl
            refined-github
            sidebery
            i-dont-care-about-cookies
            auto-tab-discard
          ];
          search = {
            force = true;
            default = "Phind";
            engines = {
              "Phind" = {
                urls = [{ template = "https://www.phind.com/search?q={searchTerms}"; }];
                iconUpdateURL = "https://www.phind.com/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
              };
            };
          };
        };
      in
      {
        personal = {
          id = 0;
          name = "personal";

          settings = common.settings;
          userChrome = common.userChrome;
          extensions = common.extensions;
          search = common.search;
          isDefault = true;

          bookmarks = [];
        };
        work = {
          id = 1;
          name = "work";

          settings = common.settings;
          userChrome = common.userChrome;
          extensions = common.extensions;
          search = common.search;

          bookmarks = [
            {
              name = "Shortcut";
              toolbar = true;
              bookmarks = [
                {
                  name = "Terraform | AWS";
                  url = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs";
                  keyword = "tfaws";
                }
              ];
            }
          ];
        };
      };
    };
  };
}
