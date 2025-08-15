#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

###

# grub
source="${current_dir}/files/grub__$(hostname)"
target="/etc/default/grub"
if ! [ -f "$source" ]; then
    echo "source file $source doesn't exist, skipping the role." >&2
    exit 1
fi

copy "$source" "$target" --mode="644" --owner="root" --group="root"
if [ $? -eq 9 ]; then
    echo "Generating grub-config..."
    $sudo grub-mkconfig -o /boot/grub/grub.cfg
fi
