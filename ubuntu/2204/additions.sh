#!/bin/bash
file="/home/${username}/.config/config.sh"

cat >> ${file} << EOF
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-red'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-red'
EOF

chown ${username}:users ${file}
chmod +x ${file}