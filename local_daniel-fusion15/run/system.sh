#!/usr/bin/bash

SETUP_DIR=${SETUP_DIR:-$HOME/linux-setup}

# intel-undervolt
sudo pamac install intel-undervolt
source_file="${SETUP_DIR}/local_$(hostname)/data/etc/intel-undervolt.conf"
if [[ -f "$source_file" ]]; then
    sudo cp $source_file /etc/intel-undervolt.conf
    sudo chown root:root /etc/intel-undervolt.conf
    sudo chmod 0644 /etc/intel-undervolt.conf
sudo mkdir -p /etc/systemd/system/intel-undervolt.service.d
source_file="${SETUP_DIR}/local_$(hostname)/data/etc/systemd/system/intel-undervolt.service.d/override.conf"
sudo cp $source_file /etc/systemd/system/intel-undervolt.service.d/override.conf
sudo chown root:root /etc/systemd/system/intel-undervolt.service.d/override.conf
sudo chmod 0644 /etc/systemd/system/intel-undervolt.service.d/override.conf
sudo systemctl enable --now intel-undervolt

# qc71 driver
sudo pamac install tuxedo-drivers-dkms tuxedo-control-center
source_file="${SETUP_DIR}/local_$(hostname)/data/etc/tcc/profiles"
sudo cp $source_file /etc/tcc/profiles
sudo chown root:root /etc/tcc/profiles
sudo chmod 0644 /etc/tcc/profiles
source_file="${SETUP_DIR}/local_$(hostname)/data/etc/tcc/settings"
sudo cp $source_file /etc/tcc/settings
sudo chown root:root /etc/tcc/settings
sudo chmod 0644 /etc/tcc/settings
