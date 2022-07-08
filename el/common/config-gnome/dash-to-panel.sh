file="/home/${username}/.config/config.sh"
cat >> ${file} << EOF
# Extensions
# Dash-to-panel
gsettings set org.gnome.shell enabled-extensions "['dash-to-panel@gnome-shell-extensions.gcampax.github.com']"
dconf write /org/gnome/shell/extensions/dash-to-panel/panel-size 40
dconf write /org/gnome/shell/extensions/dash-to-panel/animate-show-apps false
dconf write /org/gnome/shell/extensions/dash-to-panel/appicon-margin 3
dconf write /org/gnome/shell/extensions/dash-to-panel/appicon-padding 3
dconf write /org/gnome/shell/extensions/dash-to-panel/show-window-previews false
dconf write /org/gnome/shell/extensions/dash-to-panel/trans-use-custom-opacity true
dconf write /org/gnome/shell/extensions/dash-to-panel/trans-panel-opacity 1.0
EOF
chown ${username}:users ${file}
chmod +x ${file}