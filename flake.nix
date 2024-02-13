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

      commonConfiguration = { hostname, type, extraPreModules ? [] }: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = extraPreModules ++ [
          { nixpkgs.overlays = overlays; }
          (./. + "/hosts/${hostname}/configuration.nix")
          home-manager.nixosModules.home-manager
          ({ pkgs, lib, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.beleap = import ./users/beleap/home.nix {
              inherit pkgs lib hostname type;
            };
          })
        ];
      };
    in
    {
      nixosConfigurations = fold
        (acc: elem: acc // {
          "${elem.hostname}" = (commonConfiguration elem);
        })
        { } [ 
          { 
            hostname = "beleap-xps-9510"; 
            type = "nixos";
          } 
          { 
            hostname = "beleap-thinkpad"; 
            type = "nixos";
          }
          {
            hostname = "beleap-wsl";
            type = "nixos-wsl";
            extraPreModules = [
              inputs.nixos-wsl.nixosModules.wsl
            ];
          }
        ];

      # homeConfigurations = {
      #   beleap = import ./users/beleap {
      #     inherit home-manager nixpkgs inputs overlays;
      #   };
      # };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
