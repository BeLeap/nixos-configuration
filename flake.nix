{
  description = "BeLeap Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:guibou/nixGL";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs@{ home-manager, nixpkgs, ... }:
    let
      overlays = [
        inputs.nixgl.overlay
        inputs.neovim-nightly-overlay.overlay
      ];
      homemanagerConfiguration = { hostname }: ({ pkgs, lib, ... }: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.beleap = import ./users/beleap/home.nix {
          inherit pkgs lib hostname;
        };
      });
      commonModules = [
        { nixpkgs.overlays = overlays; }
        home-manager.nixosModules.home-manager
      ];
    in
    {
      nixosConfigurations = {
        beleap-xps-9510 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = commonModules ++ [
            ./hosts/beleap-xps-9510/configuration.nix
            (homemanagerConfiguration { hostname = "beleap-xps-9510"; })
          ];
        };

        beleap-thinkpad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = commonModules ++ [
            ./hosts/beleap-thinkpad/configuration.nix
            (homemanagerConfiguration { hostname = "beleap-thinkpad"; })
          ];
        };
      };

      homeConfigurations = {
        beleap = import ./users/beleap {
          inherit home-manager nixpkgs inputs overlays;
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
