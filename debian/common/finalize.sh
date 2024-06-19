# Permissions
#chmod +x ${BUILDDIR}/*.sh
#chown -R ${username}:users /home/${username}/
chown -R ${username}:users /home/${username}/

# ADD USER TO DOCKER GROUP
if cat /etc/group | grep -q docker; then
  usermod -aG docker ${username}
fi
