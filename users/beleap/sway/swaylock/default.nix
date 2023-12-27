let
  catppuccin = import ../../../../const/catppuccin.nix;
in
{
  enable = true;
  settings = {
    image = "/home/beleap/.background";

    line-color = catppuccin.hexify catppuccin.overlay0;
    text-color = catppuccin.hexify catppuccin.text;
    inside-color = catppuccin.hexify catppuccin.base;

    ring-color = catppuccin.hexify catppuccin.teal;
    key-hl-color = catppuccin.hexify catppuccin.sapphire;

    line-ver-color = catppuccin.hexify catppuccin.overlay0;
    text-ver-color = catppuccin.hexify catppuccin.text;
    inside-ver-color = catppuccin.hexify catppuccin.base;

    ring-ver-color = catppuccin.hexify catppuccin.yellow;

    line-wrong-color = catppuccin.hexify catppuccin.overlay0;
    text-wrong-color = catppuccin.hexify catppuccin.text;
    inside-wrong-color = catppuccin.hexify catppuccin.base;

    ring-wrong-color = catppuccin.hexify catppuccin.red;
  };
}
