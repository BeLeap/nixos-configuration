{ config, options, lib, pkgs, dotfiles, ... }:

{
  xdg.configFile = {
    nvim.source = "${dotfiles}/nvim";
  };
}
