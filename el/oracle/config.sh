file="/home/${username}/.config/config.sh"
cat > ${file} << EOF
gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,maximize,close"
gsettings set org.gnome.desktop.interface enable-animations false
#gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/gnome/adwaita-timed.xml'

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

# Extensions
# Dash-to-panel
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'nautilus.desktop', 'gnome-terminal.desktop']"
gsettings set org.gnome.shell enabled-extensions "['dash-to-panel@gnome-shell-extensions.gcampax.github.com']"
dconf write /org/gnome/shell/extensions/dash-to-panel/panel-size 40
dconf write /org/gnome/shell/extensions/dash-to-panel/animate-show-apps false
dconf write /org/gnome/shell/extensions/dash-to-panel/appicon-margin 3
dconf write /org/gnome/shell/extensions/dash-to-panel/appicon-padding 3
dconf write /org/gnome/shell/extensions/dash-to-panel/show-window-previews false
dconf write /org/gnome/shell/extensions/dash-to-panel/trans-use-custom-opacity true
dconf write /org/gnome/shell/extensions/dash-to-panel/trans-panel-opacity 1.0

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
