#!/usr/bin/bash

source "$SETUP_DIR/lib/packages.sh"
source "$SETUP_DIR/lib/enable_start_service.sh"

packages__arch=("thermald")
###

### packages
var_packages="packages__$distro"
cmd_packages_install_missing "${!var_packages}"

###

if cmd_packages_list_installed | grep -w 'thermald' >/dev/null; then
    enable_start_service "thermald.service"
fi
