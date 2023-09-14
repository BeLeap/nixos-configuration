let
  bind = builtins.readFile(./. + "/bind.conf");
  env = builtins.readFile(./. + "/env.conf");
  main = builtins.readFile(./. + "/main.conf");
  windowrule = builtins.readFile(./. + "/windowrule.conf");
in
{
  enable = true;

  enableNvidiaPatches = true;
  systemdIntegration = true;

  extraConfig = builtins.concatStringsSep "\n" [(import ./theme).mocha bind env main windowrule];
}
