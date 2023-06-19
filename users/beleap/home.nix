{ lib, pkgs, ... }:

{
  home = {
    packages = lib.attrValues {
      inherit (pkgs)
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
      };
    };

    home-manager.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;
    };
  };
}
