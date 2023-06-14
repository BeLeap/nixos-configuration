{ home }:

home.lib.homeManagerConfigurations {
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
