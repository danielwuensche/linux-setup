#!/usr/bin/bash

source "$SETUP_DIR/lib/packages.sh"

packages__arch=(
    thunderbird
)

var_packages="packages__$distro"

if [ -n "${!var_packages}" ]; then
    cmd_packages_install_missing "${!var_packages[@]}"
fi
