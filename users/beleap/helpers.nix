{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib, ... }:
let
  autoloader = { fn, initialVal, root }:
    let
      listing = lib.filesystem.listFilesRecursive root;
    in
    lib.lists.foldl fn initialVal listing;
in
{
  # nixGLWrap = nixGLWrap;
  # nixGLIntelWrap = nixGLIntelWrap;
  autoloader = autoloader;
}
