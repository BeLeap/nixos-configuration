{ ... }:
{
  enable = true;

  interactiveShellInit = ''
    fish_vi_key_bindings
  '';

  shellAliases = {
    sofish = "source ~/.config/fish/config.fish";

    v = "nvim";
    mux = "tmuxinator";
  };

  shellAbbrs = {
    gst = "git status";
    gsw = "git switch";
    gd = "git diff";
    ga = "git add";
    gc = "git commit -v";
    gp = "git push";
    gf = "git fetch --prune --all";
    gl = "git pull";

    k = "kubectl";
    ktx = "kubectx";
    kns = "kubens";
    tf = "terraform";
  };
}
