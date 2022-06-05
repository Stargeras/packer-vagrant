#Yaru

apt install -y git meson sassc libglib2.0-dev
su ${username} -c "cd \${HOME} && git clone https://github.com/ubuntu/yaru.git"
su ${username} -c "cd \${HOME}/yaru && meson build"
su ${username} -c "sudo ninja -C \${HOME}/yaru/build/ install"
rm -rf /home/${username}/yaru