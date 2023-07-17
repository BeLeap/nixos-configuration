{
  description = "BeLeap Personal NixOS Configuration";

  inputs = {
    master.url = "github:NixOS/nixpkgs/master";
    nixpkgs.follows = "master";

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

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { home-manager, nixpkgs, flake-parts, ... }@inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        nixosConfigurations = {
          wsl = import ./hosts/wsl {
            inherit nixpkgs inputs overlays;
          };
        };

        homeConfigurations = {
          beleap = import ./users/beleap {
            inherit home-manager nixpkgs inputs overlays;
          };
        };
      };

      systems = [ "x86_64-linux" ];
    };
}
