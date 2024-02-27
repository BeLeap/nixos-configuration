{ pkgs }:
{
  enable = true;

  clock24 = true;
  shortcut = "a";
  keyMode = "vi";

  baseIndex = 1;
  escapeTime = 10;
  aggressiveResize = true;

  plugins = with pkgs.tmuxPlugins; [
    nord
    {
      plugin = prefix-highlight;
      extraConfig = ''
        set -g @prefix_highlight_prefix_prompt 'Wait'
        set -g @prefix_highlight_copy_prompt 'Copy'
        set -g @prefix_highlight_sync_prompt 'Sync'
      '';
    }
    {
      plugin = sidebar;
      extraConfig = ''
        set -g @sidebar-tree-command '${pkgs.lsd}/bin/lsd --tree --color always'
      '';
    }
  ];

  extraConfig = ''
    set-option -g default-terminal "screen-256color"
    set-option -a terminal-features 'xterm-256color:RGB'

    bind  c  new-window      -c "#{pane_current_path}"
    bind  %  split-window -h -c "#{pane_current_path}"
    bind '"' split-window -v -c "#{pane_current_path}"

    # Use v to trigger selection    
    bind-key -T copy-mode-vi v send-keys -X begin-selection

    # Use y to yank current selection
    bind-key -T copy-mode-vi y send-keys -X copy-selection

    bind f run-shell '~/.scripts/tmux-scratch.sh'

    bind r source-file ~/.config/tmux/tmux.conf
  '';
}
