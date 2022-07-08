#!/bin/bash

file="/home/${username}/.config/config.sh"

cat >> ${file} << EOF

# GEDIT
gsettings set org.gnome.TextEditor style-scheme 'Adwaita'
gsettings set org.gnome.TextEditor style-variant 'dark'
gsettings set org.gnome.TextEditor show-line-numbers true

# FONT
dconf write /org/gnome/desktop/interface/monospace-font-name "'Liberation Mono 11'"
EOF

chown ${username}:users ${file}
chmod +x ${file}
