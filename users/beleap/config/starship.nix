{
  nix_shell.symbol = "(nix)";
  azure = {
    disabled = false;
    format = "on [$symbol($username)]($style) ";
    symbol = "󰠅 ";
    style = "blue bold";
  };
}
