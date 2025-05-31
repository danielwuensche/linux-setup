#!/usr/bin/bash

SETUP_DIR=${SETUP_DIR:-$HOME/linux-setup}

# keyboard 
sudo pamac install python-ite8291r3-ctl
source_file="${SETUP_DIR}/local_$(hostname)/data/etc/udev/rules.d/99-ite8291.rules"
if [[ -f "$source_file" ]]; then
    sudo cp $source_file /etc/udev/rules.d/99-ite8291.rules
    sudo chown root:root /etc/udev/rules.d/99-ite8291.rules
    sudo chmod 0644 /etc/udev/rules.d/99-ite8291.rules
sudo udevadm control --reload
sudo udevadm trigger
