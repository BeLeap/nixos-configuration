{
  enable = true;

  style = builtins.readFile(./. + "/style.css");
  settings = {
    width = "30%";
  };
}
