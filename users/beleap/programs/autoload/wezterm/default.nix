{ pkgs, lib, ... }:
let
  helpers = import ../../../helpers.nix {
    inherit
      pkgs
      lib;
  };
in
{
  enable = true;
  package = (helpers.nixGLWrap pkgs.wezterm);
  extraConfig = builtins.readFile(./. + "/config.lua");
}
