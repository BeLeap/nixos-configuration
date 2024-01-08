{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib, ... }:
let
  # nixGLWrap = pkg:
  #   pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
  #     mkdir $out
  #     ln -s ${pkg}/* $out
  #     rm $out/bin
  #     mkdir $out/bin
  #     for bin in ${pkg}/bin/*; do
  #      wrapped_bin=$out/bin/$(basename $bin)
  #      echo "${lib.getExe' pkgs.nixgl.auto.nixGLDefault "nixGL"} $bin \$@" > $wrapped_bin
  #      chmod +x $wrapped_bin
  #     done
  #   '';
  #
  # nixGLIntelWrap = pkg:
  #   pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
  #     mkdir $out
  #     ln -s ${pkg}/* $out
  #     rm $out/bin
  #     mkdir $out/bin
  #     for bin in ${pkg}/bin/*; do
  #      wrapped_bin=$out/bin/$(basename $bin)
  #      echo "${lib.getExe pkgs.nixgl.nixGLIntel} $bin \$@" > $wrapped_bin
  #      chmod +x $wrapped_bin
  #     done
  #   '';

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
