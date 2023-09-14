{
  description = "BeLeap Personal NixOS Configuration";

  inputs = {
    master.url = "github:NixOS/nixpkgs/master";
    nixpkgs.follows = "master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:guibou/nixGL";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { home-manager, nixpkgs, ... }@inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        inputs.nixgl.overlay
      ];
    in
    {
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
}
