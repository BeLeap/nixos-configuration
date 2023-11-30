{ pkgs, lib }: with pkgs; let helpers = import ../helpers.nix { inherit pkgs lib; }; in
{
  tui = [
    nix-prefetch-git
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
    jq
    lsd
    fd
    ripgrep
    bat
    difftastic
    unzip
    gitAndTools.gh
    playerctl
    wally-cli
    greetd.tuigreet
    killall
  ];
  gui = [
    (_1password-gui.overrideAttrs { polkitPolicyOwners = [ "wheel" ]; })
    swaybg
    swayidle
    blueman
    pavucontrol
    gnome.nautilus
    wdisplays
    swayest-workstyle
    grim
    slurp
    wl-clipboard
    tridactyl-native
    cliphist
    vlc
    polkit_gnome
    wireplumber
    wl-mirror
    (helpers.nixGLWrap ((import ../../../pkgs/youtube-music.nix) { inherit pkgs; }))
    keybase-gui
    discord
    logseq
    calibre
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
    kdash

    (wrapHelm kubernetes-helm {
      plugins = with kubernetes-helmPlugins; [
        helm-cm-push
      ];
    })
    kubectl
    kubectx
    kubectl-node-shell
    adoptopenjdk-icedtea-web
  ];
  fonts = [
    noto-fonts-cjk-serif
    noto-fonts-monochrome-emoji
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    ((import ../../../pkgs/nanum-gothic-coding.nix) { inherit lib pkgs; })
    ((import ../../../pkgs/monaspace.nix) { inherit lib pkgs; })
    pretendard
  ];
}
