#!/bin/bash

packages=$(echo ${PACKAGES} | sed "s/__/ /g")
aurpackages=$(echo ${AURPACKAGES} | sed "s/__/ /g")

# Remove unwanted virtualbox-guest-utils if installed (should install virtualbox-guest-utils)
if pacman -Q virtualbox-guest-utils-nox > /dev/null 2>&1; then
  pacman -Rsn virtualbox-guest-utils-nox --noconfirm
fi

pacman -S ${packages} --noconfirm

# AUR Pakages
for package in ${aurpackages}; do
  aurdir="\${HOME}/Documents/aur"
  su ${username} -c "mkdir -p ${aurdir}"
  su ${username} -c "cd ${aurdir} && git clone https://aur.archlinux.org/${package}.git"
  su ${username} -c "cd ${aurdir}/${package}/ && makepkg -si --noconfirm"
  su ${username} -c "sudo rm -rf ${aurdir}"
done

# Cleanup unneeded dependencies
pacman -Rs $(pacman -Qtdq) --noconfirm

# Add user to docker group if installed
if pacman -Q docker > /dev/null 2>&1; then
  usermod -aG docker ${username}
fi