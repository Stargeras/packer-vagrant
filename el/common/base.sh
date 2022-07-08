# Add /usr/local/bin to path for root user
echo "export PATH='/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin'" >> /root/.bashrc

# Timezone
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

# Make user part of wheel group
usermod -aG wheel ${username}