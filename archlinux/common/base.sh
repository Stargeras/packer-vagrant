#!/bin/bash

packages="base-devel git bash-completion curl wget htop vi vim \
xorg-server xorg-apps xorg-xinit xdg-user-dirs open-vm-tools  htop \
xf86-video-vesa xf86-video-vmware xf86-video-intel xf86-video-amdgpu xf86-video-nouveau virtualbox-guest-utils"

# PACMAN INIT
pacman-key --init && pacman-key --populate

# REMOVE BROKEN MIRRORS
brokenmirrors="evowise"
for mirror in ${brokenmirrors}; do
  sed -i "/${mirror}/d" /etc/pacman.d/mirrorlist
done

# FIX PACMAN SPACE ERROR
sed -i '/CheckSpace/d' /etc/pacman.conf

# UPDATE PACKAGES
pacman -Syu --noconfirm

# LOCALIZATION
echo "LANG=en.US.UTF-8" >> /etc/locale.gen
locale-gen

# USE REFLECTOR TO RATE MIRRORS
#pacman -S reflector --noconfirm
#reflector --verbose --country 'United States' --sort rate --save /etc/pacman.d/mirrorlist

# INSTALL PACKAGES
#pacman -Rsn clonezilla lftp nmap openconnect --noconfirm

pacman -Rsn virtualbox-guest-utils-nox --noconfirm
pacman -S ${packages} --noconfirm

# ADD KERNEL TO PACMAN EXCEPTION
cat >> /etc/pacman.conf << EOF
[options]
IgnorePkg  = linux
EOF

# SET TIMEZONE
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

# CREATE USER ACCOUNT
useradd -m -g users -s /bin/bash -G wheel,storage,power ${username}
usermod -aG wheel,storage,power ${username}

# ALLOW WHEEL SUDO
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# SET DEFAULT PWS
echo "${username}:${username}" |chpasswd
echo 'root:root' | chpasswd

# CREATE HOME DIRS
su ${username} -c "xdg-user-dirs-update"
cp /etc/X11/xinit/xinitrc /home/${username}/.xinitrc
sed -i "$ d" /home/${username}/.xinitrc
chmod +x /home/${username}/.xinitrc
chown ${username}:users /home/${username}/.xinitrc

# ADD BASHRC CUSTOMIZATIONS
cat >> /etc/bash.bashrc << EOF
alias ls='ls --color=auto'
alias ll='ls -l'
alias ram='ps axch -o cmd:15,%mem --sort=-%mem | head'
alias cpu='ps axch -o cmd:15,%cpu --sort=-%cpu | head'
#export PS1="\[\e[31m\]\u\[\e[m\]@\h\[\e[34m\]\w\[\e[m\]\\$ "
# Debian colors
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# Kubectl editor
export KUBE_EDITOR=vim
EOF

cat >> /home/${username}/.bashrc << EOF
alias ls='ls --color=auto'
alias ll='ls -l'
alias ram='ps axch -o cmd:15,%mem --sort=-%mem | head'
alias cpu='ps axch -o cmd:15,%cpu --sort=-%cpu | head'
#export PS1="\[\e[31m\]\u\[\e[m\]@\h\[\e[34m\]\w\[\e[m\]\\$ "
# Debian colors
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# Kubectl editor
export KUBE_EDITOR=vim
EOF
chown ${username}:users /home/${username}/.bashrc

# VIM CUSTOMIZATIONS
cat > /home/${username}/.vimrc << EOF
syntax on
colorscheme slate
set mouse=v
EOF
cp /home/${username}/.vimrc /root/.vimrc
chown ${username}:users /home/${username}/.vimrc

# PREVENT AUTO LOGIN
#rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
#systemctl set-default graphical.target

# REMOVE ANNOYING BANNER
if [[ -f /etc/motd ]]; then
  mv /etc/motd /etc/motd.bak
fi

