#!/bin/bash

swayidle -w \
		timeout 15 'swaymsg "output "*" power off"' \
		resume 'swaymsg "output "*" power on"' &
swaylock
pkill --newest swayidle
