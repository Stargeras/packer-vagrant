#!/bin/bash

vimextenstions=$(echo ${VIMEXTENSIONS} | sed "s/__/ /g")

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
set mouse=a
EOF
chown ${username}:users /home/${username}/.gvimrc
cp /home/${username}/.gvimrc /root/

# VIM EXTENSTIONS
extensiondir="/home/${username}/.vim/pack/plugins/start"
mkdir -p ${extensiondir}
for extension in $vimextensions; do
  cd ${extensiondir}
  git clone ${extension}
done