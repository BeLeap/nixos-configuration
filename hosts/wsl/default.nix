{ nixpkgs, inputs }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = [
    inputs.nixos-wsl.nixosModules.wsl

    {
      system.stateVersion = "22.05";

      wsl = {
        enable = true;
        automountPath = "/mnt";
        defaultUser = "beleap";
        startMenuLaunchers = true;
      };
    }

    ./configuration.nix
  ];
}
