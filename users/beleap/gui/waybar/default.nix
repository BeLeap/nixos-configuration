let
  nord = import ../../../../const/nord.nix;
in
{
  enable = true;

  settings = (import ./settings.nix);
  style = ''
    @define-color nord0 ${nord.nord0};
    @define-color nord1 ${nord.nord1};
    @define-color nord2 ${nord.nord2};
    @define-color nord3 ${nord.nord3};
    @define-color nord4 ${nord.nord4};
    @define-color nord5 ${nord.nord5};
    @define-color nord6 ${nord.nord6};
    @define-color nord7 ${nord.nord7};
    @define-color nord8 ${nord.nord8};
    @define-color nord9 ${nord.nord9};
    @define-color nord10 ${nord.nord10};
    @define-color nord11 ${nord.nord11};
    @define-color nord12 ${nord.nord12};
    @define-color nord13 ${nord.nord13};
    @define-color nord14 ${nord.nord14};
    @define-color nord15 ${nord.nord15};
  '' + builtins.readFile (./. + "/style.css");
}
