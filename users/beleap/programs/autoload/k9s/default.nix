{ ... }:
let
  catppuccin = import ../../../../../const/catppuccin.nix;
in
{
  enable = true;

  skin = { k9s = { body = { bgColor = "default"; }; promt = { bgColor = "default"; }; info = { sectionColor = "default"; }; dialog = { bgColor = "default"; labelFgColor = "default"; fieldFgColor = "default"; }; frame = { crumbs = { bgColor = "default"; }; title = { bgColor = "default"; counterColor = "default"; }; menu = { fgColor = "default"; }; }; views = { charts = { bgColor = "default"; }; table = { bgColor = "default"; header = { fgColor = "default"; bgColor = "default"; }; }; xray = { bgColor = "default"; }; logs = { bgColor = "default"; indicator = { bgColor = "default"; toggleOnColor = "default"; toggleOffColor = "default"; }; }; yaml = { colonColor = "default"; valueColor = "default"; }; }; }; };
}
