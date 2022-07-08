file="/home/${username}/.config/config.sh"

favorites=$(echo ${FAVORITEAPPS} | sed "s/__/ /g")
favoritesstring="["
for fav in ${favorites}; do
  favoritesstring+="'${fav}', "
done
favoritesstring="${favoritesstring::-2}]"

extensions=$(echo ${GNOMEEXTENSIONS} | sed "s/__/ /g")
extensionsstring="["
for extension in ${extensions}; do
  extensionsstring+="'${extension}', "
done
extensionsstring="${extensionsstring::-2}]"

cat >> ${file} << EOF
gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,maximize,close"
gsettings set org.gnome.desktop.interface enable-animations false
#gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/gnome/adwaita-timed.xml'

# Favorite Apps
gsettings set org.gnome.shell favorite-apps "${favoritesstring}"
#gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'nautilus.desktop', 'gnome-terminal.desktop']"

# Enable extensions
gsettings set org.gnome.shell enabled-extensions "${extensionsstring}"

# GEDIT
gsettings set org.gnome.gedit.preferences.editor scheme 'oblivion'
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true

# Nautilus
gsettings set org.gnome.nautilus.window-state initial-size '(1119, 604)'
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'small'

# Terminal
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant dark
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ default-size-rows 33
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ default-size-columns 123
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/bold-is-bright 'true'

# Keybindings
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Super>t'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'gnome-terminal'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'Terminal'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/binding "'<Super>e'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/command "'nautilus --new-window'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/name "'Nautilus'"

# clock format
gsettings set org.gnome.desktop.interface clock-format 12h
# disable suspend
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
# touchpad
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
EOF
chown ${username}:users ${file}
chmod +x ${file}
