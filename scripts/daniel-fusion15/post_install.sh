#!/usr/bin/bash

if [ -n "$SUDO_HOME" ]; then
  user_home="$SUDO_HOME"
else
  user_home="$HOME"
fi

SETUP_DIR=${SETUP_DIR:-$user_home/linux-setup}

source "$SETUP_DIR/lib/enable_start_service.sh"

###

if pacman -Q | grep -w 'thermald' >/dev/null; then
  enable_start_service "thermald.service"
fi

if pacman -Q | grep -w 'intel-undervolt' >/dev/null; then
  enable_start_service "intel-undervolt.service"
fi

if pacman -Q | grep -w 'tuxedo-control-center' >/dev/null; then
  enable_start_service "tccd.service"
fi
