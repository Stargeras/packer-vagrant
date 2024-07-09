brewbin="/home/linuxbrew/.linuxbrew/bin"

echo "${username}" | su ${username} -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -S)"

export PATH=${brewbin}:$PATH

IFS="$FIELDSEPERATOR"
for tap in ${BREWTAPS}; do
  su ${username} -c "${brewbin}/brew tap ${tap}"
done

for formula in ${BREWFORMULAE}; do
  su ${username} -c "${brewbin}/brew install -vv ${formula}"
done
unset IFS
