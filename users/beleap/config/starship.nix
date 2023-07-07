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
    truncation_symbol = "(...)/";
  };
  azure = {
    disabled = false;
    format = "\\[[$symbol($username)]($style)\\]";
    symbol = "󰠅 ";
    style = "blue bold";
  };
  kubernetes = {
    disabled = false;
    format = "\\[[$symbol($context)]($style)\\]";
    symbol = "󰻈 ";
  };
  git_branch = {
    format = "\\[[$symbol$branch]($style)\\]";
  };
  git_status = {
    format = "([\\[$all_status$ahead_behind\\]]($style))";
  };
  cmd_duration = {
    format = "\\[[$duration]($style)\\]";
  };
  terraform = {
    disabled = true;
  };
  memory_usage = {
    disabled = false;
    threshold = -1;
    format = "\\[$symbol[$ram_pct]($style)\\]";
    symbol = "󰍛 ";
  };
}
