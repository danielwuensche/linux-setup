#!/usr/bin/bash

source "$SETUP_DIR/vars/$distro/system.sh"
source "$SETUP_DIR/lib/$distro/system.sh"

###

### NTP
if ! (timedatectl show | grep -q -w 'NTP=yes'); then
    echo "Enabling NTP sync."
    timedatectl set-ntp 1 || exit 1
fi

if [ "$distro" == "arch" ]; then
    ### pacman mirrors
    configure_pacman_mirrors "${pacman_mirrors_countries[@]}"
fi
