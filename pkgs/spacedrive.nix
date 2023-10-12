{ pkgs, ... }:
with pkgs;
appimageTools.wrapType2 {
  name = "spacedrive";
  src = fetchurl {
    url = "https://www.spacedrive.com/api/releases/desktop/stable/linux/x86_64";
    hash = "sha256-JQRMRgIaGLUCBX6Wtu953HO2SoZDrfLNkOlpPVOAyW8=";
  };
  extraPkgs = pkgs: with pkgs; [
    libthai
  ];
}

