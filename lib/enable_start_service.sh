#!/usr/bin/bash

enable_start_service() {
  [ $# -eq 1 ] && service="$1"
  [ $# -lt 1 ] && echo "Error: no argument specified." >&2 && exit 1
  [ $# -gt 1 ] && echo "Error: too many arguments." >&2 && exit 1

  if ! systemctl -q is-enabled "$service"; then
    echo "Enabling $service..."
    if ! systemctl enable "$service" >/dev/null; then
      echo "Failed to enable $service" >&2
      exit 1
    fi
  fi

  if ! systemctl -q is-active "$service"; then
    echo "Starting $service..."
    if ! systemctl start "$service" >/dev/null; then
      echo "Failed to start $service" >&2
      exit 1
    fi
  fi
}
