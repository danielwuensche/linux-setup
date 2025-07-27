#!/usr/bin/bash

if [ -n "$SUDO_HOME" ]; then
  user_home="$SUDO_HOME"
else
  user_home="$HOME"
fi

SETUP_DIR=${SETUP_DIR:-$user_home/linux-setup}

source "$SETUP_DIR/vars/pacman.sh"

###

packages_installed=$(pacman -Q | awk '{print $1}')

packages_missing=()
for p in "${packages[@]}"; do
  found=$(echo "$packages_installed" | grep -w "$p")
  [ -n "$found" ] || packages_missing+=("$p")
done

if [ -n "$missing" ]; then
  echo "Installing packages:"
  echo "$(
    IFS=', '
    echo "${missing[*]}"
  )"
  pacman -S "${missing[@]}"
fi
