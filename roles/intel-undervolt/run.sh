#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

source "$SETUP_DIR/lib/packages.sh"
source "$SETUP_DIR/lib/enable_start_service.sh"

packages__arch=("intel-undervolt")
###

### packages
var_packages="packages__$distro"
cmd_packages_install_missing "${!var_packages}"

### intel-undervolt
source="${current_dir}/files/intel-undervolt.conf__$(hostname)"
target="/etc/intel-undervolt.conf"
if ! [ -f "$source" ]; then
    echo "source file $source doesn't exist, skipping..." >&2
    exit 1
fi
copy "$source" "$target" --mode="644" --owner="root" --group="root"

source="${current_dir}/files/override.conf__$(hostname)"
target="/etc/systemd/system/intel-undervolt.service.d/override.conf"
if ! [ -f "$source" ]; then
    echo "source file $source doesn't exist, skipping..." >&2
    exit 1
fi
copy "$source" "$target" --mode="644" --owner="root" --group="root"

### service

if cmd_packages_list_installed | grep -w 'intel-undervolt' >/dev/null; then
    enable_start_service "intel-undervolt.service"
fi
