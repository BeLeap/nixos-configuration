{ config, nixpkgs, inputs }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = [
    inputs.nixos-wsl.nixosModules.wsl

    {
      nixpkgs = { inherit config; };
      wsl = {
        enable = true;
        autoMountPath = "/mnt";
        defaultUser = "beleap";
        startMenuLaunchers = true;
      };
    }

    ./configuration.nix
  ];
}
