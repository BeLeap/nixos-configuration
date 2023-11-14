{ pkgs, lib, ... }:

with pkgs;
stdenv.mkDerivation rec {
  name = "Monaspace";
  version = "1.000";

  phases = [ "unpackPhase" "installPhase" ];

  src = (fetchurl {
    url = "https://raw.githubusercontent.com/githubnext/monaspace/main/fonts/variable/MonaspaceNeonVarVF[wght,wdth,slnt].ttf";
    name = "Monaspce.ttf";
    sha256 = "";
  });

  unpackPhase = ''
    cp $src .
  '';

  installPhase = ''
     install -Dm644 Monaspace.ttf $out/share/fonts/truetype/Monospace.ttf
  '';

  meta = with lib; {
    description = "Nanum Gothic Coding";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
