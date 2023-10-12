{ pkgs, ... }:
with pkgs;
stdenv.mDerivation rec {
  name = "muzika";

  src = fetchFromGitHub {
    owner = "vixalien";
    repo = "muzika";
    rev = "ecefc88d3e08ec254eb44b1ab73de79d70431054";
    hash = "";
    fetchSubmodules = true;
  };
  
  buildInputs = [ 
    meson
    ninja
  ];

  meta = {
    description = "muzika";
  };
}
