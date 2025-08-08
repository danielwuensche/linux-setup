#!/usr/bin/bash

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

# discord
target=/home/daniel/.local/bin/discord.sh
source="${SETUP_DIR}/files/.local/bin/discord.sh"
copy "$source" "$target" --mode="744" --owner="$user_name" --group="$user_name"

target=/home/daniel/.local/share/applications/discord.desktop
source="${SETUP_DIR}/files/.local/share/applications/discord.desktop"
copy "$source" "$target" --mode="755" --owner="$user_name" --group="$user_name"
