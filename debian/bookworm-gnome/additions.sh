#!/bin/bash
file="/home/${username}/.config/config.sh"
cat >> ${file} << EOF
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'small'
EOF
