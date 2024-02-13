{
  description = "BeLeap Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = inputs@{ home-manager, nixpkgs, ... }:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];

      fold = fn: acc: list:
        if (builtins.length list) == 0 then acc
        else (fn (fold fn acc (builtins.tail list)) (builtins.head list));
    in
    {
      nixosConfigurations = (fold
        (acc: elem: acc // {
          "${elem}" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              { nixpkgs.overlays = overlays; }
              (./. + "/hosts/${elem}/configuration.nix")
              home-manager.nixosModules.home-manager
              ({ pkgs, lib, ... }: {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.beleap = import ./users/beleap/home.nix {
                  inherit pkgs lib;
                  hostname = elem;
                };
              })
            ];
          };
        })
        { } [ "beleap-xps-9510" "beleap-thinkpad" ]) // {
          "beleap-wsl" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              { nixpkgs.overlays = overlays; }
              inputs.nixos-wsl.nixosModules.wsl
              (./hosts/beleap-wsl/configuration.nix)
              home-manager.nixosModules.home-manager
              ({ pkgs, lib, ... }: {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.beleap = import ./users/beleap/home.nix {
                  inherit pkgs lib;
                  hostname = "beleap-wsl";
                  isNixOS = false;
                };
              })
            ];
          };
        };

      # homeConfigurations = {
      #   beleap = import ./users/beleap {
      #     inherit home-manager nixpkgs inputs overlays;
      #   };
      # };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
