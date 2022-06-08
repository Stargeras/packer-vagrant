#!/bin/bash

cp -r /usr/lib/sddm/sddm.conf.d /etc/
sed -i "s/Current=/Current=breeze/g" /etc/sddm.conf.d/default.conf
sed -i "s/CursorTheme=/CursorTheme=breeze_cursors/g" /etc/sddm.conf.d/default.conf