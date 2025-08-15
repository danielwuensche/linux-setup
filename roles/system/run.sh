#!/usr/bin/bash

pacman_mirrors_countries=(
    Germany
    Netherlands
    Austria
)

###

### NTP
if ! (timedatectl show | grep -q -w 'NTP=yes'); then
    echo "Enabling NTP sync."
    $sudo timedatectl set-ntp 1 || exit 1
fi

if [ "$distro" == "arch" ]; then
    source "$SETUP_DIR/lib/$distro/system.sh"

    ### pacman mirrors
    configure_pacman_mirrors "${pacman_mirrors_countries[@]}"
fi
