#!/bin/bash
file="/home/${username}/.config/config.sh"
cat >> ${file} << EOF
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/gnome/adwaita-timed.xml'
EOF