#!/bin/bash

sleep 10
pacman -Sy

packages="linux-headers-(uname -r) libisoburn virtualbox-guest-iso"
dir="/root/media"

pacman -S ${packages} --noconfirm

mkdir ${dir}
xorriso -osirrox on -indev /usr/lib/virtualbox/additions/VBoxGuestAdditions.iso -extract / ${dir}/
echo "yes" | bash ${dir}/VBoxLinuxAdditions.run
rm -rf ${dir}