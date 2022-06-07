file="/home/${username}/.config/config.sh"

cat >> ${file} << EOF
# Material-shell
gsettings set org.gnome.shell enabled-extensions "['material-shell@papyelgringo']"
gsettings set org.gnome.desktop.notifications show-banners false
dconf write /org/gnome/shell/extensions/materialshell/theme/panel-icon-style "'category'"
dconf write /org/gnome/shell/extensions/materialshell/theme/panel-size "40"
dconf write /org/gnome/shell/extensions/materialshell/layouts/split "false"
dconf write /org/gnome/shell/extensions/materialshell/layouts/half "false"
dconf write /org/gnome/shell/extensions/materialshell/layouts/grid "true"
dconf write /org/gnome/shell/extensions/materialshell/layouts/tween-time "0.0"
dconf write /org/gnome/shell/extensions/materialshell/layouts/gap "10"
dconf write /org/gnome/shell/extensions/materialshell/theme/blur-background "true"
dconf write /org/gnome/shell/extensions/materialshell/theme/horizontal-panel-position "'top'"
dconf write /org/gnome/shell/extensions/materialshell/bindings/cycle-tiling-layout "['<Super>f']"
EOF

chown ${username}:users ${file}
chmod +x ${file}
