dnfgroups="gnome-desktop fonts"
packages="xdg-utils chromium firefox gnome-shell-extension-dash-to-panel gnome-backgrounds \
neofetch virt-viewer podman-docker"
#google-droid-sans-fonts google-droid-serif-fonts google-droid-sans-mono-fonts google-noto-emoji-color-fonts
httpdownloadurls="https://f5vpn.geneseo.edu/public/download/linux_f5vpn.x86_64.rpm \
https://az764295.vo.msecnd.net/stable/c3511e6c69bb39013c4a4b7b9566ec1ca73fc4d5/code-1.67.2-1652812909.el7.x86_64.rpm"

# EPEL
dnf update -y
dnf install epel-release -y
dnf update -y

for group in ${dnfgroups}; do
  dnf group install -y ${group}
done

dnf install -y ${packages}

# Install from http links
for url in ${httpdownloadurls}; do
  # NF is the number of fields (also stands for the index of the last)
  file=$(echo ${url} | awk -F / '{print$NF}')
  wget ${url}
  rpm -Uvh ${file}
  rm -f ${file}
done

# Graphical target
systemctl set-default graphical.target
systemctl enable gdm

# Timezone
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

# AUTOSTART SCRIPT
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

##Firefox title bar and flex space
cat >> /etc/firefox-esr/firefox-esr.js << EOF
pref("browser.tabs.drawInTitlebar", true);
pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"home-button\",\"urlbar-container\",\"downloads-button\",\"library-button\",\"sidebar-button\",\"fxa-toolbar-menu-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\"],\"dirtyAreaCache\":[],\"currentVersion\":16,\"newElementCount\":2}");
EOF

# Permissions
#chmod +x ${BUILDDIR}/*.sh
#chown -R ${username}:users /home/${username}/
chown -R ${username}:users /home/${username}/