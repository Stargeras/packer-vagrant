packages="virtualbox-guest-additions-iso \
make gcc perl"

apt install -y ${packages}

mount -o loop /usr/share/virtualbox/VBoxGuestAdditions.iso /mnt
echo "yes" | bash /mnt/VBoxLinuxAdditions.run
umount /mnt