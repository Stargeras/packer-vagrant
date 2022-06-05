#!/bin/bash

packages="xserver-xorg-core xdg-user-dirs sudo ssh vim curl bash-completion git debootstrap arch-install-scripts \
firmware-realtek firmware-misc-nonfree firmware-libertas firmware-iwlwifi firmware-intelwimax firmware-linux open-vm-tools"

cat > /etc/apt/sources.list << EOF
deb http://deb.debian.org/debian/ ${CODENAME} main contrib non-free
deb-src http://deb.debian.org/debian/ ${CODENAME} main contrib non-free

deb http://deb.debian.org/debian/ ${CODENAME}-updates main contrib non-free
deb-src http://deb.debian.org/debian/ ${CODENAME}-updates main contrib non-free

EOF

if [[ ${USESECURITYREPO} == "true" ]]; then
  cat >> /etc/apt/sources.list << EOF
deb http://deb.debian.org/debian-security/ ${CODENAME}-security main contrib non-free
deb-src http://deb.debian.org/debian-security/ ${CODENAME}-security main contrib non-free
EOF
fi

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

usermod -aG sudo,netdev,disk ${username}
echo "${username}:${username}" |chpasswd
echo 'root:root' | chpasswd

cat >> /etc/sudoers << EOF
%sudo ALL=(ALL) NOPASSWD: ALL
EOF

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