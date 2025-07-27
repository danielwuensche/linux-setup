#!/usr/bin/bash

if [ -n "$SUDO_NAME" ]; then
  user_name="$SUDO_NAME"
else
  user_name="$NAME"
fi

if [ -n "$SUDO_HOME" ]; then
  user_home="$SUDO_HOME"
else
  user_home="$HOME"
fi

SETUP_DIR=${SETUP_DIR:-$user_home/linux-setup}

source "$SETUP_DIR/lib/copy.sh"

###

# configure SDDM to use Wayland
target="/etc/sddm.conf.d/10-wayland.conf"
source="${SETUP_DIR}/files${target}"
copy "$source" "$target" --mode="644" --owner="root" --group="root"

# aliases
target="/home/daniel/.aliases"
source="${SETUP_DIR}/files/.aliases"
copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"
if [[ -f "${source}-local_$(hostname)" ]]; then
  target="${target}-local_$(hostname)"
  source="${source}-local_$(hostname)"
  copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"
fi

# profile
target="/home/daniel/.profile"
source="${SETUP_DIR}/files/.profile"
copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"
if [[ -f "${source}-local_$(hostname)" ]]; then
  target="${target}-local_$(hostname)"
  source="${source}-local_$(hostname)"
  copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"
fi

# git
target=/home/daniel/.gitconfig
source="${SETUP_DIR}/files/.gitconfig"
copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"
