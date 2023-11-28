{ pkgs, lib, hostname }:
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
          lib.trivial.mergeAttrs { "${currName}" = ((import currAbsolute) { inherit pkgs lib hostname; }); } acc
        else
          acc
  );
  autoloaded =  (helpers.autoloader {
    fn = buildConfig;
    initialVal = {};
    root = autoloadRoot;
  });
in
let
  tui = (import ./tui);
in
lib.trivial.mergeAttrs {
  neovim = tui.neovim { inherit pkgs; };
  zoxide = tui.zoxide;
  lsd = tui.lsd;
  direnv = tui.direnv;
  tmux = tui.tmux { inherit pkgs; };
} autoloaded
