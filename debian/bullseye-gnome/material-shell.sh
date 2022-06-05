#!/bin/bash

# Material-shell
#git clone https://github.com/material-shell/material-shell.git /usr/share/gnome-shell/extensions/material-shell@papyelgringo
url="https://github.com/material-shell/material-shell/archive/refs/tags/12.zip"
file=$(echo ${url} | awk -F / '{print$NF}')
dir="/usr/share/gnome-shell/extensions/material-shell@papyelgringo"
mkdir ${dir}
wget ${url}
unzip ${file} -d $(echo ${file} | awk -F . '{print $1}')
mv $(echo ${file} | awk -F . '{print $1}')/$(ls $(echo ${file} | awk -F . '{print $1}'))/* ${dir}/
rm -rf $(echo ${file} | awk -F . '{print $1}')*