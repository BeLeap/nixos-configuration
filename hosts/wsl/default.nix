{ nixpkgs, inputs, overlays }:

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
        docker-native = {
          enable = true;
          addToDockerGroup = true;
        };

        wslConf = {
          automount.root = "/mnt";
        };
      };
    }

    ./configuration.nix
  ];
}

    # ({
    #   nixpkgs = {
    #     overlays = overlays;
    #     config.allowUnfree = true; # this is the only allowUnfree that's actually doing anything
    #   };
    # })
