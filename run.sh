#!/usr/bin/bash

cd "$(dirname "$0")" || exit 1

if [ -n "$SUDO_USER" ]; then
    user_name="$SUDO_USER"
else
    user_name="$NAME"
fi

if [ -n "$SUDO_HOME" ]; then
    user_home="$SUDO_HOME"
else
    user_home="$HOME"
fi

SETUP_DIR=${SETUP_DIR:-$user_home/linux-setup}

###

scripts=(
    scripts/system.sh
    scripts/packages.sh
    scripts/config.sh
)

host_scripts=(
    "scripts/$(hostname)/config.sh"
    "scripts/$(hostname)/post_install.sh"
)

###
# checkdistro to later import correct stuff

distro_by_file=$(grep 'DISTRIB_ID=' /etc/lsb-release | sed -E 's/(DISTRIB_ID="|"$)//g')
echo "current distro: $distro_by_file"
case $distro_by_file in
"ManjaroLinux")
    distro="arch"
    ;;
*)
    echo "Error: distro not recognized!"
    exit 1
    ;;
esac

###
# export variables
export user_name
export user_home
export SETUP_DIR
export distro

###
# run scripts
for s in "${host_scripts[@]}"; do
    [ -f "$s" ] && scripts+=("$s")
done

for s in "${scripts[@]}"; do
    echo "Running $(pwd)/${s}..."
    bash "$s"
done

echo "Press Enter to exit..."
read -r
