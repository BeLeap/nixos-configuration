{ pkgs, ... }:
with pkgs;
stdenv.mkDerivation {
  name = "audiotube";
  src = fetchgit {
    url = "https://invent.kde.org/plasma-mobile/audiotube";
    rev = "ba017f29e466112a03febff18129b028cc96f1b4";
    hash = "sha256-ore1fuOxfiuMMtgo0d8j8RnQvthsyOM4PDSBQGmZJzM=";
  };

  nativeBuildInputs = [
    libsForQt5.qt5.wrapQtAppsHook
    
    cmake
    extra-cmake-modules
    futuresql
  ];

  buildInputs = [
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtimageformats
    libsForQt5.qt5.qtquickcontrols2

    libsForQt5.ki18n
    libsForQt5.kirigami2
    libsForQt5.kirigami-addons
    libsForQt5.kcrash
    libsForQt5.kpurpose
    libsForQt5.qcoro
    
    python310Packages.pybind11   
    python310Packages.ytmusicapi

    yt-dlp
    gst_all_1.gst-plugins-good
  ];

  buildPhase = ''
    cd "$src"
    cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
    make -C build
  '';

  installPhase = ''
    make -C build DESTDIR="$out" PREFIX=/usr install
  '';
}
