# EPEL
dnf update -y
dnf install epel-release -y
dnf update -y

for group in ${DNFGROUPS}; do
  dnf group install -y ${group}
done

dnf install -y ${PACKAGES}

# Install from http links
for url in ${RPMURLS}; do
  # NF is the number of fields (also stands for the index of the last)
  file=$(echo ${url} | awk -F / '{print$NF}')
  wget ${url}
  rpm -Uvh ${file}
  rm -f ${file}
done