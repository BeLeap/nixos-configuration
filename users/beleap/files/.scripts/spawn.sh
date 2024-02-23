#!/bin/sh

SESSIONS=("config" "personal" "work")

for SESSION in ${SESSIONS[@]}
do
  tmuxp load -d $HOME/.tmuxp/${SESSION}.yaml
done

tmux attach -t config
