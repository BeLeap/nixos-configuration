{ pkgs, lib }:
let
  helpers = import ../helpers.nix { inherit pkgs lib; };
  autoloadRoot = (./. + "/autoload");
  buildConfig = (
    acc: curr:
      let
        currAbsolute = /. + curr;
        currRelative = lib.path.removePrefix autoloadRoot currAbsolute;
        currComponents = lib.path.subpath.components "${currRelative}";
        currComponentsLength = builtins.length currComponents;
        currFilename = lib.lists.last currComponents;
      in
      if currFilename == "default.nix"
        then
          let
            currName = builtins.elemAt currComponents (currComponentsLength - 2);
          in
          lib.trivial.mergeAttrs { "${currName}" = ((import currAbsolute) { inherit pkgs lib; }); } acc
        else
          acc
  );
  autoloaded =  (helpers.autoloader {
    fn = buildConfig;
    initialVal = {};
    root = autoloadRoot;
  });
in
lib.trivial.mergeAttrs {
  neovim = (import ./tui).neovim;
  zoxide = (import ./tui).zoxide;
  lsd = (import ./tui).lsd;
  direnv = (import ./tui).direnv;
  tmux = (import ./tui).tmux { inherit pkgs; };
} autoloaded
