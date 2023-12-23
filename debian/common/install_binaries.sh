#!/bin/bash

terraformversion=$(curl https://releases.hashicorp.com/terraform/ | grep href | grep -v alpha | grep -v beta | grep -v rc |sort -r | grep terraform_ | head -1 | awk -F _ '{print $NF}' | awk -F '<' '{print $1}')

urls="https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator \
https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl \
https://releases.hashicorp.com/terraform/${terraformversion}/terraform_${terraformversion}_linux_amd64.zip \
https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb"

# INSTALL FROM URLS
for url in ${urls}; do
  file=$(echo ${url} | awk -F / '{print $NF}')
  wget ${url}
  # IF ZIP FILE
  if $(echo ${file} | grep .zip >/dev/null 2>&1); then
    unzip ${file}
    newfile=$(echo ${file} | awk -F _ '{print $1}')
    chmod +x ${newfile}
    mv ${newfile} /usr/local/bin/
    rm -f ${file}
  # IF .DEB PACKAGE
  elif $(echo ${file} | grep .deb >/dev/null 2>&1); then
    dpkg -i ${file}
    rm -f ${file}
  # ELSE STANDARD BINARY
  else
    chmod +x ${file}
    mv ${file} /usr/local/bin/
  fi
done

# INSTALL HELM
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# INSTALL FLUXCD
curl -s https://fluxcd.io/install.sh | bash

# INSTALL AZ CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# ADD USER TO DOCKER GROUP
usermod -aG docker ${username}

# KUBECTL BASH COMPLETION
echo "source <(kubectl completion bash)" >> /home/${username}/.bashrc
echo "source <(kubectl completion bash)" >> /root/.bashrc
