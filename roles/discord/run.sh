#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

if [ "$user_name" == "root" ]; then
    echo "not installing discord for root..." >&2
    exit 1
fi

# discord
source="${current_dir}/files/discord.sh"
target="$user_home/.local/bin/discord.sh"
copy "$source" "$target" --mode="744" --owner="$user_name" --group="$user_name"

source="${current_dir}/files/discord.desktop"
target="$user_home/.local/share/applications/discord.desktop"
copy "$source" "$target" --mode="755" --owner="$user_name" --group="$user_name"
