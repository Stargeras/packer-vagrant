#!/bin/bash

components=$(echo ${COMPONENTS} | sed "s/__/ /g")

packages="xserver-xorg-core xdg-user-dirs sudo ssh vim curl bash-completion git debootstrap arch-install-scripts \
firmware-realtek firmware-misc-nonfree firmware-libertas firmware-iwlwifi firmware-linux open-vm-tools"

cat > /etc/apt/sources.list << EOF
deb http://deb.debian.org/debian/ ${CODENAME} ${components}
deb-src http://deb.debian.org/debian/ ${CODENAME} ${components}

deb http://deb.debian.org/debian/ ${CODENAME}-updates ${components}
deb-src http://deb.debian.org/debian/ ${CODENAME}-updates ${components}
EOF

if [[ ${USESECURITYREPO} == "true" ]]; then
  cat >> /etc/apt/sources.list << EOF
deb http://deb.debian.org/debian-security/ ${CODENAME}-security ${components}
deb-src http://deb.debian.org/debian-security/ ${CODENAME}-security ${components}
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
cat > /home/${username}/.vimrc << EOF
syntax on
colorscheme slate
set hlsearch " highlights all results from / searches
set mouse=v " Prevents mouse from engaging virtual mode
set expandtab       " Use spaces instead of tabs
set tabstop=2      " Number of spaces that a <Tab> in the file counts for
set shiftwidth=2    " Number of spaces to use for each step of (auto)indent
set softtabstop=2   " Number of spaces that a <Tab> counts for while performing editing operations   set scrolloff=10   " Keeps cursor toward middle of screen
set number         " Shows line numbers
set wildmenu " Enhanced tab completion
set smartindent " indents newline to currentline
set clipboard=unnamedplus " Merges vim register with system clipboard
nnoremap <leader>e :Explore<CR>  " maps \e to explore mode
EOF
chown ${username}:users /home/${username}/.vimrc
cp /home/${username}/.gvimrc /root/


# GVIM CUSTOMIZATIONS
cat > /home/${username}/.gvimrc << EOF
color desert
set guifont=Monospace\ 12 " set font in gvim
EOF
chown ${username}:users /home/${username}/.gvimrc
cp /home/${username}/.gvimrc /root/
