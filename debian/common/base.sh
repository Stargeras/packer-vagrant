#!/bin/bash

components=$(echo ${COMPONENTS} | sed "s/__/ /g")

packages="xserver-xorg-core xdg-user-dirs sudo ssh vim curl bash-completion git debootstrap arch-install-scripts \
firmware-realtek firmware-misc-nonfree firmware-libertas firmware-iwlwifi firmware-linux open-vm-tools"

apt update
apt upgrade -y
apt install -y software-properties-common

for component in ${components}; do
  apt-add-repository ${component}
done

apt update
apt install -y ${packages}

systemctl disable unattended-upgrades

# SET TIMEZONE
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

# OTHER CUSTOMIZATIONS
cat >> /etc/bash.bashrc << EOF
alias ls='ls --color=auto'
alias ll='ls -l'
alias ram='ps axch -o cmd:15,%mem --sort=-%mem | head'
alias cpu='ps axch -o cmd:15,%cpu --sort=-%cpu | head'
#needs youtube-dl
alias ytdm='youtube-dl --extract-audio --audio-format mp3'
alias ytdv='youtube-dl -f bestvideo+bestaudio'
EOF
cp /etc/skel/.bashrc /root/

useradd -m -g users -s /bin/bash -G wheel,storage,power ${username}
usermod -aG sudo,netdev,disk ${username}
echo "${username}:${username}" |chpasswd
echo 'root:root' | chpasswd

cat >> /etc/sudoers << EOF
%sudo ALL=(ALL) NOPASSWD: ALL
EOF

#add home dirs
su ${username} -c 'xdg-user-dirs-update'

#cat > /etc/apt/sources.list << EOF
#deb http://deb.debian.org/debian/ ${CODENAME} ${components}
#deb-src http://deb.debian.org/debian/ ${CODENAME} ${components}
#
#deb http://deb.debian.org/debian/ ${CODENAME}-updates ${components}
#deb-src http://deb.debian.org/debian/ ${CODENAME}-updates ${components}
#EOF
#
#if [[ ${USESECURITYREPO} == "true" ]]; then
#  cat >> /etc/apt/sources.list << EOF
#deb http://deb.debian.org/debian-security/ ${CODENAME}-security ${components}
#deb-src http://deb.debian.org/debian-security/ ${CODENAME}-security ${components}
#EOF
#fi
