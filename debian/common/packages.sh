#!/bin/bash

packages=$(echo ${PACKAGES} | sed "s/,/ /g")

apt update
apt install -y ${packages}

# Install from http links
set IFS="$FIELDSEPERATOR"
for url in ${DEBURLS}; do
  # NF is the number of fields (also stands for the index of the last)
  file=$(echo ${url} | awk -F / '{print$NF}')
  wget ${url}
  dpkg -i ${file}
  rm -f ${file}
done
unset IFS
