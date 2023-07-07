{
  nix_shell.symbol = "(nix)";
  format = "$character";
  right_format = "$character$all";
  azure = {
    disabled = false;
    format = "on [$symbol($username)]($style) ";
    symbol = "󰠅 ";
    style = "blue bold";
  };
  kubernetes = {
    disabled = false;
    format = "[$symbol($context)](dimmed green) in ";
    symbol = "󰻈 ";
  };
}
