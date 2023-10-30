let
  thisFile = ./.;
  basePath = builtins.dirOf thisFile;
  catppuccin = import "${basePath}/const/catppuccin.nix";
in
{
  enable = true;

  backgroundColor = catppuccin.base;
  textColor = catppuccin.text;
  borderColor = catppuccin.lavender;
  borderSize = 4;
  borderRadius = 10;
  progressColor = "over ${catppuccin.surface0}";
  defaultTimeout = 60000;

  extraConfig = ''
    [urgency=high]
    border-color=${catppuccin.peach}
    default-timeout=0
  '';
}
