{ pkgs, lib }:
{
  fish = (import ./fish);
  git = (import ./git);
  starship = (import ./starship) { inherit pkgs; };
  firefox = (import ./firefox) { inherit pkgs; };
  wezterm = (import ./wezterm) { inherit pkgs lib; };

  neovim = (import ./tui).neovim;
  zoxide = (import ./tui).zoxide;
  lsd = (import ./tui).lsd;
  direnv = (import ./tui).direnv;
  tmux = (import ./tui).tmux { inherit pkgs; };
}
