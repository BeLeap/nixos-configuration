{
  nix_shell.symbol = "(nix)";
  azure = {
    disabled = false;
    format = "on [$symbol($subscription)]($style) ";
    symbol = "󰠅 ";
    style = "blue bold";
  };
}
