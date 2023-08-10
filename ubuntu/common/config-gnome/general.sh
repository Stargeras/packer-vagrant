#!/bin/bash
file="/home/${username}/.config/config.sh"

favorites=$(echo ${FAVORITEAPPS} | sed "s/__/ /g")
favoritesstring="["
for fav in ${favorites}; do
  favoritesstring="${favoritesstring}'${fav}', "
done
favoritesstring="${favoritesstring::-2}]"

cat >> ${file} << EOF
gsettings set org.gnome.desktop.interface enable-animations false

# Favorite Apps
gsettings set org.gnome.shell favorite-apps "${favoritesstring}"

gsettings set org.gnome.desktop.interface text-scaling-factor ${GNOMESCALINGFACTOR}

# GEDIT
gsettings set org.gnome.gedit.preferences.editor scheme 'oblivion'
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true

# Nautilus
gsettings set org.gnome.nautilus.window-state initial-size '(1119, 604)'
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'small'

# Terminal
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant dark
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/bold-is-bright 'true'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ default-size-rows 33
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ default-size-columns 123

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

# imwheel config
cat > /home/vagrant/.imwheelrc << EOT
".*"
None,      Up,   Button4, 3
None,      Down, Button5, 3
Control_L, Up,   Control_L|Button4
Control_L, Down, Control_L|Button5
Shift_L,   Up,   Shift_L|Button4
Shift_L,   Down, Shift_L|Button5
EOT
imwheel -kill

EOF
chown ${username}:users ${file}
chmod +x ${file}
