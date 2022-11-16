# EPEL
dnf update -y
dnf install epel-release -y
dnf update -y

dnfgroups=$(echo ${DNFGROUPS} | sed "s/__/ /g")
packages=$(echo ${PACKAGES} | sed "s/__/ /g")
rpmurls=$(echo ${RPMURLS} | sed "s/__/ /g")

for group in ${dnfgroups}; do
  dnf group install -y ${group} --allowerasing
done

dnf install -y ${packages}

# Install from http links
for url in ${rpmurls}; do
  # NF is the number of fields (also stands for the index of the last)
  file=$(echo ${url} | awk -F / '{print$NF}')
  wget ${url}
  rpm -Uvh ${file}
  rm -f ${file}
done