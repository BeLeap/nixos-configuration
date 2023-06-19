{ lib, pkgs, dotfiles, ... }:

{
  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        neovim-nightly

        nodejs
        go
        cargo

        azure-cli

        lsd
        fd
        ripgrep
        bat
        difftastic;

      inherit (pkgs.gitAndTools) gh;
    };

    stateVersion = "22.05";
  };

  programs = {
    git = {
      enable = true;

      userName = "BeLeap";
      userEmail = "beleap@beleap.dev";

      extraConfig = {
        push.autoSetupRemote = true;
      };

      difftastic = {
        enable = true;
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
        gd = "git dft";
        ga = "git add";
        gc = "git commit -v";
        gp = "git push";
        gf = "git fetch --prune --all";
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

      settings = import ./config/starship.nix;
    };

    direnv = {
      enable = true;

      nix-direnv = {
        enable = true;
      };
    };
  };

  xdg.configFile = {
    nvim.source = "${dotfiles}/nvim/.config/nvim";
  };
}
