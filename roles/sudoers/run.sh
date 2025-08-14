#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

###

###
# sudoers
source="${current_dir}/files/daniel"
target=/etc/sudoers.d/daniel
copy "$source" "$target" --mode="440" --owner="root" --group="root"
