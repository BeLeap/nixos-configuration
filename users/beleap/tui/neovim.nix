{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    nvim-treesitter
    nvim-treesitter.withAllGrammars
  ];

  enable = true;
  package = pkgs.neovim-nightly;

  viAlias = true;
  vimAlias = true;

  withNodeJs = true;
  withRuby = true;
  withPython3 = true;

  extraPackages = with pkgs; [
    gcc
  ];
}
