#!/bin/bash
# Fixes issue where chromium based browers fail to launch.

sed -i "s:/usr/bin/chromium:/usr/bin/chromium --password-store=basic:g" /usr/share/applications/chromium.desktop

# Brave browser
#brave="/usr/share/applications/brave-browser.desktop"
#if [[ -f ${brave} ]]; then
#  sed -i "s:Exec=brave:Exec=brave --password-store=basic:g" ${brave}
#fi

# Source: https://bbs.archlinux.org/viewtopic.php?id=270871