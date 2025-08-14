#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

# configure SDDM to use Wayland
source="${current_dir}/files/10-wayland.conf"
target="/etc/sddm.conf.d/10-wayland.conf"
copy "$source" "$target" --mode="644" --owner="root" --group="root"
