{ home-manager, nixpkgs, inputs }:

let
  system = "x86_64-linux";
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

  extraSpecialArgs = {
    inherit (inputs) dotfiles;
  };
}
