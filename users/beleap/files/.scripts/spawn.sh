#!/bin/sh

SESSIONS=("config" "personal" "work")

for SESSION in ${SESSIONS[@]}
do
  tmuxinator start $SESSION
done

tmux attach -t config
