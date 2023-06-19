{ home-manager }:

home-manager.lib.homeManagerConfiguration {
  modules = [
    {
      nixpkgs = {};

      home = {
        username = "beleap";
        homeDirectory = "/home/beleap";
      };
    }

    ./home.nix
  ];
}
