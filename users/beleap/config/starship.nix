{ pkgs }:
{
  nix_shell.symbol = "(nix)";
  format = ''$directory
$character'';
  right_format = (import ./format_generator.nix { inherit pkgs; })
    .remove { 
      to_remove = [
        "$directory"
        "$character"
      ]; 
    };
  directory = {
    truncation_symbol = ".../";
  };
  azure = {
    disabled = false;
    format = "on [$symbol($username)]($style) ";
    symbol = "󰠅 ";
    style = "blue bold";
  };
  kubernetes = {
    disabled = false;
    format = "\\[[$symbol($context)](dimmed green)\\] ";
    symbol = "󰻈 ";
  };
}
