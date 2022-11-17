#!/bin/bash

extensions=$(echo ${VSCODEEXTENSIONS} | sed "s/__/ /g")

for extension in ${extensions}; do
  su ${username} -c "code --install-extension ${extension}"
  echo "installed ${extension}"
done

echo "finished installing vscode extensions"