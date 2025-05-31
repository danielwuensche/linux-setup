#!/usr/bin/bash

SETUP_DIR=${SETUP_DIR:-$HOME/linux-setup}

kernel_params=(
i8042.noaux
pci=realloc,assign-busses,hpbussize=0x33
)

boot_line=$(grep -E '^GRUB_CMDLINE_LINUX_DEFAULT=.*"$' /etc/default/grub)
#echo "$boot_line"
to_add=""
for p in ${kernel_params[@]}; do
    case $boot_line in
        *$p*)
            #echo "$p is already there"
        ;;
        *)
            #echo "$p is missing"
            to_add="$to_add $p"
        ;;
    esac
done

if [[ -n "$to_add" ]]; then
    boot_line_new="${boot_line:0:-1}${to_add}${boot_line:0-1}"
    #echo $boot_line_new
    regex='s/^GRUB_CMDLINE_LINUX_DEFAULT=".*"$/'"${boot_line_new}/"
    echo "adding kernel boot parameters: $to_add"
    sudo sed -e "${regex}" -i /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
else
    echo "nothing to do, all parameters already present"
fi
