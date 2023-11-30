#!/usr/bin/env bash

swayidle -w \
  before-sleep "playerctl pause" \
  before-sleep "swaylock -f" \
  timeout 600 'swaylock -f' \
  timeout 610 'swaymsg "output \"*\" power off"' \
  resume 'swaymsg "output \"*\" power on"'
