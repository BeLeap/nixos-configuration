{ pkgs }: with pkgs;
let
  nix = [
    nix-prefetch-git
  ];
  tui = [
    neovim-nightly
    hexyl
    sshpass
    gnumake
    stow
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

  ];
  db = [
    postgresql_15
    mongosh
  ];
  language-support = [
    universal-ctags
    nodejs
    yarn
    go
    rustup
    evcxr
    deno
    ghc
    haskell-language-server
    python3
    zig
    tree-sitter
    jupyter
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
  ];
  others = [
    anytype
  ];
in
{
  packages = nix ++ tui ++ db ++ language-support ++ network ++ devops ++ others;
}
