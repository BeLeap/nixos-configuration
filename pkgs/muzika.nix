{ pkgs, ... }:
with pkgs;
stdenv.mkDerivation rec {
  pname = "muzika";
  name = "muzika";

  src = fetchFromGitHub {
    owner = "vixalien";
    repo = "muzika";
    rev = "4e718ad372121d34ae3c97e7215868c99420a5ed";
    hash = "sha256-fQaasCNQSv+l8CxkHP9S4hiJIYeRrhFil0u7Igdaxiw=";
    fetchSubmodules = true;
    leaveDotGit = true;
  };

  nativeBuildInputs = [
    desktop-file-utils
    gobject-introspection
    meson
    ninja
    nodejs
    pkg-config
    wrapGAppsHook4
    yarn
    git
  ];

  buildInputs = [
    gjs
    glib-networking
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gtk4
    libadwaita
    libsoup_3
  ];

  yarnOfflineCache = fetchYarnDeps {
    yarnLock = src + "/yarn.lock";
    hash = "sha256-06WhDe9lHo33+VstQ94kb7H5Ecg+CoRK36XAYlEfUuU=";
  };

  preConfigure = ''
    export HOME="$PWD"
    yarn config --offline set yarn-offline-mirror $yarnOfflineCache
    ${fixup_yarn_lock}/bin/fixup_yarn_lock yarn.lock
  '';

  mesonFlags = [
    "-Dyarnrc=../.yarnrc"
  ];

  postFixup = ''
    sed -i "1 a imports.package._findEffectiveEntryPointName = () => 'com.vixalien.muzika';" $out/bin/.com.vixalien.muzika-wrapped
    ln -s $out/bin/com.vixalien.muzika $out/bin/muzika
  '';

  meta = with lib; {
    description = "Elegant music streaming app";
    homepage = "https://github.com/vixalien/muzika";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ onny ];
  };
}
