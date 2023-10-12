{ pkgs, ... }:
with pkgs;
stdenv.mkDerivation rec {
  name = "muzika";

  src = fetchFromGitHub {
    owner = "vixalien";
    repo = "muzika";
    rev = "ecefc88d3e08ec254eb44b1ab73de79d70431054";
    hash = "sha256-WtscshFaGdjqLLOVpzEhW/UyGByaMgPwkUH+2yCuNP4=";
    fetchSubmodules = true;
    keepDotDir = true;
  };
  
  nativeBuildInputs = [ 
    git
    meson
    ninja
    libadwaita
  ];

  unpackPhase = ''
  '';

  buildPhase = ''
    cd $out/build
    ninja
  '';

  meta = {
    description = "muzika";
  };
}
