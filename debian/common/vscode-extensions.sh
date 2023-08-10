#!/bin/bash

extensions=$(echo ${VSCODEEXTENSIONS} | sed "s/__/ /g")

for extension in ${extensions}; do
  su ${username} -c "code --install-extension ${extension}"
done

config_file="/home/${username}/.config/Code/User/settings.json"
mkdir -p $(dirname ${config_file})
cat > ${config_file} << EOF
{
    "files.associations": {
        "*.tpl": "yaml"
    }
}
EOF