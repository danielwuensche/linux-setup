#!/usr/bin/bash

sources=(
    "$SETUP_DIR/vars/$distro/packages.sh"
    "$SETUP_DIR/lib/packages.sh"
)
for source in "${sources[@]}"; do
    [ -f "$source" ] && source "$source"
done

###

cmd_packages_install_missing "${packages[@]}"
