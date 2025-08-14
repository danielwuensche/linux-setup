#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

source "$SETUP_DIR/lib/packages.sh"
source "$SETUP_DIR/lib/enable_start_service.sh"

packages__arch=(
    "tuxedo-control-center"
    "tuxedo-drivers-dkms"
)

###

### packages
var_packages="packages__$distro"
cmd_packages_install_missing "${!var_packages}"

### tuxedo-control-center
source="${current_dir}/files/profiles__$(hostname)"
target="/etc/tcc/profiles"
if ! [ -f "$source" ]; then
    echo "source file $source doesn't exist, skipping..." >&2
    exit 1
fi
copy "$source" "$target" --mode="644" --owner="root" --group="root"

source="${current_dir}/files/settings__$(hostname)"
target=/etc/tcc/settings
if ! [ -f "$source" ]; then
    echo "source file $source doesn't exist, skipping..." >&2
    exit 1
fi
copy "$source" "$target" --mode="644" --owner="root" --group="root"

### service

if cmd_packages_list_installed | grep -w 'tuxedo-control-center' >/dev/null; then
    enable_start_service "tccd.service"
fi
