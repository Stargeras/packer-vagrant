file="/home/${username}/.config/config.sh"
cat >> ${file} << EOF
# Extensions
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height 'true'
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
dconf write /org/gnome/shell/extensions/dash-to-dock/background-opacity "'0.80'"
EOF
chown ${username}:users ${file}
chmod +x ${file}