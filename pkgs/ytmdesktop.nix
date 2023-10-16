{ pkgs, ... }:
with pkgs;
stdenv.mkDerivation rec {
  name = "ytmdesktop";
  pname = "${name}";

  src = fetchFromGitHub {
    owner = "ytmdesktop";
    repo = "ytmdesktop";
    rev = "613a71a0f8d2fb20f679e1bcf8bb8d490448eb77";
    hash = "sha256-UDAMgx2aDBgrj0ClwSnZshNkD3/qTM5TSDtsiJVaLQs=";
  };
  # yarnOfflineCache = fetchYarnDeps {
  #   yarnLock = "${src}/yarn.lock";
  #   sha256 = "";
  # };

  nativeBuildInputs = [
    fixup_yarn_lock
    yarn
    nodejs
  ];
  buildPhase = ''
    export HOME=$(mktemp -d)
    fixup_yarn_lock yarn.lock
    yarn
    yarn make
    patchShebangs node_modules
    export PATH=$PWD/node_modules/.bin:$PATH
    mkdir -p $out
    cd ..
  '';

  installPhase = ''
    ls -al && exit 1
  '';


  meta = {
    description = "ytmdesktop";
  };
}
