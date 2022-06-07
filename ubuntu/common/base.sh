#!/bin/bash

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

# VIM CUSTOMIZATIONS
cat >> /home/${username}/.vimrc << EOF
syntax on
colorscheme slate
set mouse=v
EOF
chown ${username}:users /home/${username}/.vimrc
cp /home/${username}/.vimrc /root/