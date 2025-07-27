#!/usr/bin/bash

cd "$(dirname "$0")" || exit 1

###

scripts=(
  scripts/system_settings.sh
  scripts/packages.sh
  scripts/config.sh
)

host_scripts=(
  "scripts/$(hostname)/config.sh"
  "scripts/$(hostname)/post_install.sh"
)

for s in "${host_scripts[@]}"; do
  [ -f "$s" ] && scripts+=("$s")
done

for s in "${scripts[@]}"; do
  echo "Running $(pwd)/${s}..."
  bash "$s" || exit 1
done
