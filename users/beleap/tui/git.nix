{ isWSL }:
{
  enable = true;

  userName = "BeLeap";
  userEmail = "beleap@beleap.dev";

  extraConfig = {
    push.autoSetupRemote = true;
    init.defaultBranch = "main";
    rerere.enable = true;
    column.ui = "auto";
    branch.sort = "-committerdate";
    fetch.writeCommitGraph = true;
    remote.origin.fetch = "+refs/pull/*:refs/remotes/origin/pull/*";
    help.autocorrect = "prompt";
  } // (if isWSL then {
    core.sshCommand = "ssh.exe";
  } else {
    commit.gpgsign = true;
    user.signingKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNrBVLG52+DGp9mHdt5H45alxWVCLu5JsodOPryPar5R620vqryWONGsE9FI8EeFRiBvIvNhhvYlbTzaSYU46koVRAUcjFUH3Wd3NW15sY4UiC9RYVMMtc0IpghSTa0cPH06XvU0d8cftySfarsT6rlJPLDpOKKn0yrbfI3ErncLpIWyBIYELkzJ3azeb4J8L2KoO+l4Ce4QR7E1eyqRXOPT81ZwK19mTW/F+H+UAlcQrv5uUh3NZclmahE3Vwc23VWORwmBvHnhcZSOb/M79lk45WVUFZYPBqSPxihNd9Cpcq7TgKczS1liiO2S2NIJ73wG/UviuR52fOqBagJBlL";
    gpg = {
      format = "ssh";
      ssh.program = "op-ssh-sign";
    };
  });

  ignores = [
    "*.null_ls*"
    "root.md"
    "run.fish"
    "shell.nix"
    ".envrc"
    ".direnv"
    "run.nu"
  ];

  aliases = {
    gone = "! git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '\$2 == \"[gone]\" {print \$1}' | xargs -r git branch -D";
    staash = "stash --all";
    adog = "log --all --decorate --oneline --graph";
  };
}
