string="nomodeset"

sed -i "s/${string} //g" /etc/default/grub

grub2-mkconfig -o /boot/grub2/grub.cfg

# The above does not modify any boot loader entries for some reason... Hard way it is.
for file in $(ls /boot/loader/entries/ | grep "x86_64"); do
  sed -i "s/${string} //g" /boot/loader/entries/${file}
done
