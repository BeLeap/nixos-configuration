{ nixpkgs, inputs, overlays }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = [
    ./configuration.nix
  ];

  specialArgs = {
    inherit overlays;
  };
}
