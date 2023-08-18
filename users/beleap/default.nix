{ home-manager, nixpkgs, inputs, overlays }:

let
  system = "x86_64-linux";
  username = "beleap";
in
home-manager.lib.homeManagerConfiguration {
  modules = [
    {
      nixpkgs = {
        inherit overlays;
      };

      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
      };
    }

    ./home.nix
  ];

  pkgs = nixpkgs.outputs.legacyPackages.${system};
}
