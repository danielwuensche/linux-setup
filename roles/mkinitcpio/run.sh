#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

###

need_regen=0

# copy additional files
source="${current_dir}/files/$(hostname)/edid/lg-34gn850.bin"
target="/usr/lib/firmware/edid/lg-34gn850.bin"
[ -f "$source" ] && copy "$source" "$target" --mode="755" --owner="root" --group="root"
[ $? -eq 9 ] && need_regen=1

# mkinitcpio.conf
source="${current_dir}/files/mkinitcpio.conf__$(hostname)"
target="/etc/mkinitcpio.conf"
if ! [ -f "$source" ]; then
    echo "source file $source doesn't exist, skipping the role." >&2
    exit 1
fi
copy "$source" "$target" --mode="644" --owner="root" --group="root"
[ $? -eq 9 ] && need_regen=1

if [ "$need_regen" -eq 1 ]; then
    echo "Running mkinitcpio..."
    $sudo mkinitcpio -P
fi
