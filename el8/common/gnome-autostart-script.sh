mkdir -p /home/${username}/.config/autostart
cat > /home/${username}/.config/autostart/script.desktop << EOF
[Desktop Entry]
Name=script
GenericName=config script
Exec=/home/${username}/.config/config.sh
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true
EOF
chmod +x /home/${username}/.config/autostart/script.desktop
chown ${username}:users /home/${username}/.config/autostart/script.desktop