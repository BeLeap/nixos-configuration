{ pkgs, ... }:
with pkgs;
{
  native = stdenv.mkDerivation rec {
    name = "pwas-for-firefox";
    version = "2.8.0";

    nativeBuildInputs = [
      glibc
      dpkg
    ];
    
    phases = [ "unpackPhase" "installPhase" ];

    src = fetchurl {
      url = "https://github.com/filips123/PWAsForFirefox/releases/download/v${version}/firefoxpwa_${version}_amd64.deb";
      sha256 = "dccc7e23f44ccd43f808a8e165b0d4041f8e3530f115a43834cba942e82f5c50";
    };

    unpackPhase = ''
      dpkg -x $src .
    '';

    installPhase = ''
      rm -rf usr/lib64/
      install -d usr $out
    '';
  };
  extension = stdenv.mkDerivation rec {
    name = "pwas-for-firefox";

    src = fetchurl {
      url = "https://addons.mozilla.org/firefox/downloads/file/4175246/pwas_for_firefox-2.8.0.xpi";
      sha256 = "acad448393fb9788cafa6bfdc48ab3723a7bae0e8844f82830ac831867c9125c";
    };

    preferLocalBuild = true;
    allowSubstitutes = true;

    buildCommand = ''
      dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
      mkdir -p "$dst"
      install -v -m644 "$src" "$dst/firefoxpwa@filips.si.xpi"
    '';
  };
}
