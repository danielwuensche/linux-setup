#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"

###

# grub
target="/etc/default/grub"
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="644" --owner="root" --group="root"
if [ $? -eq 9 ]; then
    echo "Generating grub-config..."
    grub-mkconfig -o /boot/grub/grub.cfg
fi

### intel-undervolt
target="/etc/intel-undervolt.conf"
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="644" --owner="root" --group="root"

target="/etc/systemd/system/intel-undervolt.service.d/override.conf"
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="644" --owner="root" --group="root"

### tuxedo-control-center
target="/etc/tcc/profiles"
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="644" --owner="root" --group="root"

target=/etc/tcc/settings
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="644" --owner="root" --group="root"

### nvidia
# nvidia module options
target=/etc/modprobe.d/nvidia-pm.conf
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="644" --owner="root" --group="root"

# wayland session for dGPU-only mode
target=/usr/share/wayland-sessions/plasmawayland-dgpu.desktop
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="644" --owner="root" --group="root"

target=/usr/local/bin/plasmawayland-dgpu
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="755" --owner="root" --group="root"

# wayland session for iGPU-only mode
target=/usr/share/wayland-sessions/plasmawayland-igpu.desktop
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="644" --owner="root" --group="root"

target=/usr/local/bin/plasmawayland-igpu
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="755" --owner="root" --group="root"

# script to turn off dGPU
target=/usr/local/bin/gpuoff
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="755" --owner="root" --group="root"

###
# keyboard
target=/etc/udev/rules.d/99-ite8291.rules
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="644" --owner="root" --group="root"
if [ $? -eq 1 ]; then
    echo "Reloading and triggering udev rules..."
    udevadm control --reload
    udevadm trigger
fi

###
# sudoers
target=/etc/sudoers.d/daniel
source="${SETUP_DIR}/files/$(hostname)${target}"
copy "$source" "$target" --mode="440" --owner="root" --group="root"
