#!/bin/bash

packages=$(echo ${PACKAGES} | sed "s/__/ /g")
aurpackages=$(echo ${AURPACKAGES} | sed "s/__/ /g")

# Remove unwanted virtualbox-guest-utils if installed (should install virtualbox-guest-utils)
if pacman -Q virtualbox-guest-utils-nox > /dev/null 2>&1; then
  pacman -Rsn virtualbox-guest-utils-nox --noconfirm
fi

# If appcenter is in wanted, remove file to make possible
if [[ $(echo ${aurpackages} | grep appcenter) ]]; then
  rm -f /etc/io.elementary.appcenter/appcenter.hiddenapps
fi

pacman -S ${packages} --noconfirm

# Chaotic AUR
pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
pacman-key --lsign-key FBA220DFC880C036
pacman --noconfirm -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

cat >> /etc/pacman.conf << EOF
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF

pacman -Sy

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