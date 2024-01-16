if [ "$(tmux display-message -p -F "#{session_name}")" = "scratch" ];then
    tmux detach-client
else
    tmux popup -E "tmux attach -t scratch || tmux new -s scratch"
fi
