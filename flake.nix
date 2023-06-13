{
  description = "BeLeap Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    dotfiles = {
      url = "github:beleap/dotfiles";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/wsl
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
