{ home-manager, nixpkgs }:

let
  system = "x86-64-linux";
  username = "beleap";
in
home-manager.lib.homeManagerConfiguration {
  modules = [
    {
      nixpkgs = {};

      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
      };
    }

    ./home.nix
  ];

  pkgs = nixpkgs.outputs.legacyPackages.${system};
}
