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

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"

      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' { if -F '#{pane_at_left}' '''''' 'select-pane -L' }
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' { if -F '#{pane_at_bottom}' '''''' 'select-pane -D' }
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' { if -F '#{pane_at_top}' '''''' 'select-pane -U' }
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' { if -F '#{pane_at_right}' '''''' 'select-pane -R' }

      bind-key -T copy-mode-vi 'C-h' if -F '#{pane_at_left}' '''''' 'select-pane -L'
      bind-key -T copy-mode-vi 'C-j' if -F '#{pane_at_bottom}' '''''' 'select-pane -D'
      bind-key -T copy-mode-vi 'C-k' if -F '#{pane_at_top}' '''''' 'select-pane -U'
      bind-key -T copy-mode-vi 'C-l' if -F '#{pane_at_right}' '''''' 'select-pane -R'
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
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
      nvim-treesitter.withAllGrammars 
    ];
    
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
