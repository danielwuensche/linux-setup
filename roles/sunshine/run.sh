#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

source "$SETUP_DIR/lib/packages.sh"
source "$SETUP_DIR/lib/enable_start_service.sh"

packages__arch=(
    "lizardbyte/sunshine"
)

###

### packages
var_packages="packages__$distro"
cmd_packages_install_missing "${!var_packages}"

### sunshine conf
source="${current_dir}/files/apps.json"
target="$user_home/.config/sunshine/apps.json"
copy "$source" "$target" --mode="644" --owner="$user_name" --group="$user_name"

### allow KMS capture
if ! (getcap $(readlink -f $(which sunshine)) | grep -E 'cap_sys_admin=p' >/dev/null); then
    echo "Setting capability for sunshine to allow KMS capture." >&2
    setcap cap_sys_admin+p $(readlink -f $(which sunshine))
fi

### enable service
if cmd_packages_list_installed | grep -w 'sunshine' >/dev/null; then
    enable_start_service_user "sunshine.service"
fi

