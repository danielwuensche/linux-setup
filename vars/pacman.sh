#!/usr/bin/bash

true

#shellcheck disable=2034
pacman_mirrors_countries=(
  Germany
  Netherlands
  Austria
)

packages=(
  brave-browser
  thunderbird
  neovim
  unzip
  ripgrep
  python-pynvim
)

packages__daniel_fusion15=(
  thermald
  intel-undervolt
  tuxedo-control-center
  tuxedo-drivers-dkms
  "$(pacman -Q | awk '{print $1}' | grep -P 'linux\d+$')-nvidia-open"
  python-ite8291r3-ctl
)

###

# packages
host=$(hostname | sed -e 's/-/_/g') # convert - to _ since variables can't contain dashes
var_name="packages__${host}"        # store variable name in a variable and use said variable value as the variable name in the next line
if [ -n "${!var_name}" ]; then      # var_name gets replaced by the value of var_name
  packages+=("${packages__daniel_fusion15[@]}")
fi
