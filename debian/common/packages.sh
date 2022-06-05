#!/bin/bash

packages=$(echo ${PACKAGES} | sed "s/__/ /g")
deburls=$(echo ${DEBURLS} | sed "s/__/ /g")

apt update
apt install -y ${packages}

# Install from http links
for url in ${deburls}; do
  # NF is the number of fields (also stands for the index of the last)
  file=$(echo ${url} | awk -F / '{print$NF}')
  wget ${url}
  dpkg -i ${file}
  rm -f ${file}
done