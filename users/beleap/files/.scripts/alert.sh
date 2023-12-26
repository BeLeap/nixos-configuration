#!/usr/bin/env bash

SOUND_ROOT=$(nix path-info "nixpkgs#sound-theme-freedesktop" --json | jq -r '.[].path')
mpv $SOUND_ROOT/share/sounds/freedesktop/stereo/message.oga
