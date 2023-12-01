{
  direnv = {
    enable = true;

    nix-direnv = {
      enable = true;
    };

    enableNushellIntegration = true;
  };
  lsd = {
    enable = true;

    enableAliases = true;
  };
  zoxide = {
    enable = true;

    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
  tmux = { pkgs }: {
    enable = true;
    clock24 = true;
    shortcut = "a";
    keyMode = "vi";

    extraConfig = ''
      set -g base-index 1
      set-option -g default-terminal "screen-256color"
      set-option -sa terminal-features ',XXX:RGB'
    '';

    tmuxinator = {
      enable = true;
    };

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_tabs_enabled on
        '';
      }
    ];
  };
  neovim = { pkgs }:
  {
    enable = true;

    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withRuby = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      gcc
    ];
  };
}
