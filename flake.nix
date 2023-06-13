{
  description = "BeLeap Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    dotfiles = {
      url = "github:beleap/dotfiles";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/wsl/configuration.nix
      ];
    };

    homeConfigurations.beleap = home-manager.lib.homeManagerConfiguration {
      modules = [
        ./home.nix
      ];

      extraSpecialArgs = {
        inherit (inputs) dotfiles;
      };
    };
  };
}
