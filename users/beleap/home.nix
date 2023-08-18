{ lib, pkgs, dotfiles, ... }:

{
  home = {
    packages = with pkgs; [
      neovim-nightly
      openvpn
      vault
      postgresql_15
      mongosh
      nix-prefetch-git

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
      # ngrok

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
    sessionVariables = {
      SHELL = "fish";
    };
  };

  programs = {
    git = {
      enable = true;

      userName = "BeLeap";
      userEmail = "beleap@beleap.dev";

      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
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
    };

    lsd = {
      enable = true;

      enableAliases = true;
    };

    starship = {
      enable = true;

      settings = import ./config/starship.nix {
        inherit pkgs;
      };
    };

    direnv = {
      enable = true;

      nix-direnv = {
        enable = true;
      };
    };

    tmux = {
      enable = true;
      clock24 = true;
      shortcut = "a";
      keyMode = "vi";

      extraConfig = ''
        set -g base-index 1
        set-option -sg escape-time 10
        set-option -g default-terminal "screen-256color"
        set-option -sa terminal-features ',XXX:RGB'
      '';

      plugins = with pkgs.tmuxPlugins; [
        catppuccin
      ];
    };
  };

  xdg.configFile."tmux/tmux.conf".text = lib.mkOrder 600 ''
  set -g @catppuccin_window_tabs_enabled on
  '';
}
