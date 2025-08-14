#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

if [ "$user_name" == "root" ]; then
    echo "not installing dotfiles for root..." >&2
    exit 0
fi

# aliases
source="${current_dir}/files/.aliases"
target="$user_home/.aliases"
copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"
if [[ -f "${source}-local_$(hostname)" ]]; then
    target="${target}-local_$(hostname)"
    source="${source}-local_$(hostname)"
    copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"
fi

# profile
source="${current_dir}/files/.profile"
target="$user_home/.profile"
copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"
if [[ -f "${source}-local_$(hostname)" ]]; then
    target="${target}-local_$(hostname)"
    source="${source}-local_$(hostname)"
    copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"
fi

# git
source=${current_dir}/files/.gitconfig
target="$user_home/.gitconfig"
copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"
