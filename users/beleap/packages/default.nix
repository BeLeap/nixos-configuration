{ pkgs, lib }: with pkgs;
let
  helpers = import ../helpers.nix { inherit pkgs lib; };
in
{
  prereq = [
    nix-prefetch-git
    gnumake
    go
    rustup
    stow
    cmake
    deno
    zig
  ];
  tui = [
    neovim-nightly
    hexyl
    sshpass
    man
    irssi
    bottom
    tealdeer
    fzf
    gdb
    file
    yq
    lsd
    fd
    ripgrep
    bat
    difftastic
    unzip
    gitAndTools.gh
    playerctl
    _1password
    wally-cli
  ];
  gui = [
    _1password-gui
    swaybg
    blueman
    pavucontrol
    gnome.nautilus
    wdisplays
    swayest-workstyle
    grim
    slurp
    wl-clipboard
    tridactyl-native
    ((import ../../../pkgs/firefox-profile-switcher-connector.nix) { inherit lib pkgs; })
    cliphist
  ];
  db = [
    postgresql_15
    mongosh
  ];
  language-support = [
    universal-ctags
    nodejs
    yarn
    evcxr
    ghc
    haskell-language-server
    python310
    tree-sitter
    jupyter
    jdk
  ];
  python-packages = with python310Packages; [
    pip
    huggingface-hub
  ];
  network = [
    croc
    ntp
    mtr
    tshark
    dig
    openssl
    ipcalc
    tcpdump
    istioctl
    ngrok
  ];
  devops = [
    openvpn
    vault-bin

    azure-cli
    saml2aws
    awscli2
    terraform

    kubernetes-helm
    kubectl
    kubectx
    kubectl-node-shell
    adoptopenjdk-icedtea-web
  ];
  fonts = [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
  ];
  others = [
    # (helpers.nixGLMesaWrap anytype)
  ];
}
