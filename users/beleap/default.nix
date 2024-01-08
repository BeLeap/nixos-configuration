{ home-manager, nixpkgs, overlays, ... }:

let
  system = "x86_64-linux";
in
home-manager.lib.homeManagerConfiguration {
  modules = [
    {
      nixpkgs = {
        inherit overlays;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
          permittedInsecurePackages = [
            "electron-24.8.6"
          ];
          packageOverrides = pkgs: {
            nur = import
              (builtins.fetchTarball {
                url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
              })
              {
                inherit pkgs;
              };
          };
        };
      };
    }
    ./home.nix
  ];

  pkgs = nixpkgs.outputs.legacyPackages.${system};
}
