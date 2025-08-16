#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

if [ "$user_name" == "root" ]; then
    echo "not installing envvars for root..." >&2
    exit 0
fi

# aliases
source="${current_dir}/files/envvars.conf"
target="$user_home/.config/environment.d/envvars.conf"
copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"
