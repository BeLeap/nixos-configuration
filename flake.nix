{
  description = "BeLeap Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
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
        # inputs.neovim-nightly-overlay.overlay
        inputs.nixgl.overlay
      ];
    in
    {
      nixosConfigurations = {
        wsl = import ./hosts/wsl {
          inherit nixpkgs inputs overlays;
        };

        beleap-xps-9510 = import ./hosts/beleap-xps-9510 {
          inherit nixpkgs inputs overlays;
        };
        
        beleap-thinkpad = import ./hosts/beleap-thinkpad {
          inherit nixpkgs inputs overlays;
        };
      };

      homeConfigurations = {
        beleap = import ./users/beleap {
          inherit home-manager nixpkgs inputs overlays;
        };
      };
    };
}
