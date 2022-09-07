#!/bin/bash

file="/home/${username}/.config/config.sh"

cat >> ${file} << EOF
# Background
#gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Lakeside/Lakeside.xml'
#gsettings set org.gnome.desktop.background picture-uri-dark 'file:///usr/share/backgrounds/Lakeside/Lakeside.xml'
#gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/Lakeside/Lakeside.xml'

# GEDIT
gsettings set org.gnome.TextEditor style-scheme 'Adwaita'
gsettings set org.gnome.TextEditor style-variant 'dark'
gsettings set org.gnome.TextEditor show-line-numbers true

# FONT
dconf write /org/gnome/desktop/interface/monospace-font-name "'Liberation Mono 11'"
EOF

chown ${username}:users ${file}
chmod +x ${file}
