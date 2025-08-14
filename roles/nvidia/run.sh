#!/usr/bin/bash

source "$SETUP_DIR/lib/copy.sh"
current_dir="$(dirname "$0")"

source "$SETUP_DIR/lib/packages.sh"

packages__arch=(
    "$(pacman -Q | awk '{print $1}' | grep -P 'linux\d+$')-nvidia-open"
)

###

### packages
var_packages="packages__$distro"
cmd_packages_install_missing "${!var_packages}"
###

### nvidia
# nvidia module options
source="${current_dir}/files/nvidia-pm.conf"
target=/etc/modprobe.d/nvidia-pm.conf
copy "$source" "$target" --mode="644" --owner="root" --group="root"

# wayland session for dGPU-only mode
source="${current_dir}/files/plasmawayland-dgpu.desktop"
target=/usr/share/wayland-sessions/plasmawayland-dgpu.desktop
copy "$source" "$target" --mode="644" --owner="root" --group="root"

source="${current_dir}/files/plasmawayland-dgpu"
target=/usr/local/bin/plasmawayland-dgpu
copy "$source" "$target" --mode="755" --owner="root" --group="root"

# wayland session for iGPU-only mode
source="${current_dir}/files/plasmawayland-igpu.desktop"
target=/usr/share/wayland-sessions/plasmawayland-igpu.desktop
copy "$source" "$target" --mode="644" --owner="root" --group="root"

source="${current_dir}/files/plasmawayland-igpu"
target=/usr/local/bin/plasmawayland-igpu
copy "$source" "$target" --mode="755" --owner="root" --group="root"

# script to turn off dGPU
source="${current_dir}/files/gpuoff"
target=/usr/local/bin/gpuoff
copy "$source" "$target" --mode="755" --owner="root" --group="root"
