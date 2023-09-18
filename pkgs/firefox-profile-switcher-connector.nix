{ pkgs, ... }:
with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "firefox-profile-switcher-connector";
  version = "v0.1.1";

  src = fetchFromGitHub {
    owner = "null-dev";
    repo = pname;
    rev = version;
    hash = "sha256-mnPpIJ+EQAjfjhrSSNTrvCqGbW0VMy8GHbLj39rR8r4=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ rustc cargo ];

  cargoHash = "sha256-CNalAHDhSYsB4qvjGCte9jVK4m1etbAdpzgZN3PeNMk= ";
}
