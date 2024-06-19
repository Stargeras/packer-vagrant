brewformulae=$(echo ${BREWFORMULAE} | sed "s/__/ /g")
brewtaps=$(echo ${BREWTAPS} | sed "s/__/ /g")
brewbin="/home/linuxbrew/.linuxbrew/bin"

echo "${username}" | su ${username} -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -S)"

echo "export PATH=${brewbin}:\$PATH" >> /home/${username}/.bashrc
echo "export PATH=${brewbin}:\$PATH" >> /root/.bashrc
export PATH=${brewbin}:$PATH

for tap in ${brewtaps}; do
  su ${username} -c "${brewbin}/brew tap ${tap}"
done

for formula in ${brewformulae}; do
  su ${username} -c "${brewbin}/brew install -vv ${formula}"
done
