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
    unzip
    gitAndTools.gh
    playerctl
    wally-cli
    greetd.tuigreet
    killall
    uair
    mpv
    libnotify
  ];
  gui = [
    (_1password-gui.overrideAttrs { polkitPolicyOwners = [ "beleap" ]; })
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
    (helpers.nixGLWrap ((import ../../../pkgs/youtube-music.nix) { inherit pkgs; }))
    keybase-gui
    discord
    (helpers.nixGLWrap (logseq))
    calibre
    (helpers.nixGLWrap ((import ../../../pkgs/keymapp.nix) { inherit pkgs; }))
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
