{ nixpkgs, inputs }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = [
    inputs.nixos-wsl.nixosModules.wsl

    {
      system.stateVersion = "22.05";

      wsl = {
        enable = true;
        defaultUser = "beleap";
        startMenuLaunchers = true;
        nativeSystemd = true;

        wslConf = {
          automount.root = "/mnt";
        };
      };
    }

    ./configuration.nix
  ];
}
