{ pkgs, lib }: with pkgs;
{
  tui = [
    nix-prefetch-git
    nixpkgs-fmt
    hexyl
    sshpass
    man
    irssi
    bottom
    tealdeer
    fzf
    gdb
    file
    yq-go
    jq
    lsd
    fd
    ripgrep
    bat
    unzip
    gitAndTools.gh
    playerctl
    wally-cli
    greetd.tuigreet
    killall
    uair
    mpv
    libnotify
    mellowplayer
    tmuxp
    vifm
  ];
  gui = [
    swaybg
    swayidle
    blueman
    pavucontrol
    gnome.nautilus
    wdisplays
    grim
    slurp
    wl-clipboard
    tridactyl-native
    cliphist
    vlc
    polkit_gnome
    wireplumber
    wl-mirror
    keybase-gui
    discord
    logseq
    calibre
    keymapp
    hyprshot
    pyprland
  ];
  db = [
    postgresql_15
    mongosh
  ];
  language-support = [
    glibc
    gnumake
    go
    rustup
    stow
    cmake
    deno
    zig
    universal-ctags
    nodejs
    yarn
    evcxr
    ghc
    haskell-language-server
    (python311.withPackages (ps: with ps; [
      pip
      huggingface-hub
      jupyterlab
      jupyter
      bash-kernel
    ]))
    tree-sitter
    jdk
    lua-language-server
    pre-commit
    nodePackages.typescript-language-server
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
    mitmproxy
    nmap
  ];
  devops = [
    openvpn
    vault-bin

    azure-cli
    kubelogin
    saml2aws
    awscli2
    terraform

    (wrapHelm kubernetes-helm {
      plugins = with kubernetes-helmPlugins; [
        helm-cm-push
        helm-diff
      ];
    })
    kubectl
    kubectx
    kubectl-node-shell
    adoptopenjdk-icedtea-web
    gnupg
    pinentry
  ];
  fonts = [
    noto-fonts-cjk-serif
    noto-fonts-monochrome-emoji
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    ((import ../../../pkgs/nanum-gothic-coding.nix) { inherit lib pkgs; })
    pretendard
  ];
}
