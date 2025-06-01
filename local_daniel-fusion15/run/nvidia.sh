#!/usr/local/bin/bash

SETUP_DIR=${SETUP_DIR:-$HOME/linux-setup}

# find current linux kernel
current_linux=pamac list -iq | grep -P 'linux\d+$'
sudo pamac install ${current_linux}-nvidia-open

# nvidia module options
source_file="${SETUP_DIR}/local_$(hostname)/data/etc/modprobe.d/nvidia-pm.conf"
if [[ -f "$source_file" ]]; then
    sudo cp $source_file /etc/modprobe.d/nvidia-pm.conf
    sudo chown root:root /etc/modprobe.d/nvidia-pm.conf
    sudo chmod 0644 /etc/modprobe.d/nvidia-pm.conf
fi

# wayland session for dGPU-only mode
source_file="${SETUP_DIR}/local_$(hostname)/data/usr/share/wayland-sessions/plasmawayland-dgpu.desktop"
sudo cp $source_file /usr/share/wayland-sessions/plasmawayland-dgpu.desktop
sudo chown root:root /usr/share/wayland-sessions/plasmawayland-dgpu.desktop
sudo chmod 0644 /usr/share/wayland-sessions/plasmawayland-dgpu.desktop

source_file="${SETUP_DIR}/local_$(hostname)/data/usr/local/bin/plasmawayland-dgpu"
sudo cp $source_file /usr/local/bin/plasmawayland-dgpu
sudo chown root:root /usr/local/bin/plasmawayland-dgpu
sudo chmod 0755 /usr/local/bin/plasmawayland-dgpu

# scripts to disable/enable dgpu
sudo pamac install ${current_linux}-acpi_call

source_file="${SETUP_DIR}/local_$(hostname)/data/usr/local/bin/gpuoff"
sudo cp $source_file /usr/local/bin/gpuoff
sudo chown root:root /usr/local/bin/gpuoff
sudo chmod 0755 /usr/local/bin/gpuoff

source_file="${SETUP_DIR}/local_$(hostname)/data/usr/local/bin/gpuon"
sudo cp $source_file /usr/local/bin/gpuon
sudo chown root:root /usr/local/bin/gpuon
sudo chmod 0755 /usr/local/bin/gpuon
