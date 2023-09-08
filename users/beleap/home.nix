{ lib, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  home = {
    packages = with pkgs; [
      neovim-nightly
      openvpn
      vault
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
    ];

    stateVersion = "22.05";
  };

  programs = {
    bash = {
      enable = true;
      bashrcExtra = ''
        export EDITOR=nvim
        eval "$(direnv hook bash)"
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

    home-manager.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;

      withNodeJs = true;
      withRuby = true;
      withPython3 = true;
    };

    fish = {
      enable = true;

      interactiveShellInit = ''
         fish_vi_key_bindings
      '';

      shellAliases = {
        sofish = "source ~/.config/fish/config.fish";

        v = "nvim";
      };

      shellAbbrs = {
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

    zoxide = {
      enable = true;

      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    lsd = {
      enable = true;

      enableAliases = true;
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
  };
}
