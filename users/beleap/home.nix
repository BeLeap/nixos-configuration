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

      aliases."dft" = "difftool";

      extraConfig = {
        diff.tool = "difftastic";
        difftool.prompt = false;
        difftool."difftastic".cmd = ''${lib.getExe pkgs.difftastic} "$LOCAL" "$REMOTE"'';
        pager.difftool = true;

        push.autoSetupRemote = true;
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
  };

  xdg.configFile = {
    nvim.source = "${dotfiles}/nvim/.config/nvim";
  };
}
