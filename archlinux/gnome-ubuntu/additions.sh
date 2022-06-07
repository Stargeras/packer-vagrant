#!/bin/bash

wallpaperurl="https://149366088.v2.pressablecdn.com/wp-content/uploads/2022/03/jammy-jellyfish-wallpaper.jpg"

# Download ubuntu wallpaper
wget ${wallpaperurl} -O /usr/share/backgrounds/ubuntu.jpg


file="/home/${username}/.config/config.sh"

cat >> ${file} << EOF
# Background
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/ubuntu.jpg'
gsettings set org.gnome.desktop.background picture-uri-dark 'file:///usr/share/backgrounds/ubuntu.jpg'
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/ubuntu.jpg'

# Theme
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-red'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-red'
gsettings set org.gnome.desktop.sound theme-name 'Yaru'

# Terminal
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-theme-colors "false"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/background-color "'rgb(48,10,36)'"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/foreground-color "'rgb(255,255,255)'"

# Extensions
gsettings set org.gnome.shell enabled-extensions "['dash-to-dock@micxgx.gmail.com']"
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
dconf write /org/gnome/shell/extensions/dash-to-dock/background-opacity "'0.80'"

# Fonts
gsettings set org.gnome.desktop.interface document-font-name 'Sans 11'
gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 13'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Bold 11'
EOF

chown ${username}:users ${file}
chmod +x ${file}
