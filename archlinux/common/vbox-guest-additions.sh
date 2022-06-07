#!/bin/bash

pacman -Sy

packages="linux-headers libisoburn virtualbox-guest-iso"
dir="/root/media"

pacman -S ${packages} --noconfirm

mkdir ${dir}
xorriso -osirrox on -indev /usr/lib/virtualbox/additions/VBoxGuestAdditions.iso -extract / ${dir}/
bash ${dir}/VBoxLinuxAdditions.run
rm -rf ${dir}