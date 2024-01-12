{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib, ... }:
let
  isWork = hostname: builtins.any (x: x == hostname) [ "beleap-thinkpad" ];
  autoloader = { fn, initialVal, root }:
    let
      listing = lib.filesystem.listFilesRecursive root;
    in
    lib.lists.foldl fn initialVal listing;
in
{
  isWork = isWork;
  autoloader = autoloader;
}
