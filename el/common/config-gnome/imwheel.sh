file="/home/${username}/.config/config.sh"

cat >> ${file} << EOF
# imwheel config
cat > /home/${username}/.imwheelrc << EOT
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