#!/run/current-system/sw/bin/bash

PATH=/run/wrappers/bin:/home/beleap/.nix-profile/bin:/nix/profile/bin:/home/beleap/.local/state/nix/profile/bin:/etc/profiles/per-user/beleap/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin
SOUND_ROOT=$(nix path-info "nixpkgs#sound-theme-freedesktop" --json | jq -r '.[].path')
mpv $SOUND_ROOT/share/sounds/freedesktop/stereo/message.oga
