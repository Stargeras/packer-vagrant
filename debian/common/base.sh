#!/bin/bash

packages="xserver-xorg-core xdg-user-dirs sudo ssh vim curl bash-completion git debootstrap arch-install-scripts \
firmware-realtek firmware-misc-nonfree firmware-libertas firmware-iwlwifi firmware-intelwimax firmware-linux open-vm-tools"

cat > /etc/apt/sources.list << EOF
deb http://deb.debian.org/debian/ ${CODENAME} main contrib non-free
deb-src http://deb.debian.org/debian/ ${CODENAME} main contrib non-free
deb http://deb.debian.org/debian/ ${CODENAME}-updates main contrib non-free
deb-src http://deb.debian.org/debian/ ${CODENAME}-updates main contrib non-free
EOF
apt update
apt install -y ${packages}

#apt update
#apt upgrade -y

systemctl disable unattended-upgrades

mkdir ${BUILDDIR}

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
echo debian-$(cat /etc/apt/sources.list | head -1 | awk '{print$3}') > /etc/hostname

useradd -m -g users -s /bin/bash ${username}
usermod -aG ${username} sudo,netdev,disk
cat >> /etc/sudoers << EOF
%sudo ALL=(ALL) NOPASSWD: ALL
EOF
echo "${username}:${username}" |chpasswd
echo 'root:root' | chpasswd
#add home dirs
su ${username} -c 'xdg-user-dirs-update'

# VIM CUSTOMIZATIONS
cat >> /home/${username}/.vimrc << EOF
syntax on
colorscheme slate
set mouse=v
EOF
chown ${username}:users /home/${username}/.vimrc
cp /home/${username}/.vimrc /root/