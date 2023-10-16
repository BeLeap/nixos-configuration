{ pkgs, ... }:
with pkgs;
let
  name = "youtube-music";
  pname = "${name}";
  version = "2.1.1";
  
  src = fetchurl {
    url = "https://github.com/th-ch/youtube-music/releases/download/v${version}/YouTube-Music-${version}.AppImage";
    hash = "sha256-gB8CwHSUnduQ564uwdmUyUeylw0IJsGddnW1fFrKrOE=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 rec {
  inherit name pname src;

  extraInstallCommands = ''
    install -m 444 \
        -D ${appimageContents}/youtube-music.desktop \
        -t $out/share/applications
    substituteInPlace \
        $out/share/applications/youtube-music.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}'
  '';
}
