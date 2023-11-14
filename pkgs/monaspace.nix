{ pkgs, lib, ... }:

with pkgs;
stdenv.mkDerivation rec {
  name = "Monaspace";
  version = "1.000";

  phases = [ "installPhase" ];

  src = (fetchurl {
    url = "https://github.com/githubnext/monaspace/raw/main/fonts/variable/MonaspaceNeonVarVF%5Bwght,wdth,slnt%5D.ttf";
    name = "Monaspce.ttf";
    hash = "sha256-jXoi38+3d6MmQU9uQocTdBUiVcLNBJWpxtm2YT1/Da8=";
  });

  installPhase = ''
     install -Dm644 $src $out/share/fonts/truetype/Monaspace.ttf
  '';

  meta = with lib; {
    description = "Monaspace";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
