#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

source "$SETUP_DIR/lib/packages.sh"

packages__arch=("python-ite8291r3-ctl")
###

### packages
var_packages="packages__$distro"
cmd_packages_install_missing "${!var_packages}"
###

###
# keyboard
source="${current_dir}/files/99-ite8291.rules"
target=/etc/udev/rules.d/99-ite8291.rules
copy "$source" "$target" --mode="644" --owner="root" --group="root"
if [ $? -eq 1 ]; then
    echo "Reloading and triggering udev rules..."
    udevadm control --reload
    udevadm trigger
fi
