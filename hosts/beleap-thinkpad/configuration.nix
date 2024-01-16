{ pkgs, ... }:
rec {
  imports =
    [
      ./hardware-configuration.nix
      (import ../common/configuration.nix {
        inherit pkgs;
        lib = pkgs.lib;
        hostname = networking.hostName;
      })
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "23.05";
  networking.hostName = "beleap-thinkpad";
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];

  services = {
    fprintd = {
      enable = true;
    };
  };
  security.pam.services = {
    swaylock.text = ''
      # Account management.
      account required pam_unix.so # unix (order 10900)
      
      # Authentication management.
      auth sufficient pam_unix.so likeauth try_first_pass # unix (order 11600)
      auth sufficient /nix/store/vq5r4v2qnqfsjif5ffnn17l46k6qk1s5-fprintd-1.94.2/lib/security/pam_fprintd.so # fprintd (order 11400)
      auth required pam_deny.so # deny (order 12400)
      
      # Password management.
      password sufficient pam_unix.so nullok yescrypt # unix (order 10200)
      
      # Session management.
      session required pam_env.so conffile=/etc/pam/environment readenv=0 # env (order 10100)
      session required pam_unix.so # unix (order 10200)
    '';
    polkit-1.text = ''
      # Account management.
      account required pam_unix.so # unix (order 10900)
      
      # Authentication management.
      auth sufficient pam_unix.so likeauth try_first_pass # unix (order 11600)
      auth sufficient /nix/store/vq5r4v2qnqfsjif5ffnn17l46k6qk1s5-fprintd-1.94.2/lib/security/pam_fprintd.so # fprintd (order 11400)
      auth required pam_deny.so # deny (order 12400)
      
      # Password management.
      password sufficient pam_unix.so nullok yescrypt # unix (order 10200)
      
      # Session management.
      session required pam_env.so conffile=/etc/pam/environment readenv=0 # env (order 10100)
      session required pam_unix.so # unix (order 10200)
    '';
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
