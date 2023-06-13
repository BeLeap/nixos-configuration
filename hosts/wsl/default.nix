{ nixpkgs, inputs }:

nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";

  modules = [
    inputs.nixos-wsl.nixosModules.wsl

    {
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
