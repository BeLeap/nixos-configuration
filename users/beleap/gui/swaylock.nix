let
  nord = import ../../../const/nord.nix;
in
{
  enable = true;
  settings = {
    image = "/home/beleap/.background";

    line-color = nord.hexify nord.nord8;
    text-color = nord.hexify nord.nord4;
    inside-color = nord.hexify nord.nord0;

    ring-color = nord.hexify nord.nord9;
    key-hl-color = nord.hexify nord.nord7;

    line-ver-color = nord.hexify nord.nord8;
    text-ver-color = nord.hexify nord.nord4;
    inside-ver-color = nord.hexify nord.nord0;

    ring-ver-color = nord.hexify nord.nord13;

    line-wrong-color = nord.hexify nord.nord8;
    text-wrong-color = nord.hexify nord.nord4;
    inside-wrong-color = nord.hexify nord.nord0;

    ring-wrong-color = nord.hexify nord.nord11;
  };
}
