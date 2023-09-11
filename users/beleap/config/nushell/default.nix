{
  git = builtins.readFile (./. + "/git.nu");
  kubectl = builtins.readFile (./. + "/kubectl.nu");
}
