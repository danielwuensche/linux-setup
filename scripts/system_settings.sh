#!/usr/bin/bash

if [ -n "$SUDO_HOME" ]; then
  user_home="$SUDO_HOME"
else
  user_home="$HOME"
fi

SETUP_DIR=${SETUP_DIR:-$user_home/linux-setup}

source "$SETUP_DIR/vars/pacman.sh"

###

### NTP
if ! (timedatectl show | grep -q -w 'NTP=yes'); then
  echo "Enabling NTP sync."
  timedatectl set-ntp 1 || exit 1
fi

### pacman mirrors
mirrors=("$(echo "${pacman_mirrors_countries[@]}" | tr ' ' '\n' | sort)")
mirrors_current=("$(pacman-mirrors -lc | sort)")

if [ "${mirrors[*]}" != "${mirrors_current[*]}" ]; then
  echo "Desired mirrors: ${mirrors[*]}"
  echo "Current mirrors: ${mirrors_current[*]}"
  mirrors_formatted=$(
    IFS=,
    echo "${pacman_mirrors_countries[*]}"
  )
  echo "Current Mirrors: ${mirrors_current[*]}"
  echo "Setting pacman-mirrors countries to ${mirrors_formatted[*]}"
  pacman-mirrors -c "${mirrors_formatted}"
fi
