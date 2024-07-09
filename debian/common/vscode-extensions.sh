#!/bin/bash

IFS="$FIELDSEPERATOR"
for extension in ${VSCODEEXTENSIONS}; do
  su ${username} -c "code --install-extension ${extension}"
done
unset IFS

config_file="/home/${username}/.config/Code/User/settings.json"
mkdir -p $(dirname ${config_file})
cat > ${config_file} << EOF
{
    "files.associations": {
        "*.tpl": "yaml"
    }
}
EOF
